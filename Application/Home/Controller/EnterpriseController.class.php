<?php
// +----------------------------------------------------------------------
// | No Think [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.fartry.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;
use OT\DataDictionary;

/**
 * 前台企业介绍控制器
 * 
 */
class EnterpriseController extends HomeController {

    public function e_list(){
        $c_id = I("category_id", 2);
        $cate_id = 1;
        $p_cats = M("Category")->where(array('id' => $cate_id))->field('id,name,title')->find();//左侧位置栏
        $p_find = M("Document")->where(array('category_id' => $cate_id))->find();//
        $cats = M("Category")->where(array('pid' => $cate_id))->field('id,name,title')->select();//左侧菜单栏
        foreach ($cats as $k => $v) {
        	if($c_id == $v['id']){
        		$meta_title = $v['title'];
        	}
            $new_cats[$v['id']] = $v;
            $docs[$k] = M("Document")->where(array('category_id' => $v['id']))->find();
        }

        // p($docs);
    	$list = M("Document")->where(array('category_id' => $c_id))->select();
        $this->assign('p_cats', $p_cats);
        $this->assign('p_find', $p_find);
        $this->assign('cats', $new_cats);
        $this->assign('c_id', $c_id);
        // $this->assign('docs', $docs);
        $this->assign("meta_title", $meta_title);
        // $this->assign('data', $list);

        $this->to_page("Document", array('category_id' => $c_id), 5);

        $this->assign("meta_title", "企业介绍");
        $this->display();


    }

    public function detail(){ 
    	$id = I('id');
    	if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        $cate_id = 1;
        $p_cats = M("Category")->where(array('id' => $cate_id))->field('id,name,title')->find();//左侧位置栏
        $p_find = M("Document")->where(array('category_id' => $cate_id))->find();//
        $cats = M("Category")->where(array('pid' => $cate_id))->field('id,name,title')->select();//左侧菜单栏

        $content = M("DocumentArticle")->where(array('id' => $id))->getField("content");
        $list = M("Document")->where(array('id' => $id))->find();
        $list = array_merge($list, array('content' => $content));
        foreach ($cats as $k => $v) {
        	if($list['category_id'] == $v['id']){
        		$meta_title = $v['title'];
        	}
        }
        // p($list);

        $this->assign("meta_title", $meta_title);
        $this->assign('p_cats', $p_cats);
        $this->assign('p_find', $p_find);
        $this->assign('cats', $cats);
        $this->assign('data', $list);

        $this->assign("meta_title", "企业介绍");
        $this->display();
    }

}