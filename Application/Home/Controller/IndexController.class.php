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
 * 前台首页控制器
 * 主要获取首页聚合数据
 */
class IndexController extends HomeController {

	//系统首页
    public function index(){

        // 首页轮播图
        $slide = D('slider')->limit(4)->select();
        foreach ($slide as $key => $value) {
             $slide[$key]['pic_id'] = get_slider_picture($value['pic_id']);
        }

        //手机首页轮播图
        $Mobilebanner = D('Mobilebanner')->limit(4)->select();
        foreach ($Mobilebanner as $key => $value) {
             $Mobilebanner[$key]['pic_id'] = get_slider_picture($value['pic_id']);
        }    

        //首页logo
        // $logo = D('logo')->find();
        // $logo['pic_id'] = get_slider_picture($logo['pic_id']);

        $category = D('Category')->getTree();
        $lists    = D('Document')->lists(null);

        $cats = M("Category")->where(array('pid' => 46))->field('id,name,title')->select();//产品
        foreach ($cats as $k => $v) {
            $docs[$k] = M("Document")->where(array('category_id' => $v['id']))->find();
        }
        $art = M("Document")->where(array('category_id' => 2))->find();
        $news = M("Document")->where(array('category_id' => 40))->limit(2)->order("create_time DESC")->select();
        $join_title = M("Document")->where(array('id' => 29))->getField("title");
        $join = M("DocumentArticle")->where(array('id' => 29))->find();
        $join = array_merge($join, array('title' => $join_title));
        // p($news);

        $this->assign('slide',$slide);
        $this->assign('Mobilebanner',$Mobilebanner);
        // $this->assign('logo',$logo);
        $this->assign('news',$news);
        $this->assign('art',$art);
        $this->assign('docs',$docs);
        $this->assign('join',$join);
        $this->assign('category',$category);//栏目
        $this->assign('lists',$lists);//列表
        $this->assign('page',D('Document')->page);//分页

        $this->assign("meta_title", "七彩优瞳");
        $this->display();
    }

}