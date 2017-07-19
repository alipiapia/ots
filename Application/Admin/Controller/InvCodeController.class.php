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
 * 后台邀请码控制器
 * @author alipiapia <124910168@qq.com>
 */
class InvCodeController extends AdminController {

    /**
     * 邀请码首页
     * @author alipiapia <124910168@qq.com>
     */
    public function index(){
        $this->meta_title = '邀请码首页';
        $this->display();
    }

    /**
     * 邀请码列表
     * @author alipiapia <124910168@qq.com>
     */
    public function i_list(){
        $use_admin = i('get.use_admin');
        if($use_admin) $map['use_admin'] = $use_admin;
        $map['create_admin'] = UID;

        $my_grade = M("Agents")->where(array('id' => UID))->getField("agent_grade");
        $cids = M("AgentsGrade")->where(array('pid' => $my_grade))->select();
        $this->assign("cids" , $cids);
        
        // $list = M("InvCode")->where($map)->order("create_time DESC")->select();
        $this->data = $this->lists("InvCode", $map);
        $this->meta_title = '邀请码列表';
        $this->display();
    }

    /**
     * 添加邀请码
     * @author alipiapia <124910168@qq.com>
     */
    // public function add(){
    //     $my_grade = M("Agents")->where(array('id' => UID))->getField("agent_grade");
    //     $cids = M("AgentsGrade")->where(array('pid' => $my_grade))->select();
    //     if(!$cids)$this->error("暂无发展下级权限！");
    //     $this->gen_xcode();die;
    //     $this->meta_title = '生成邀请码';
    //     $this->display();
    // }

    /**
     * 编辑邀请码
     * @author alipiapia <124910168@qq.com>
     */
    public function edit(){
        $this->meta_title = '编辑邀请码';
        $this->display();
    }

    /**
     * 删除邀请码
     * @author alipiapia <124910168@qq.com>
     */
    public function del(){
        $id = array_unique((array)I('id',0));
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $map = array('id' => array('in', $id) );
        M('InvCode')->where($map)->delete() ? $this->success('删除成功', U('i_list')) : $this->error('删除失败！');
    }

    /**
     * 邀请码排序
     * @author alipiapia <124910168@qq.com>
     */
    public function sort(){
        if(IS_GET){
            $ids = I('get.ids');
            $pid = I('get.pid');

            //获取排序的数据
            $map = array('status'=>array('gt',-1));
            if(!empty($ids)){
                $map['id'] = array('in',$ids);
            }else{
                if($pid !== ''){
                    $map['pid'] = $pid;
                }
            }
            $list = M('Channel')->where($map)->field('id,title')->order('sort asc,id asc')->select();

            $this->assign('list', $list);
            $this->meta_title = '导航排序';
            $this->display();
        }elseif (IS_POST){
            $ids = I('post.ids');
            $ids = explode(',', $ids);
            foreach ($ids as $key=>$value){
                $res = M('Channel')->where(array('id'=>$value))->setField('sort', $key+1);
            }
            if($res !== false){
                $this->success('排序成功！');
            }else{
                $this->eorror('排序失败！');
            }
        }else{
            $this->error('非法请求！');
        }
    }

    /**
     * 生成邀请码
     * @author alipiapia <124910168@qq.com>
     */
    public function gen_xcode(){
        $my_grade = M("Agents")->where(array('id' => UID))->getField("agent_grade");
        $cids = M("AgentsGrade")->where(array('pid' => $my_grade))->select();
        if(!$cids)$this->error("暂无发展下级权限！");

        $data['create_admin'] = UID;//当前代理商ID
        $data['create_time'] = time();//
        $data['xcode'] = getGUID();//
        M("InvCode")->add($data) ? $this->success("邀请码生成成功！") : $this->success("邀请码生成失败！");
    }

}
