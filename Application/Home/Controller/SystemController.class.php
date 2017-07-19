<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/5/24
 * Time: 15:07
 */

namespace Home\Controller;

/**
 * 前台综合控制器
 */
class SystemController extends HomeController
{
    //代理商 列表
    public function a_list(){
        //To do
//        $my_agents = M("Agents")->where(array('pid' => is_login()))->select();
//        $this->assign("meta_title","我的团队");
//        $this->assign('my_agents',$my_agents);
//        $this->display();

        $my_agents = M('Agents'); // 实例化User对象
        $count      = $my_agents->where(array('pid' => is_login()))->count();
        $Page       = new \Think\Page($count,10);// 实例化分页类 传入总记录数和每页显示的记录数(25)
        $Page->setConfig('first','首页');
        $Page->setConfig('prev','上一页');
        $Page->setConfig('next','下一页');
        $Page->setConfig('last','末页');
        $Page->setConfig('theme', ' 共 %TOTAL_ROW% 条数据 共%TOTAL_PAGE%页 %FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');

        $show       = $Page->show();// 分页显示输出// 进行分页数据查询 注意limit方法的参数要使用Page类的属性
        $list = $my_agents->where(array('pid' => is_login()))->order('reg_time')->limit($Page->firstRow.','.$Page->listRows)->select();
        $this->assign('list',$list);// 赋值数据集
        $this->assign('page',$show);// 赋值分页输出

        $this->assign('uid',is_login());
        $this->assign("meta_title","我的团队");

        $this->display(); // 输出模板



    }
    public function a_index(){
        $id = I('id');
        if(IS_POST){
            $posts = I('post.');
//            P($posts);
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
            // 
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

            /*添加后台代理商权限信息*/
            M("AuthGroupAccess")->add(array('uid' => $id, 'group_id' => '1'));

            $up_review = M("Agents")->where(array('id' => $id))->setField($data);
            if($up_review){
                $gen_cert = $this->gen_cert($id);
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
            $list = M('Agents')->where(array('id'=>$id))->find();
            $this->assign('list',$list);
            $this->assign("meta_title","我的团队");
            $this->display();
        }
    }

    //生成证书
        public function gen_cert(){
        $id = I('id');
        if(!$id)$this->error("用户不存在！");
        $agent_info = M("Agents")->where(array('id' => $id))->find();
        $real_name = $agent_info['real_name'];
        $id_no = substr($agent_info['id_no'], 0, 4)."**********".substr($agent_info['id_no'], -4);
        $mobile = $agent_info['mobile'];
        $wx_id = $agent_info['wx_id'];
        $region = $agent_info['region'];
        $agent_no = $agent_info['agent_no'];
        $agent_product = $agent_info['agent_product'];
        $agent_grade = getTitlebyPid($agent_info['agent_grade']);
        $review_begin_time = Date("Y-m-d", $agent_info['review_begin_time']);
        $review_end_time = Date("Y-m-d", $agent_info['review_end_time']);

        $ttf = "./Public/static/Certs/msyh.ttc";

        $image = imagecreatefrompng('./Public/static/Certs/original.png');
        imagealphablending($image, true);
        $red = imagecolorallocate($image, 150,0, 0);

        imagefttext($image, 12, 0, 270, 165, $red, $ttf, $agent_product);
        imagefttext($image, 12, 0, 285, 330, $red, $ttf, $real_name);
        imagefttext($image, 12, 0, 285, 365, $red, $ttf, $wx_id);
        imagefttext($image, 12, 0, 285, 400, $red, $ttf, $mobile);
        imagefttext($image, 12, 0, 285, 435, $red, $ttf, $id_no);
        imagefttext($image, 12, 0, 305, 465, $red, $ttf, $agent_product);
        imagefttext($image, 12, 0, 180, 500, $red, $ttf, $region);
        imagefttext($image, 12, 0, 265, 535, $red, $ttf, $agent_product);
        imagefttext($image, 12, 0, 240, 645, $red, $ttf, $review_begin_time);
        imagefttext($image, 12, 0, 385, 645, $red, $ttf, $review_end_time);
        imagefttext($image, 12, 0, 245, 670, $red, $ttf, $agent_no);
        imagefttext($image, 12, 0, 270, 695, $red, $ttf, C(WEB_SITE_URL));

        $filename = './Uploads/Certs/'.$agent_info['username'].'-cert-'.$agent_info['id'].'.png';
        if(file_exists($filename)){
            $del = unlink($filename); 
        }
        ImagePng($image, $filename, 9);
        imagedestroy($image);
        return $filename;
    }
    

    //查看代理商
    public function a_view(){
        $id = I('id');
        $list = M('Agents')->where(array('id'=>$id))->find();
        $this->assign('list',$list);
        $this->assign("meta_title","我的团队");
        $this->display();
    }

    //邀请码
    public function x_list(){
        //To do
//        $x_codes = M("InvCode")->where(array('create_admin' => is_login()))->select();
//        $this->assign('list',$x_codes);
//        $this->display();

        $my_grade = M("Agents")->where(array('id' => is_login()))->getField("agent_grade");
        $cids = M("AgentsGrade")->where(array('pid' => $my_grade))->select();
        $this->assign("cids" , $cids);


        $x_codes = M('InvCode'); // 实例化User对象
        $count      = $x_codes->where(array('create_admin' => is_login()))->count();
        $Page       = new \Think\Page($count,10);// 实例化分页类 传入总记录数和每页显示的记录数(25)

        $Page->setConfig('first','首页');
        $Page->setConfig('prev','上一页');
        $Page->setConfig('next','下一页');
        $Page->setConfig('last','末页');
        $Page->setConfig('theme', ' 共 %TOTAL_ROW% 条数据 共%TOTAL_PAGE%页 %FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');

        $show       = $Page->show();// 分页显示输出// 进行分页数据查询 注意limit方法的参数要使用Page类的属性
        $list = $x_codes->where(array('create_admin' => is_login()))->order('create_time')->limit($Page->firstRow.','.$Page->listRows)->select();
        $this->assign('list',$list);// 赋值数据集
        $this->assign('page',$show);// 赋值分页输出

        $this->assign('uid',is_login());
        $this->assign("meta_title","邀请码");

        $this->display(); // 输出模板
    }

    //删除邀请码
    public function x_del(){
        $id = I('id',0);
        $id = array_unique((array)I('id',0));
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $map = array('id' => array('in', $id) );
        M('InvCode')->where($map)->delete() ? $this->success('删除成功', U('x_list')) : $this->error('删除失败！');
    }

    //生成邀请码
    public function gen_xcode(){
        $my_grade = M("Agents")->where(array('id' => is_login()))->getField("agent_grade");
        $cids = M("AgentsGrade")->where(array('pid' => $my_grade))->select();
        if(!$cids)$this->error("暂无发展下级权限！");
        
        $data['create_admin'] = is_login();//当前代理商ID
        $data['create_time'] = time();//
        $data['xcode'] = getGUID();//
        M("InvCode")->add($data) ? $this->success("邀请码生成成功！") : $this->success("邀请码生成失败！");
    }



    //投诉建议  代理商举报
    public function r_list(){
        //To do
//        $my_reports = M("Reports")->select();
////        P($my_reports);
//        $this->assign('list',$my_reports);
//        $this->assign('uid',is_login());
//        $this->assign("meta_title","投诉建议");
//        $this->display();

        $my_reports = M('Reports'); // 实例化User对象
        $count      = $my_reports->count();
        $Page       = new \Think\Page($count,10);// 实例化分页类 传入总记录数和每页显示的记录数(25)

        $Page->setConfig('first','首页');
        $Page->setConfig('prev','上一页');
        $Page->setConfig('next','下一页');
        $Page->setConfig('last','末页');
        $Page->setConfig('theme', ' 共 %TOTAL_ROW% 条数据 共%TOTAL_PAGE%页 %FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');

        $show       = $Page->show();// 分页显示输出// 进行分页数据查询 注意limit方法的参数要使用Page类的属性
        $list = $my_reports->order('create_time')->limit($Page->firstRow.','.$Page->listRows)->select();
        $this->assign('list',$list);// 赋值数据集
        $this->assign('page',$show);// 赋值分页输出

        $this->assign('uid',is_login());
        $this->assign("meta_title","投诉建议");

        $this->display(); // 输出模板
    }

    //查看举报
    public function r_view(){
        $id = I('id');
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $rep_info = M("Reports")->where(array('id' => $id))->find();
        $this->assign("list", $rep_info);
        $this->assign("meta_title", "投诉建议");
        $this->display();
    }

    //审核举报
    public function r_review(){
        $id = I('id',0);
        if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        if(IS_POST){
            M('Reports')->where(array('id' => $id))->setField(array('is_review' => 1)) ? $this->success('审核成功', U('r_list')) : $this->error('审核失败！');
        }else{
            //读取数据
            $list = M('Reports')->where(array('id' => $id))->find();
            $this->assign('list', $list);
            $this->meta_title = '投诉建议';
            $this->display();
        }
    }

    //删除举报
    public function r_del(){
        $id = array_unique((array)I('id',0));
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $map = array('id' => array('in', $id) );
        M('Reports')->where($map)->delete() ? $this->success('删除成功', U('r_list')) : $this->error('删除失败！');
    }

    //修改举报
    public function r_edit(){
        $id = I('id',0);
        if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        if(IS_POST){
            //修改操作
            $Reports = M("Reports");
            if(!$_POST['title'])$this->error("标题不能为空！");
            if(!$_POST['agent_name'])$this->error("举报对象不能为空！");
            if(!$_POST['contents'])$this->error("举报内容不能为空！");
            if ($Reports->save($_POST)) {
                $this->success('修改成功!', U('r_list'));
            } else {
                $this->error('修改失败!');
            }
        }else{
            //读取数据
            $list = M('Reports')->where(array('id' => $id))->find();
            $this->assign('list', $list);
            $this->meta_title = '投诉建议';
            $this->display();
        }
    }

    //添加举报
    public function r_add(){
        if (IS_POST) {
            //添加数据
            $Reports = M("Reports");
            $_POST['create_time'] = time();
            $_POST['rep_admin'] = is_login();
            $_POST['rep_ip'] = getLocalIP();
            if(!$_POST['title'])$this->error("标题不能为空！");
            if(!$_POST['agent_name'])$this->error("举报对象不能为空！");
            if(!$_POST['contents'])$this->error("举报内容不能为空！");
          
           $aid = $Reports->where(array('id'=>$_SESSION['aid']))->add($_POST);

            if ($aid) {
                $this->success('举报成功!', U('r_list'));
            }else{
                $this->error('举报失败!');
            }
        }else{
            $this->meta_title = '违规举报';
            $this->display();
        }
    }

    //证书
    public function c_list(){
        //To do
        $my_cert = M("Certs")->where(array('cert_admin' => is_login()))->find();
        $this->assign('list',$my_cert);
        $this->display();
    }

}