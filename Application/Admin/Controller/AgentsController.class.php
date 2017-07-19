<?php
// +----------------------------------------------------------------------
// | alipiapia [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://www.2he87.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: alipiapia <124910168@qq.com> <http://www.2he87.com.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use User\Api\UserApi;
use Admin\Controller\UserController;

/**
 * 后台代理商控制器
 * @author alipiapia <124910168@qq.com>
 */
class AgentsController extends AdminController {

    /**
     * 代理商首页
     * @author alipiapia <124910168@qq.com>
     */
    public function index(){
        $this->meta_title = '代理商首页';
        // $agent_info = M("Agents")->where(array('pid' => UID))->field("username,pid")->select();
        // $agent_json = $this->loopToDie("Agents", UID);
        // $this->assign("agent_json", json_encode($agent_json));
        $this->display();
    }


    public function index_tree(){
        $this->meta_title = '代理商列表(树形)';
        $agent_json = $this->loopToDie("Agents", UID);
        $this->assign("agent_json", json_encode($agent_json));
        $this->display();
    }

    /**
     * 递归成树结构
     * @author alipiapia <124910168@qq.com>
     */
    public function loopToDie($m, $pid){
        $agent_info = M($m)->where(array('pid' => $pid))->field("id,username,agent_grade")->select();
        foreach ($agent_info as $k => $v) {
            $new_agent[$k]['name'] = $v['username'].' ['.getTitleByPid($v['agent_grade']).']';
            // $new_agent[$k]['title'] = getTitleByPid($v['agent_grade']);
            $new_pid = M($m)->where(array('pid' => $v['id']))->field("id,username,agent_grade")->select();
            if($new_pid){
                $new_agent[$k]['open'] = true;
                $new_agent[$k]['children'] = $this->loopToDie($m, $v['id']);
            }
            unset($v['id']);
        }

        return $new_agent;
    }

    /**
     * 代理商列表
     * @author alipiapia <124910168@qq.com>
     */
    public function a_list(){

        $username = I('username');
        
        if(is_numeric($username)){
            $map['id|pid|username'] = array(intval($username),intval($username),array('like','%'.$username.'%'),'_multi'=>true);
        }else{
            $pids = M("Agents")->where(array('username' => array('like','%'.(string)$username.'%')))->getField("id");
            $map['username|pid'] =   array(array('like','%'.(string)$username.'%'),intval($pids),'_multi'=>true);
        }

        $user_info = session('user_auth');

        if(UID != 1){
            $map['pid'] = $user_info['uid'];
        }

        $this->data = $this->lists("Agents", $map);
        $this->meta_title = '代理商列表';
        $this->display();
    }


    /**
     * 查看
     * @author alipiapia <124910168@qq.com>
     */
    public function view(){
        $id = I('id');
        $agent_info = M("Agents")->where(array('id' => $id))->find();
        $cert_pic = M("Certs")->where(array('cert_admin' => $id))->getField("pic_url");
        $agent_info = array_merge($agent_info, array('cert_pic' => $cert_pic));
        // p($agent_info);
        $this->assign("info", $agent_info);
        $this->meta_title = '代理商详情';
        $this->display();
        // p($agent_info);
    }

    /**
     * 添加代理商
     * @author alipiapia <124910168@qq.com>
     */
    public function add(){
        if(IS_POST){
            $posts = I('post.');
            // p($posts);
            if(!$posts['username'])$this->error("用户名称不能为空！");
            if(!$posts['real_name'])$this->error("真实姓名不能为空！");
            if(!$posts['id_no'])$this->error("身份证不能为空！");
            if(!$posts['email'])$this->error("邮箱不能为空！");
            if(!$posts['mobile'])$this->error("手机号码不能为空！");
            if(!$posts['wx_id'])$this->error("微信号码不能为空！");
            if(!$posts['region'])$this->error("地区不能为空！");
            if(!$posts['mobile'])$this->error("手机号码不能为空！");
            if(!$posts['agent_product'])$this->error("授权品牌不能为空！");
            if(!preg_match("/^1[34578]\d{9}$/", $posts['mobile']))$this->error("手机号码格式错误！");
            if(!preg_match("/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/", $posts['id_no']))$this->error("身份证号码格式错误！");
            if(M("Agents")->where(array('id_no' => $posts['mobile']))->find())$this->error("手机号码已被使用！");
            if(M("Agents")->where(array('id_no' => $posts['id_no']))->find())$this->error("身份证号码已被使用！");
            if(M("Agents")->where(array('id_no' => $posts['mobile']))->find())$this->error("邮箱已被使用！");
            // if(!$posts['company'])$this->error("公司名称不能为空！");

            /* 调用注册接口注册用户 */
            $User = new UserApi;
            $uid = $User->register($posts['username'], $posts['password'], $posts['email'], $posts['mobile']);
            if(0 < $uid){ //注册成功

                /* 更新前台用户表 */
                $ucenter_member = M("UcenterMember")->where(array('id' => $uid))->find();
                $agent_data = array_merge( $posts,$ucenter_member, array('status' => 0));
                $gent_id = M("Agents")->add($agent_data);

                /*添加后台用户*/
                $admin_member_data = array_merge($ucenter_member,array('uid' => $uid,'nickname' => $posts['username'], 'status' => 1));
                M("Member")->add($admin_member_data);

                /*添加后台代理商权限信息*/
                // M("AuthGroupAccess")->add(array('uid' => $uid, 'group_id' => '1'));

                // $insert_id = M('Agents')->add($_POST);
                $gent_id ? $this->success('添加成功', U('a_list')) : $this->error('添加失败！');
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
            $this->meta_title = '新增代理商';
            $this->display();
        }
    }

    /**
     * 编辑
     * @author alipiapia <124910168@qq.com>
     */
    public function edit(){
        $id = I("id");
        if(!$id)$this->error("找不到用户！");
        if(IS_POST){
            // p($_POST);
            // $this->error($_POST['password']);
            if(!$_POST['username'])$this->error("用户名称不能为空！");
            if(!$_POST['real_name'])$this->error("真实姓名不能为空！");
            if(!$_POST['id_no'])$this->error("身份证不能为空！");
            if(!$_POST['email'])$this->error("邮箱不能为空！");
            if(!$_POST['mobile'])$this->error("手机号码不能为空！");
            if(!$_POST['wx_id'])$this->error("微信号码不能为空！");
            if(!$_POST['region'])$this->error("地区不能为空！");
            if(!$_POST['agent_product'])$this->error("授权品牌不能为空！");
            if(!preg_match("/^1[34578]\d{9}$/", $_POST['mobile']))$this->error("手机号码格式错误！");
            if(!preg_match("/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/", $_POST['id_no']))$this->error("身份证号码格式错误！");
            if(M("Agents")->where(array('id' => array('neq', $id), 'id_no' => $_POST['mobile']))->find())$this->error("手机号码已被使用！");
            if(M("Agents")->where(array('id' => array('neq', $id), 'id_no' => $_POST['id_no']))->find())$this->error("身份证号码已被使用！");
            if(M("Agents")->where(array('id' => array('neq', $id), 'id_no' => $_POST['mobile']))->find())$this->error("邮箱已被使用！");
            if($_POST['password']){
                $o_pass = M("UcenterMember")->where(array('id' => $id))->getField("password");
                $_POST['password'] = $this->think_ucenter_md5($_POST['password'], C(DATA_AUTH_KEY));
            }else{
                unset($_POST['password']);
            }
            // $this->error(C(DATA_AUTH_KEY));
            // $Api = new UserApi();
            // $res = $Api->updateInfo($id, $o_pass, $_POST);
            // if($res['status']){
                // $user_info = session('user_auth');
                // $_POST['password'] = $this->think_ucenter_md5($_POST['password'], C(DATA_AUTH_KEY));
                // $this->error($_POST['password']);
                $uc_id = M('UcenterMember')->where(array('id' => $id))->setField(array_merge($_POST, array('status' => 1)));
                $insert_id = M('Agents')->where(array('id' => $id))->setField($_POST);
            // }
            $insert_id ? $this->success('编辑成功', U('a_list')) : $this->error('编辑失败！');
        } else {
            $list = M('Agents')->where(array('id' => $id))->find();
            $this->assign('info', $list);

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
            foreach ($alist as $k => $v) {
                $alist[$k]['title_show'] = $alist[$k]['title'] = $v['username'];
            }
            $pmenus = D('Common/Tree')->toFormatTree($alist);
            $pmenus = array_merge(array(0=>array('id'=>0,'title_show'=>'公司总部')), $pmenus);
            $this->assign('PMenus', $pmenus);

            $this->meta_title = '编辑代理商';
            $this->display("add");
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
     * 审核
     * @author alipiapia <124910168@qq.com>
     */
    public function review(){
        // if(file_exists("./Uploads/Certs/cert-pp1899-2016-05-0.png"))$this->error("证书已存在");
        $id = I('id',0);
        if(IS_POST){
            $posts = I('post.');
            // $this->error($posts['id_no']);
            // $this->error(date("Y-m-d H:i:s", strtotime($posts['year']. " year")));
            if(!$posts['username'])$this->error("用户名称不能为空！");
            if(!$posts['real_name'])$this->error("真实姓名不能为空！");
            if(!$posts['id_no'])$this->error("身份证不能为空！");
            if(!$posts['mobile'])$this->error("手机号码不能为空！");
            if(!$posts['wx_id'])$this->error("微信号码不能为空！");
            if(!$posts['email'])$this->error("邮箱码不能为空！");
            if(!$posts['id_no'])$this->error("身份证号码不能为空！");
            if(!$posts['region'])$this->error("地区不能为空！");
            if(!preg_match("/^1[34578]\d{9}$/", $posts['mobile']))$this->error("手机号码格式错误！");
            if(!preg_match("/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/", $posts['id_no']))$this->error("身份证号码格式错误！");
            if(!$posts['agent_product'])$this->error("授权品牌不能为空！");
            // if(!$posts['review_begin_time'] | !$posts['review_end_time'] | ($posts['review_begin_time'] >= $posts['review_end_time']))$this->error("授权年限错误！");
            $data['is_review'] = 1;
            $data['status'] = 1;
            $data['agent_no'] = get_agent_no();
            $data['agent_product'] = $posts['agent_product'];
            // $data['review_begin_time'] = strtotime($posts['review_begin_time']);
            // $data['review_end_time'] = strtotime($posts['review_end_time']);
            
            $data['review_begin_time'] = time();
            $data['review_end_time'] = strtotime("+1 year");

            $data['username'] = $posts['username'];
            $data['real_name'] = $posts['real_name'];
            $data['id_no'] = $posts['id_no'];
            $data['mobile'] = $posts['mobile'];
            $data['email'] = $posts['email'];
            $data['wx_id'] = $posts['wx_id'];
            $data['region'] = $posts['region'];
            $data['company'] = $posts['company'];
            // $this->error($data['review_begin_time']);

            /*添加后台代理商权限信息*/
            M("AuthGroupAccess")->add(array('uid' => $id, 'group_id' => '1'));

            $up_review = M("Agents")->where(array('id' => $id))->setField($data);
            if($up_review){
                $gen_cert = R("Certs/gen_cert", array('id' => $id));
                if($gen_cert){
                    $c_data['pic_url'] = substr($gen_cert, 1);
                    $c_data['create_admin'] = 1;
                    $c_data['create_time'] = time();
                    $c_data['cert_admin'] = $id;
                    $c_data['cert_no'] = $data['agent_no'];
                    $c_data['begin_time'] = strtotime($posts['review_begin_time']);
                    $c_data['end_time'] = strtotime($posts['review_end_time']);

                    $ex_id = M("Certs")->where(array('cert_admin' => $id))->find();
                    if(!$ex_id){
                        $insert_id = M("Certs")->add($c_data);
                    }else{
                        $insert_id = M("Certs")->where(array('id' => $ex_id['id']))->setField($c_data);
                    }
                    $insert_id ? $this->success('审核成功', U('a_list')) : $this->error('审核失败！');
                }
            }else{
                $this->error('审核失败！');
            }
        }else{
            $agent_member = M("Agents")->where(array('id' => $id))->find();
            $this->assign("info", $agent_member);
            $this->meta_title = '代理商审核';
            $this->display();
        }
    }

    /**
     * 证书生成
     * @param  integer $code 错误编码
     * @return string        错误信息
     */

    public function getToGenCert(){
        $id = I('id');
        $agent_info = M("Agents")->where(array('id' => $id))->find();
        if(!$agent_info['is_review'])$this->error("用户未审核");
        $gen_cert = R("Certs/gen_cert", array('id' => $id));
        if($gen_cert){
            // $ex_id = M("Certs")->where(array('cert_admin' => $id))->find();
            // if(!$ex_id){
            //     $insert_id = M("Certs")->add($c_data);
            // }else{
            //     $insert_id = M("Certs")->where(array('id' => $ex_id['id']))->setField($c_data);
            // }
            // $insert_id? $this->success('证书生成成功！', U('a_list')) : $this->error('证书生成失败！');
            $this->success('证书生成成功！', U('a_list'));
        }else{
            $this->error('证书生成失败！');
        }
    }

    /**
     * 获取用户注册错误信息
     * @param  integer $code 错误编码
     * @return string        错误信息
     */
    public function showRegError($code = 0){
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

    public function think_ucenter_md5($str, $key = 'ThinkUCenter'){
        return '' === $str ? '' : md5(sha1($str) . $key);
    }
}
