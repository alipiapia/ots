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
class MobilebannerController extends AdminController {
      public function index(){
        $data = M('Mobilebanner')->select();
        foreach ($data as $key => $value) {
          $data[$key]['img_url'] = get_picture($value['pic_id']);
      }
        $this->assign('data',$data);
        $this->assign("meta_title", "手机轮播图片");
        $this->display();
      }
      public function add(){
        if(IS_POST){
          $arr['title'] = $_POST['title'];
          $arr['pic_id'] = $_POST['pic_id'];
          $arr['time'] = time();
          if(M('Mobilebanner')->add($arr)){
            $this->success('添加成功',U('Admin/Mobilebanner/index'));
              }else{
            $this->error('添加失败',U('Admin/Mobilebanner/index'));
            }
        }else{
          $this->assign("meta_title", "手机轮播图片");
           $this->display();
        }    
      }

      public function del(){
        $slider = M('Mobilebanner')->where(array('id'=>$_REQUEST['id']))->find();
        $del_picture = M('picture')->where(array('id'=>$slider['cover']))->find();
        unlink('.'.$del_picture['path']);
        M('picture')->where(array('id'=>$slider['cover']))->delete();
        $slider = M('Mobilebanner')->where(array('id'=>$_REQUEST['id']))->delete();
        $this->success('删除成功',U('Admin/Mobilebanner/index'));
      }
}