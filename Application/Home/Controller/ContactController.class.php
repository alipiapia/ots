<?php
// +----------------------------------------------------------------------
// | No Think [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.fartry.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;


/**
 * 前台联系我们控制器
 * 
 */
class ContactController extends HomeController {

    public function us(){
    	$this->assign("meta_title", "关于我们");
        $this->display();
    }

}