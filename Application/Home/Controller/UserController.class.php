<?php
// +----------------------------------------------------------------------
// | No Think [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.fartry.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;
use User\Api\UserApi;

/**
 * 用户控制器
 * 包括用户中心，用户登录及注册
 */
class UserController extends HomeController {

	/* 用户中心首页 */
	public function index(){
		
	}

	/* 注册页面 */
	public function register($username = '', $password = '', $repassword = '', $email = '', $verify = '', $xcode='', $mobile=''){
        if(!C('USER_ALLOW_REGISTER')){
            $this->error('注册已关闭');
        }
		if(IS_POST){ //注册用户

			/* 检测验证码 */
			// if(!check_verify($verify)){
			// 	$this->error('验证码输入错误！');
			// }

			/* 检测密码 */
			if($password != $repassword){
				$this->error('密码和重复密码不一致！');
			}

			/* 检测邀请码有效性 */
			// P($xcode);
			if(!$mobile)$this->error('手机号码格式错误！');
			if(!$xcode)$this->error('邀请码不能为空！');
			if(!check_xcode($xcode))$this->error('邀请码无效！');

			/* 调用注册接口注册用户 */
            $User = new UserApi;
			$uid = $User->register($username, $password, $email, $mobile);
			if(0 < $uid){ //注册成功

				/*更新注册代理商信息*/
				$u_member = M("UcenterMember")->where(array('id' => $uid))->find();
				$pid = M("InvCode")->where(array('xcode' => $xcode))->getField('create_admin');
				$parent_grade = M("Agents")->where(array('id' => $pid))->getField('agent_grade');
				$cur_grade = M("AgentsGrade")->where(array('pid' => $parent_grade))->getField('id') ? M("AgentsGrade")->where(array('pid' => $parent_grade))->getField('id') : M("AgentsGrade")->where(array('id' => $parent_grade))->getField('id');
				$agent_data = array_merge($u_member, array('pid' => $pid),array('agent_grade' => $cur_grade), array('status' => 0));
				$gent_id = M("Agents")->add($agent_data);

				/*添加后台用户*/
				$admin_member_data = array_merge($u_member,array('uid' => $uid,'nickname' => $username, 'status' => 1));
				M("Member")->add($admin_member_data);

				/*添加后台代理商权限信息*/
				// M("AuthGroupAccess")->add(array('uid' => $gent_id, 'group_id' => '1'));

				/*更新邀请码使用情况*/
				$code_data['use_admin'] = $uid;//使用者
				$code_data['use_time'] = time();//使用时间
				$code_data['status'] = '1';//使用状态
				M("InvCode")->where(array('xcode' => $xcode))->save($code_data);

				//TODO: 发送验证邮件
				$this->success('注册成功！', U('Home/User/login'));
			} else { //注册失败，显示错误信息
				$this->error($this->showRegError($uid));
			}

		} else { //显示注册表单
        	$this->assign("meta_title", "注 册");
			$this->display();
		}
	}

	/* 登录页面 */
	public function login($username = '', $password = '', $verify = ''){
		if(IS_POST){ //登录验证
		// p($_POST);
			/* 检测验证码 */
			// if(!check_verify($verify)){
			// 	$this->error('验证码输入错误！');
			// }

			/* 调用UC登录接口登录 */
			$user = new UserApi;
			$uid = $user->login($username, $password);
			if(0 < $uid){ //UC登录成功
				/* 登录用户 */
				$Member = D('Member');
				if($Member->login($uid)){ //登录用户
					//TODO:跳转到登录前页面
					$this->success('欢迎回来，'. get_username($uid) .'！',U('Home/Index/index'));
				} else {
					$this->error($Member->getError());
				}

			} else { //登录失败
				switch($uid) {
					case -1: $error = '用户不存在或被禁用！'; break; //系统级别禁用
					case -2: $error = '密码错误！'; break;
					default: $error = '未知错误！'; break; // 0-接口参数错误（调试阶段使用）
				}
				$this->error($error);
			}

		} else { //显示登录表单
        	$this->assign("meta_title", "登 录");
			$this->display();
		}
	}

	/* 退出登录 */
	public function logout(){
		$uid = is_login();
		if(is_login()){
			D('Member')->logout();
			$this->success('再见，'. get_username($uid) .'！', U('User/login'));
		} else {
			$this->redirect('User/login');
		}
	}

	/* 验证码，用于登录和注册 */
	public function verify(){
		$verify = new \Think\Verify();
		$verify->entry(1);
	}

	/**
	 * 获取用户注册错误信息
	 * @param  integer $code 错误编码
	 * @return string        错误信息
	 */
	private function showRegError($code = 0){
		switch ($code) {
			case -1:  $error = '用户名长度必须在16个字符以内！'; break;
			case -2:  $error = '用户名被禁止注册！'; break;
			case -3:  $error = '用户名被占用！'; break;
			case -4:  $error = '密码长度必须在6-30个字符之间！'; break;
			case -5:  $error = '邮箱格式不正确！'; break;
			case -6:  $error = '邮箱长度必须在1-32个字符之间！'; break;
			case -7:  $error = '邮箱被禁止注册！'; break;
			case -8:  $error = '邮箱被占用！'; break;
			case -9:  $error = '手机格式不正确！'; break;
			case -10: $error = '手机被禁止注册！'; break;
			case -11: $error = '手机号被占用！'; break;
			default:  $error = '未知错误';
		}
		return $error;
	}


    /**
     * 修改密码提交
     * @author alipiapia <124910168@qq.com>
     */
    public function profile(){
		if ( !is_login() ) {
			$this->error( '您还没有登陆',U('User/login') );
		}
        if ( IS_POST ) {
            //获取参数
            $uid        =   is_login();
            $password   =   I('post.old');
            $repassword = I('post.repassword');
            $data['password'] = I('post.password');
            empty($password) && $this->error('请输入原密码');
            empty($data['password']) && $this->error('请输入新密码');
            empty($repassword) && $this->error('请输入确认密码');

            if($data['password'] !== $repassword){
                $this->error('您输入的新密码与确认密码不一致');
            }

            $Api = new UserApi();
            $res = $Api->updateInfo($uid, $password, $data);
            if($res['status']){
	            $user_info = session('user_auth');
	            $agent_info = M("Agents")->where(array('id' => $user_info['uid']))->setField(array('password' => think_ucenter_md5($data['password'], UC_AUTH_KEY)));
                $this->success('修改密码成功！');
            }else{
                $this->error($res['info']);
            }
        }else{
        	$this->assign("meta_title", "密码修改");
            $this->display();
        }
    }


    /**
     * 实名认证
     * @author alipiapia <124910168@qq.com>
     */
    public function real_auth(){
		if ( !is_login() ) {
			$this->error( '您还没有登陆',U('User/login') );
		}
		$agent_info = M("Agents")->where(array('id' => is_login()))->find();
		if($agent_info['is_review'] == 1)$this->error("已通过审核，请勿重复操作！");
        if ( IS_POST ) {
        	// p($_POST);
            //获取参数
            $uid        =   is_login();
            $data['real_name']   =   I('post.real_name');
            $data['id_no'] = I('post.id_no');
            $data['wx_id'] = I('post.wx_id');
            // $password = I('post.password');
            // empty($password) && $this->error('请输入密码');
            empty($data['real_name']) && $this->error('请输入姓名');
            empty($data['id_no']) && $this->error('请输入身份证号码');
            empty($data['wx_id']) && $this->error('请输入微信号');
            if(!preg_match("/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/", $data['id_no']))$this->error("身份证号码格式错误！");
            if($data['id_no'] == $agent_info['id_no'])$this->error("身份证号码已被认证！");
            // if(!preg_match("/^(\d{3})-(\d{3})-(\d{4})$/", $data['id_no'])){
            // 	$this->error("手机号码格式错误！");die;
            // }else{
            // 	$this->success("手机号码格式正确！");die;
            // }

            // $Api = new UserApi();
            // $res = $Api->updateInfo($uid, $password, $data);
            $user_info = session('user_auth');
            $agent_info = M("Agents")->where(array('id' => $user_info['uid']))->setField($data);
            // p($user_info);
            if($agent_info){
                $this->success('信息提交成功，请耐心等待管理员审核！');
            }else{
                $this->error("添加失败，请重试！");
            }
        }else{
        	$this->assign("info", $agent_info);
        	$this->assign("meta_title", "实名认证");
            $this->display();
        }
    }

    /**
     * 资料完善提交
     * @author alipiapia <124910168@qq.com>
     */
    public function updateProfile(){
		if ( !is_login() ) {
			$this->error( '您还没有登陆',U('User/login') );
		}
        $uid        =   is_login();
        if ( IS_POST ) {
            //获取参数
            // p($_POST);
            // $data['wx_id'] = I('post.wx_id');
            $data['region'] = I('post.region');
            $data['company'] = I('post.company');
            // empty($data['wx_id']) && $this->error('请输入微信ID');
            empty($data['region']) && $this->error('请输入地区名称');
            empty($data['company']) && $this->error('请输入公司名称');

            $up_id = M("Agents")->where(array('id' => $uid))->setField($data);
        	$up_id ? $this->success("修改成功！") : $this->error("修改失败！");
        }else{
	        $member_info = M('Agents')->find($uid);
	        $this->assign('info', $member_info);
	        $this->meta_title = '完善资料';
	        $this->display();
        }
    }

    /**
     * 忘记密码
     * @author alipiapia <124910168@qq.com>
     */
    public function forget_pass(){
        if ( IS_POST ) {
            //获取参数
            // p($_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
            $username = I('post.username');
            $email = I('post.email');
            empty($username) && $this->error('请输入用户名');
            empty($email) && $this->error('请输入邮箱地址');

            $v_code = get_v_code();
            $uid = M("Agents")->where(array('username' => $username))->find();
            if($email != $uid['email'])$this->error("邮箱无法匹配到该用户！");
            $bak_info = M("MemberBak")->add(array('username' => $username, 'v_code' => $v_code, 'uid' => $uid['id'], 'begin_time' => time()));

            $title = "用户：". $username ."密码找回";
            $sv = $_SERVER['HTTP_HOST'];
            // $sr = $_SERVER['REQUEST_URI'];
            $sr = '/ot/index.php/Home/User/mod_pass.html';
            // $url = $sv.$sr. '/v_code/' .get_v_code();
            $url = $sv.U('mod_pass', array('v_code' => $v_code));
            // $contents = "<a href=".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']. '?v_code/' .get_v_code()."></a>";
            // $sv = $_SERVER['HTTP_HOST'];
            // $content = '<a href='.$sv.'></a>';
            // p(U('mod_pass', array('v_code' => get_v_code())));
            $content = "亲爱的 ".$username."：<br/>您在".$sv."提交了找回密码请求。请点击下面的链接重置密码 （按钮24小时内有效）。<br/>
            <a href='".$url."' target='_blank'>".$url."</a><br/>(如果上面不是链接形式，请将该地址手工粘贴到浏览器地址栏再访问)"; 

            $$send_id = $this->sendMail($email, $title,$content);
        	$$send_id ? $this->success("邮件发送成功，请登录邮箱进行确认！") : $this->error("邮件发送失败，请重试！");
        }else{
	        $this->meta_title = '忘记密码';
	        $this->display();
        }
    }

    /**
     * 找回密码
     * @author alipiapia <124910168@qq.com>
     */
    public function mod_pass(){
        $v_code = I('v_code');
        $member_bak = M("MemberBak")->where(array('v_code' => $v_code))->find();
        // p($member_bak);
        if($member_bak && ((time() - $member_bak['begin_time']) < 86400) && ($member_bak['status'] == 0)){
        	//有效
	        if ( IS_POST ) {
	        	//修改密码
	        	// p($_POST);
                $new_pass = $this->think_ucenter_md5($_POST['password'], C(DATA_AUTH_KEY));
                $pass_data = array('password' => $new_pass);
                $uc_id = M('UcenterMember')->where(array('id' => $_POST['uid']))->setField($pass_data);
                $insert_id = M('Agents')->where(array('id' => $_POST['uid']))->setField($pass_data);
                if($insert_id && $uc_id){
                	M("MemberBak")->where(array('v_code' => $_POST['v_code']))->setField(array('status' => 1));
                	$this->success("密码修改成功！", U('Home/User/login'));
	            }else{
	                $this->error("密码修改失败！");
	            }
	        }else{
	        	$this->assign("member_bak", $member_bak);
		        $this->meta_title = '重置密码';
		        $this->display();
	        }
        }else{
        	//无效
        	$this->error("验证已过期！");
        }
    }


    /**
 * 邮件发送函数
 */
    public function sendMail($to, $title, $content) {
        //      import("Org.Util.PHPExcel");
        // $PHPExcel=new \PHPExcel();
        // Vendor('PHPMailer.PHPMailerAutoload'); 
        import("Org.Util.Mail");    
        $mail = new \PHPMailer(); //实例化
        // $mail->Port = C(MAIL_PORT); 
		// $mail->SMTPSecure = C(MAIL_SECURE); 
        $mail->IsSMTP(); // 启用SMTP
        $mail->Host=C('MAIL_HOST'); //smtp服务器的名称（这里以QQ邮箱为例）
        $mail->SMTPAuth = C('MAIL_SMTPAUTH'); //启用smtp认证
        $mail->Username = C('MAIL_USERNAME'); //你的邮箱名
        $mail->Password = C('MAIL_PASSWORD') ; //邮箱密码
        $mail->From = C('MAIL_FROM'); //发件人地址（也就是你的邮箱地址）
        $mail->FromName = C('MAIL_FROMNAME'); //发件人姓名
        $mail->AddAddress($to,"尊敬的客户");
        $mail->WordWrap = 50; //设置每行字符长度
        $mail->IsHTML(C('MAIL_ISHTML')); // 是否HTML格式邮件
        $mail->CharSet=C('MAIL_CHARSET'); //设置邮件编码
        $mail->Subject =$title; //邮件主题
        $mail->Body = $content; //邮件内容
        $mail->AltBody = "这是一个纯文本的身体在非营利的HTML电子邮件客户端"; //邮件正文不支持HTML的备用显示
        return($mail->Send());
    }

    public function think_ucenter_md5($str, $key = 'ThinkUCenter'){
        return '' === $str ? '' : md5(sha1($str) . $key);
    }

}
