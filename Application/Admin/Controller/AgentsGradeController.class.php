<?php
// +----------------------------------------------------------------------
// | alipiapia [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://www.2he87.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: alipiapia <124910168@qq.com> <http://www.2he87.com.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台代理商等级控制器
 * @author alipiapia <124910168@qq.com>
 */
class AgentsGradeController extends AdminController {

    /**
     * 代理商首页
     * @author alipiapia <124910168@qq.com>
     */
    public function index(){
        $this->meta_title = '代理商等级首页';
        $this->display();
    }

    /**
     * 列表
     * @author alipiapia <124910168@qq.com>
     */
    public function g_list(){
        $title   =   I('title');

        if(is_numeric($title)){
            $map['id|title'] =   array(intval($title),array('like','%'.$title.'%'),'_multi'=>true);
        }else{
            $map['title'] =   array('like', '%'.(string)$title.'%');
        }

        $this->data = $this->lists('AgentsGrade', $map);
        $this->meta_title = '代理商等级列表';
        $this->display();
    }

    /**
     * 添加
     * @author alipiapia <124910168@qq.com>
     */
    public function add(){
        if(IS_POST){
            if(!$_POST['title'])$this->error("名称不能为空！");
            $insert_id = M('AgentsGrade')->add($_POST);
            $insert_id ? $this->success('添加成功', U('g_list')) : $this->error('添加失败！');
        } else {
            // $list = $this->lists('AgentsGrade');

            /*  代理商等级下拉菜单 */
            $glist = M('AgentsGrade')->select();
            foreach ($glist as $k => $v) {
                $glist[$k]['title_show'] = $v['title'];
            }
            $menus = D('Common/Tree')->toFormatTree($glist);
            $menus = array_merge(array(0=>array('id'=>0,'title_show'=>'公司总部')), $menus);
            $this->assign('Menus', $menus);

            $this->assign('info', null);
            $this->meta_title = '新增代理商等级';
            $this->display();
        }
    }

    /**
     * 编辑
     * @author alipiapia <124910168@qq.com>
     */
    public function edit(){
        $id = I("id");
        if(!$id)$this->error("找不到该等级！");
        if(IS_POST){
            if(!$_POST['title'])$this->error("名称不能为空！");
            $insert_id = M('AgentsGrade')->setField($_POST);
            $insert_id ? $this->success('编辑成功', U('g_list')) : $this->error('编辑失败！');
        } else {
            $list = M('AgentsGrade')->where(array('id' => $id))->find();
            $this->assign('info', $list);

            /*  代理商等级下拉菜单 */
            $glist = M('AgentsGrade')->select();
            foreach ($glist as $k => $v) {
                $glist[$k]['title_show'] = $v['title'];
            }
            $menus = D('Common/Tree')->toFormatTree($glist);
            $menus = array_merge(array(0=>array('id'=>0,'title_show'=>'公司总部')), $menus);
            $this->assign('Menus', $menus);

            $this->meta_title = '编辑代理商等级';
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
        M('AgentsGrade')->where($map)->delete() ? $this->success('删除成功') : $this->error('删除失败！');
    }
}
