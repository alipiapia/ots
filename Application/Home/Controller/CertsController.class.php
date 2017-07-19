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
 * 前台证书控制器
 */
class CertsController extends HomeController {

/**
 * 证书查询
 */
    public function get_cert(){
        if(IS_POST){
            $cert_no = trim(I("post.cert_no"));
            $a_map['mobile|wx_id'] = array($cert_no,$cert_no,'_multi'=>true);
            $agent_data = M("Agents")->where($a_map)->find();
            // p($agent_data);
            if($agent_data){
                $map['cert_no|cert_admin'] =   array($cert_no,intval($agent_data['id']),'_multi'=>true);
            }else{
                $map['cert_no'] =   $cert_no;
            }
            if(!$cert_no)$this->error("编号不能为空！");
            $cert_data = M("Certs")->where($map)->find();
            // p($agent_data);
            // $agent_data = $agent_data ? $agent_data :'no';
            // $cert_data = $cert_data ? $cert_data : 'no';
            $this->assign("cert_data",$cert_data);
            $this->assign("agent_data",$agent_data);
            $this->assign("cert_no",$cert_no);
        }
        $this->display();//证书页面
    }

}