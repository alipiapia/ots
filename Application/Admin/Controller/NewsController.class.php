<?php
// +----------------------------------------------------------------------
// | alipiapia [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://www.2he87.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: alipiapia <124910168@qq.com> <http://www.2he87.com.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use User\Api\UserApi as UserApi;

/**
 * 后台代理商控制器
 * @author alipiapia <124910168@qq.com>
 */
class NewsController extends AdminController {

    /**
     * 代理商首页
     * @author alipiapia <124910168@qq.com>
     */
    public function index(){
        $this->meta_title = '新闻首页';
        $this->display();
    }

    /**
     * 新闻列表
     * @author alipiapia <124910168@qq.com>
     */
    public function n_list(){
        $title = i('get.title');
        if($title) $map['title'] = $title;
        $map['rel_admin'] = UID;
        $list = M("News")->where($map)->order("rel_time DESC")->select();
        // p($list);
        $this->assign('data', $list);
        $this->meta_title = '新闻列表';
        $this->display();
    }

    /**
     * 添加新闻
     * @author alipiapia <124910168@qq.com>
     */
    public function add(){
        if (IS_POST) {
            //添加数据 
            $News = M("news");
            $_POST['rel_time'] = time();
            $_POST['rel_admin'] = UID;
            $_POST['rel_ip'] = $this->getLocalIP();
            // p($_POST);
            if ($News->add($_POST)) {
                $this->success('新闻发布成功！', U('n_list'));
            }else{
                $this->error('新闻发布失败！');
            }
        }else{
            $this->meta_title = '新闻发布';
            $this->display();
        }
    }


    /**
     * 删除新闻
     */
    public function del(){
         $id = I('id',0);
         // p($id);
        if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        M('News')->where(array('id' => $id))->delete() ? $this->success('删除成功') : $this->error('删除失败！');
    }

    /**
     * 修改新闻
     * @return [type] [description]
     */
    public function edit(){ 
        $id = I('id',0);
        if (empty($id)){
            $this->error('请选择要操作的数据!');
        }
        if(IS_POST){
            //修改操作
           $News = M("News");
            if ($News->save($_POST)) {
                $this->success('新闻修改成功！', U('n_list'));
            } else {
                $this->error('新闻修改失败！');
            }
        }else{
            //读取数据
            $list = M('News')->where(array('id' => $id))->find();
            // P($list);
            $this->assign('data', $list);
            $this->meta_title = '修改新闻';
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
