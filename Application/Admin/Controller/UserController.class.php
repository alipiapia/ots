<?php
// +----------------------------------------------------------------------
// | No Think [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.fartry.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use User\Api\UserApi;

/**
 * 后台用户控制器
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
class UserController extends AdminController {

    /**
     * 用户管理首页
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function index(){
        $nickname       =   I('nickname');

        $map['status']  =   array('egt',0);
        
        if(is_numeric($nickname)){
            $map['uid|nickname']=   array(intval($nickname),array('like','%'.$nickname.'%'),'_multi'=>true);
        }else{
            $map['nickname']    =   array('like', '%'.(string)$nickname.'%');
        }

        $list   = $this->lists('Member', $map);
        int_to_string($list);
        $this->assign('_list', $list);
        $this->meta_title = '用户信息';
        $this->display();
    }

    /**
     * 修改昵称初始化
     * @author alipiapia <124910168@qq.com>
     */
    public function updateNickname(){
        $nickname = M('Member')->getFieldByUid(UID, 'nickname');
        $this->assign('nickname', $nickname);
        $this->meta_title = '修改昵称';
        $this->display();
    }

    /**
     * 修改昵称提交
     * @author alipiapia <124910168@qq.com>
     */
    public function submitNickname(){
        //获取参数
        $nickname = I('post.nickname');
        $password = I('post.password');
        empty($nickname) && $this->error('请输入昵称');
        empty($password) && $this->error('请输入密码');

        //密码验证
        $User   =   new UserApi();
        $uid    =   $User->login(UID, $password, 4);
        ($uid == -2) && $this->error('密码不正确');

        $Member =   D('Member');
        $data   =   $Member->create(array('nickname'=>$nickname));
        if(!$data){
            $this->error($Member->getError());
        }

        $res = $Member->where(array('uid'=>$uid))->save($data);

        if($res){
            $user               =   session('user_auth');
            $user['username']   =   $data['nickname'];
            session('user_auth', $user);
            session('user_auth_sign', data_auth_sign($user));
            $this->success('修改昵称成功！');
        }else{
            $this->error('修改昵称失败！');
        }
    }

    /**
     * 修改密码初始化
     * @author alipiapia <124910168@qq.com>
     */
    public function updatePassword(){
        $this->meta_title = '修改密码';
        $this->display();
    }

    /**
     * 修改密码提交
     * @author alipiapia <124910168@qq.com>
     */
    public function submitPassword(){
        //获取参数
        $password   =   I('post.old');
        empty($password) && $this->error('请输入原密码');
        $data['password'] = I('post.password');
        empty($data['password']) && $this->error('请输入新密码');
        $repassword = I('post.repassword');
        empty($repassword) && $this->error('请输入确认密码');

        if($data['password'] !== $repassword){
            $this->error('您输入的新密码与确认密码不一致');
        }

        $Api    =   new UserApi();
        $res    =   $Api->updateInfo(UID, $password, $data);
        if($res['status']){
            $user_info = session('user_auth');
            $agent_info = M("Agents")->where(array('id' => $user_info['uid']))->setField(array('password' => think_ucenter_md5($data['password'], UC_AUTH_KEY)));
            $this->success('修改密码成功！');
        }else{
            $this->error($res['info']);
        }
    }

    /**
     * 用户行为列表
     * @author alipiapia <124910168@qq.com>
     */
    public function action(){
        //获取列表数据
        $Action =   M('Action')->where(array('status'=>array('gt',-1)));
        $list   =   $this->lists($Action);
        int_to_string($list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        $this->assign('_list', $list);
        $this->meta_title = '用户行为';
        $this->display();
    }

    /**
     * 新增行为
     * @author alipiapia <124910168@qq.com>
     */
    public function addAction(){
        $this->meta_title = '新增行为';
        $this->assign('data',null);
        $this->display('editaction');
    }

    /**
     * 编辑行为
     * @author alipiapia <124910168@qq.com>
     */
    public function editAction(){
        $id = I('get.id');
        empty($id) && $this->error('参数不能为空！');
        $data = M('Action')->field(true)->find($id);

        $this->assign('data',$data);
        $this->meta_title = '编辑行为';
        $this->display();
    }

    /**
     * 更新行为
     * @author alipiapia <124910168@qq.com>
     */
    public function saveAction(){
        $res = D('Action')->update();
        if(!$res){
            $this->error(D('Action')->getError());
        }else{
            $this->success($res['id']?'更新成功！':'新增成功！', Cookie('__forward__'));
        }
    }

    /**
     * 会员状态修改
     * @author 朱亚杰 <zhuyajie@topthink.net>
     */
    public function changeStatus($method=null){
        $id = array_unique((array)I('id',0));
        if( in_array(C('USER_ADMINISTRATOR'), $id)){
            $this->error("不允许对超级管理员执行该操作!");
        }
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['uid'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'forbiduser':
                $this->forbid('Member', $map );
                break;
            case 'resumeuser':
                $this->resume('Member', $map );
                break;
            case 'deleteuser':
                $this->delete('Member', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }

    public function add($username = '', $password = '', $repassword = '', $email = '', $mobile = ''){
        if(IS_POST){
            // p($_POST);
            /* 检测密码 */
            if($password != $repassword){
                $this->error('密码和重复密码不一致！');
            }
            if(!$_POST['username'])$this->error("用户名称不能为空！");
            if(!$_POST['real_name'])$this->error("真实姓名不能为空！");
            if(!$_POST['id_no'])$this->error("身份证不能为空！");
            if(!$_POST['email'])$this->error("邮箱不能为空！");
            if(!$_POST['mobile'])$this->error("手机号码不能为空！");
            if(!$_POST['region'])$this->error("地区不能为空！");
            if(!$_POST['wx_id'])$this->error("微信号码不能为空！");
            if(!$_POST['agent_product'])$this->error("授权品牌不能为空！");
            if(!preg_match("/^1[34578]\d{9}$/", $_POST['mobile']))$this->error("手机号码格式错误！");
            if(!preg_match("/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/", $_POST['id_no']))$this->error("身份证号码格式错误！");
            if(M("Agents")->where(array('id_no' => $_POST['mobile']))->find())$this->error("手机号码已被使用！");
            if(M("Agents")->where(array('id_no' => $_POST['id_no']))->find())$this->error("身份证号码已被使用！");
            if(M("Agents")->where(array('id_no' => $_POST['mobile']))->find())$this->error("邮箱已被使用！");
            // if(!$_POST['company'])$this->error("公司名称不能为空！");

            /* 调用注册接口注册用户 */
            $User   =   new UserApi;
            $uid    =   $User->register($username, $password, $email, $mobile);
            if(0 < $uid){ //注册成功
                $user = array('uid' => $uid, 'nickname' => $username, 'reg_time' => time(), 'last_login_time' => time(), 'status' => 1);
                if(!M('Member')->add($user)){
                    $this->error('用户添加失败！');
                } else {

                    /*更新注册代理商信息*/
                    $u_member = M("UcenterMember")->where(array('id' => $uid))->find();
                    $agent_data = array_merge($_POST, $u_member, array('status' => 0));
                    $gent_id = M("Agents")->add($agent_data);

                    /*添加后台代理商权限信息*/
                    // M("AuthGroupAccess")->add(array('uid' => $gent_id, 'group_id' => '1'));

                    $this->success('用户添加成功！',U('index'));
                }
            } else { //注册失败，显示错误信息
                $this->error($this->showRegError($uid));
            }
        } else {

            /*  代理商等级下拉菜单 */
            $glist = M('AgentsGrade')->select();
            foreach ($glist as $k => $v) {
                $glist[$k]['title_show'] = $v['title'];
            }
            $menus = D('Common/Tree')->toFormatTree($glist);
            $menus = array_merge(array(0=>array('id'=>0,'title_show'=>'公司总部')), $menus);
            $this->assign('Menus', $menus);

            /*  上级代理商 */
            $alist = M('Agents')->select();
            // p($alist);
            foreach ($alist as $k => $v) {
                $alist[$k]['title_show'] = $alist[$k]['title'] = $v['username'];
            }
            // p($alist);
            $pmenus = D('Common/Tree')->toFormatTree($alist);
            $pmenus = array_merge(array(0=>array('id'=>0,'title_show'=>'公司总部')), $pmenus);
            $this->assign('PMenus', $pmenus);

            $this->assign('info', null);
            $this->meta_title = '新增用户';
            $this->display();
        }
    }

    /**
     * 删除
     * @author alipiapia <124910168@qq.com>
     */
    public function del(){
        $id = array_unique((array)I('id',0));
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $map = array('id' => array('in', $id) );
        $agent_member = M('Agents')->where($map)->delete();
        $home_member = M("UcenterMember")->where($map)->delete();
        $admin_member = M("Member")->where(array('uid' => array('in', $id) ))->delete();
        // $auth_member = M("AuthGroupAccess")->delete(array('uid' => array('in', $id), 'group_id' => '1'));
        if($agent_member | $home_member | $admin_member | $auth_member){
            $this->success('删除成功');
        }else{
            $this->error('删除失败！');
        }
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
     * 修改资料初始化
     * @author alipiapia <124910168@qq.com>
     */
    public function updateProfile(){
        $member_info = M('Agents')->find(UID);
        $this->assign('info', $member_info);
        $this->meta_title = '完善资料';
        $this->display();
    }

    /**
     * 修改资料提交
     * @author alipiapia <124910168@qq.com>
     */
    public function submitProfile(){
        //获取参数
        $data['region'] = I('post.region');
        $data['company'] = I('post.company');
        empty($data['region']) && $this->error('请输入地区名称');
        empty($data['company']) && $this->error('请输入公司名称');

        $up_id = M("Agents")->where(array('id' => UID))->setField($data);
        $up_id ? $this->success("修改成功！") : $error("修改失败！");
    }

    public function insert(){
      $this->assign('title','首页信息');
    }
}
