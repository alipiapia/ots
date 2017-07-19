<?php
namespace Admin\Controller;
use User\Api\UserApi as UserApi;

/**
 * 后台公司介绍管理
 * @author alipiapia <124910168@qq.com>
 */
class IntroduceController extends AdminController {
	/**
     * 违规举报首页
     * @author alipiapia <124910168@qq.com>
     */
    public function index(){
        $this->meta_title = '企业介绍';
        $this->display();
    }


    /**
     * 公司介绍
     * @author alipiapia <124910168@qq.com>
     */
    public function i_list(){
        $map['rep_admin'] = UID;
        $list = M("Introduce")->where($map)->select();
        // p($map);
        $this->assign('data', $list);
        $this->meta_title = '企业介绍';
        $this->display();
    }


    public function edit(){
    	$id = I('id',0);
        if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        if (IS_POST) {
            //添加数据 
            $Introduce = M("Introduce");
            $_POST['time'] = time();
            $_POST['re_ip'] = $this->getLocalIP();
            $_POST['re_admin'] = UID;
             // p($_POST);
            if ($Introduce->save($_POST)) {
                $this->success('修改成功!',U('i_list'));
            }else{
                $this->error('修改失败!');
            }
        }else{
        	//读取数据
            $list = M('Introduce')->where(array('id' => $id))->find();
            $this->assign('data', $list);
            $this->meta_title = '修改介绍';
        	$this->display();  
        }
    }

    /**
     * 获取本机ip
     * @return [type] [description]
     */
    function getLocalIP() {
        $preg = "/\A((([0-9]?[0-9])|(1[0-9]{2})|(2[0-4][0-9])|(25[0-5]))\.){3}(([0-9]?[0-9])|(1[0-9]{2})|(2[0-4][0-9])|(25[0-5]))\Z/";
        //获取操作系统为win2000/xp、win7的本机IP真实地址
        exec("ipconfig", $out, $stats);
        if (!empty($out)) {
            foreach ($out AS $row) {
                if (strstr($row, "IP") && strstr($row, ":") && !strstr($row, "IPv6")) {
                    $tmpIp = explode(":", $row);
                    if (preg_match($preg, trim($tmpIp[1]))) {
                        return trim($tmpIp[1]);
                    }
                }
            }
        }
        //获取操作系统为linux类型的本机IP真实地址
        exec("ifconfig", $out, $stats);
        if (!empty($out)) {
            if (isset($out[1]) && strstr($out[1], 'addr:')) {
                $tmpArray = explode(":", $out[1]);
                $tmpIp = explode(" ", $tmpArray[1]);
                if (preg_match($preg, trim($tmpIp[0]))) {
                    return trim($tmpIp[0]);
                }
            }
        }
        return '127.0.0.1';
    }

}