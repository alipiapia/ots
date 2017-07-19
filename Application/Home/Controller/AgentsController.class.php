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
 * 前台代理商控制器
 */
class AgentsController extends HomeController {

/**
 * 代理商查询
 */
    public function get_agent(){
        if(IS_POST){
            $agent_no = trim(I("post.agent_no"));
            if(!$agent_no)$this->error("编号不能为空！");
            $agent_data = M("Agents")->where(array('agent_no' => $agent_no))->find();
            $agent_data = $agent_data ? $agent_data : 'no';
            $this->assign("data",$agent_data);
            $this->assign("agent_no",$agent_no);
        }
        $this->display();//代理商页面
    }

}