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
 * 前台违规举报控制器
 * 
 */
class ReportsController extends HomeController {

    public function r_list(){
        // $c_id = I("category_id", 40);
        // $cate_id = 39;
        // $p_cats = M("Category")->where(array('id' => $cate_id))->field('id,name,title')->find();//左侧位置栏
        // $p_find = M("Document")->where(array('category_id' => $cate_id))->find();//
        // $cats = M("Category")->where(array('pid' => $cate_id))->field('id,name,title')->select();//左侧菜单栏
        // foreach ($cats as $k => $v) {
        //     $new_cats[$v['id']] = $v;
        // }

        // p($new_cats);
    	// $list = M("Document")->where(array('category_id' => $c_id))->select();
     //    $this->assign('p_cats', $p_cats);
     //    $this->assign('p_find', $p_find);
     //    $this->assign('cats', $new_cats);
     //    $this->assign('c_id', $c_id);
        // $this->assign('docs', $docs);
        // $this->assign('data', $list);

        $this->to_page("Reports", array('is_review' => 1), 10);


        $this->assign("meta_title", "违规举报列表");
        $this->display();


    }

    public function detail(){ 
    	$id = I('id');
    	if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        $list = M("Reports")->where(array('id' => $id))->find();
        $this->assign('data', $list);
        // p($p_find);

        $this->assign("meta_title", "违规举报详情");
        $this->display();
    }

}