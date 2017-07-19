<?php
// +----------------------------------------------------------------------
// | alipiapia [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://www.2he87.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: alipiapia <124910168@qq.com> <http://www.2he87.com.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use User\Api\UserApi as UserApi;

/**
 * 后台代理商举报管理
 * @author alipiapia <124910168@qq.com>
 */
class ReportsController extends AdminController {

    /**
     * 违规举报首页
     * @author alipiapia <124910168@qq.com>
     */
    public function index(){
        $this->meta_title = '举报首页';
        $this->display();
    }

    /**
     * 查看举报
     */
    public function view(){
        $id       =   I('id');
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $rep_info = M("Reports")->where(array('id' => $id))->find();
        $this->assign("info", $rep_info);
        $this->assign("meta_title", "举报详情");
        $this->display();
    }

    /**
     * 举报列表
     * @author alipiapia <124910168@qq.com>
     */
    public function r_list(){
        $keyword       =   I('keyword');
        if(is_numeric($keyword)){
            $map['id'] =   intval($keyword);
        }else{
            $map['agent_name|title|contents'] =   array(array('like','%'.(string)$keyword.'%'),array('like','%'.(string)$keyword.'%'),array('like','%'.(string)$keyword.'%'),'_multi'=>true);
        }
        $user_info = session('user_auth');
        if(UID != 1)$map['rep_admin'] = $user_info['uid'];
        $this->data = $this->lists("Reports", $map);
        $this->meta_title = '举报列表';
        $this->display();
    }


    /**
     * 添加举报
     * @author alipiapia <124910168@qq.com>
     */
    public function add(){
        if (IS_POST) {
            //添加数据 
            $Reports = M("Reports");
            $_POST['create_time'] = time();
            $_POST['rep_admin'] = UID;
            $_POST['rep_ip'] = getLocalIP();
            if(!$_POST['title'])$this->error("标题不能为空！");
            if(!$_POST['agent_name'])$this->error("举报对象不能为空！");
            if(!$_POST['contents'])$this->error("举报内容不能为空！");
            if ($Reports->add($_POST)) {
                $this->success('举报成功!', U('r_list'));
            }else{
                $this->error('举报失败!');
            }
        }else{
            $this->meta_title = '违规举报';
            $this->display();   
        }
    }

    /**
     * 修改举报
     * @return [type] [description]
     */
    public function edit(){ 
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
            $this->assign('data', $list);
            $this->meta_title = '举报修改';
            $this->display();
        }
    }

    /**
     * 删除举报
     */
    public function del(){
        $id = array_unique((array)I('id',0));
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $map = array('id' => array('in', $id) );
        M('Reports')->where($map)->delete() ? $this->success('删除成功', U('r_list')) : $this->error('删除失败！');
    }

    /**
     * 审核
     */
    public function review(){
        $id = I('id',0);
        if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        if(IS_POST){
            M('Reports')->where(array('id' => $id))->setField(array('is_review' => 1)) ? $this->success('审核成功', U('r_list')) : $this->error('审核失败！');
        }else{
            //读取数据
            $list = M('Reports')->where(array('id' => $id))->find();
            $this->assign('data', $list);
            $this->meta_title = '审核';
            $this->display();
        }
    }
}
