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
 * 前台产品控制器
 */
class ProductsController extends HomeController {

    public function p_list(){
        $c_id = I("category_id", 47);
        $cate_id = 46;
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

        // $list = M("Document")->where(array('category_id' => $c_id))->select();
        // $this->assign('docs', $docs);
        $this->assign("meta_title", $meta_title);
        $this->assign('p_cats', $p_cats);
        $this->assign('p_find', $p_find);
        $this->assign('cats', $new_cats);
        $this->assign('c_id', $c_id);

        $this->to_page("Document", array('category_id' => $c_id), 5);
        // p($count);
        // $this->assign('data',$list);// 赋值数据集
        $this->assign("meta_title", "产品介绍");
        $this->display();


    }

    public function detail(){ 
        $id = I('id');
        if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        $cate_id = 46;
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

        $this->assign("meta_title", "产品介绍");
        $this->display();
    }

/**
 * 产品查询
 */
    public function get_product(){
        if(IS_POST){
            $pro_no = trim(I("post.pro_no"));
            if(!$pro_no)$this->error("编号不能为空！");
            $pro_data = M("Products")->where(array('pro_no' => $pro_no))->find();
            if($pro_data){
                $up_pro = M("Products")->where(array('pro_no' => $pro_no))->setInc("query_logs");
                $pro_data['query_logs'] = M("Products")->where(array('pro_no' => $pro_no))->getField("query_logs");
            }else{
                $pro_data = 'no';
            }
            $this->assign("pro_data",$pro_data);
            $this->assign("pro_no",$pro_no);
        }
        $this->display();//产品页面
    }

}