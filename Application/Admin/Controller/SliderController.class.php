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
class SliderController extends AdminController {
      public function index(){
      $data = M('slider')->select();
      foreach ($data as $key => $value) {
        $data[$key]['img_url'] = get_picture($value['pic_id']);
      }

      $this->assign('data',$data);
      $this->assign("meta_title", "轮播图片");
      $this->display();
      }
      public function add(){
        if(IS_POST){
          $arr['title'] = $_POST['title'];
          $arr['pic_id'] = $_POST['pic_id'];
          $arr['time'] = time();
          if(M('slider')->add($arr)){
            $this->success('添加成功',U('Admin/Slider/index'));
              }else{
            $this->error('添加失败',U('Admin/Slider/index'));
            }
        }else{
          $this->assign("meta_title", "轮播图片");
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