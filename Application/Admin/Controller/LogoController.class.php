<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: huajie <banhuajie@163.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Admin\Model\AuthGroupModel;
use Think\Page;

/**
 * 后台内容控制器
 * @author huajie <banhuajie@163.com>
 */
class LogoController extends AdminController {
      // public function index(){
      // $logo = M('logo')->find();
      // foreach ($logo as $key => $value) {
      //   $logo[$key]['img_url'] = get_picture($value['pic_id']);
      // }

      // $this->assign('data',$logo);
      // $this->display();
      
      // }
      public function index(){
            $logo = M('logo')->find();
            $logo['img_url'] = get_pictures($logo['pic_id']);
            $this->assign('old_pic_id',$logo['pic_id']);
            $this->assign('title',$logo['title']);
            $this->assign('logo',$logo);
          $this->assign("meta_title", "LOGO");
            $this->display();
      }

      public function edit(){ 
            if(IS_POST){                              
                 if($_POST['pic_id']==''){
                    $this->error('修改失败,图片不能为空！'); 
                 }else{
                  $id = I('id',1);                 
                  M('picture')->delete($_POST['old_pic_id']);
                  $logo = M('logo')->where(array('id'=>$id))->find();
                  $picture = M("logo");                     

                  if ($picture->where(array('id'=>1))->save($_POST)) {
                      $this->success('修改成功',U('Logo/index'));
                  } else {
                      $this->error('修改失败');
                  }
                 }
            }else{
              $this->assign("meta_title", "LOGO");
              $this->display();
            }
      }

      public function del(){
        $slider = M('slider')->where(array('id'=>$_REQUEST['id']))->find();
        $del_picture = M('picture')->where(array('id'=>$slider['cover']))->find();
        unlink('.'.$del_picture['path']);
        M('picture')->where(array('id'=>$slider['cover']))->delete();
        $slider = M('slider')->where(array('id'=>$_REQUEST['id']))->delete();
        $this->success('删除成功',U('Admin/Slider/index'));
      }
}