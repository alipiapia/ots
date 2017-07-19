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
use Admin\Controller\UserController;

/**
 * 后台证书列表控制器
 * @author alipiapia <124910168@qq.com>
 */
class CertsController extends AdminController {

    /**
     * 证书首页
     * @author alipiapia <124910168@qq.com>
     */
    public function index(){
        $this->meta_title = '证书首页';
        $this->display();
    }

    /**
     * 证书列表
     * @author alipiapia <124910168@qq.com>
     */
    public function c_list(){
        $cert_admin = trim(I('keyword'));
        // if(is_numeric($keyword)){
        //     $map['id'] =   intval($keyword);
        // }else{
        //     $pids = M("Agents")->where(array('username' => array('like','%'.(string)$cert_admin.'%'), array('pid' => UID)))->field('id, pid')->select();
        //     foreach ($pids as $k => $v) {
        //         $pids[$k] = $v['id'];
        //     }
        //     $map['cert_no|cert_admin'] =   array(array('like','%'.(string)$cert_admin.'%'),array('in', $pids),'_multi'=>true);
        // }
        $ids = M("Agents")->where(array('pid' => UID))->field('id')->select();
        // p($ids);
        foreach ($ids as $key => $value) {
            $ids[$key] = $value['id'];
        }
        // p($ids);
        array_push($ids, UID);
        // p($ids);
        if($cert_admin){
            $map['cert_admin'] = $cert_admin;
        }else{
            $map['cert_admin'] = array('in', $ids);
        }
        if(UID == 1)$map['cert_admin'] = $cert_admin;
        // $list = M("Certs")->where($map)->order("create_time DESC")->select();
        // p($map);
        $this->data = $this->lists("Certs", $map);
        $this->meta_title = '证书列表';
        $this->display();
    }

    /**
     * 添加证书
     * @author alipiapia <124910168@qq.com>
     */
    public function add(){
        if (IS_POST) {
            //添加数据 
            $Certs = M("Certs");
            $_POST['create_time'] = time();
            $_POST['create_admin'] = UID;
            // p($_POST);
            if ($Certs->add($_POST)) {
                $this->success('证书添加成功！', U('c_list'));
            }else{
                $this->error('证书添加失败！');
            }
        }else{
            $this->meta_title = '添加证书';
            $this->display();
        }
    }

    /**
     * 查看证书
     */
    public function view(){
        $id = I('id');
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $map = array('id' => $id);
        $cert_info = M('Certs')->where($map)->find();
        $this->assign("info", $cert_info);
        $this->display();
    }

    /**
     * 删除证书
     */
    public function del(){
        $id = array_unique((array)I('id',0));
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $map = array('id' => array('in', $id) );
        M('Certs')->where($map)->delete() ? $this->success('删除成功') : $this->error('删除失败！');
    }


    /**
     * 生成证书
     */
    public function gen_cert(){
        $id = I('id');
        if(!$id)$this->error("用户不存在！");
        $agent_info = M("Agents")->where(array('id' => $id))->find();
        $real_name = $agent_info['real_name'];
        $id_no = substr($agent_info['id_no'], 0, 4)."**********".substr($agent_info['id_no'], -4);
        $mobile = $agent_info['mobile'];
        $wx_id = $agent_info['wx_id'];
        $region = $agent_info['region'];
        $agent_no = $agent_info['agent_no'];
        $agent_product = $agent_info['agent_product'];
        $agent_grade = getTitlebyPid($agent_info['agent_grade']);
        // $review_begin_time = Date("Y-m-d", $agent_info['review_begin_time']);
        // $review_end_time = Date("Y-m-d", $agent_info['review_end_time']);

        $review_begin_year = Date("Y", $agent_info['review_begin_time']);
        $review_begin_month = Date("m", $agent_info['review_begin_time']);
        $review_begin_day = Date("d", $agent_info['review_begin_time']);

        $review_end_year = Date("Y", $agent_info['review_end_time']);
        $review_end_month = Date("m", $agent_info['review_end_time']);
        $review_end_day = Date("d", $agent_info['review_end_time']);

        // $ttf = 'C:\Windows\WinSxS\amd64_microsoft-windows-font-truetype-tahoma_31bf3856ad364e35_10.0.10240.16603_none_37d091930f4d43f3\tahomabd.ttf';
        // $ttf = './Public/static/thinkeditor/skin/default/fonts/thinkeditor.ttf';
        // $ttf = "./data/1.otf";
        $ttf = "./Public/static/Certs/msyh.ttc";
        // $ttf = "/ThinkPHP/Library/Think/Verify/ttfs/1.ttf";
        // $ttf = "./Public/Home/Fonts/FontAwesome.otf";
        // $image = imagecreatefrompng('./Public/static/Certs/original.png');
        $image = imagecreatefrompng('./Public/static/Certs/cert20160627.png');
        imagealphablending($image, true);
        $red = imagecolorallocate($image, 255,0, 0);
        // imagefttext("Image", "Font Size", "Rotate Text", "Left Position", "Top Position", "Font Color", "Font Name", "Text To Print");
        // imagefttext($image, 12, 0, 270, 165, $red, $ttf, $agent_product);
        // imagefttext($image, 12, 0, 285, 330, $red, $ttf, $real_name);
        // imagefttext($image, 12, 0, 285, 365, $red, $ttf, $wx_id);
        // imagefttext($image, 12, 0, 285, 400, $red, $ttf, $mobile);
        // imagefttext($image, 12, 0, 285, 435, $red, $ttf, $id_no);
        // imagefttext($image, 12, 0, 305, 465, $red, $ttf, $agent_product);
        // imagefttext($image, 12, 0, 180, 500, $red, $ttf, $region);
        // imagefttext($image, 12, 0, 265, 535, $red, $ttf, $agent_product);
        // imagefttext($image, 12, 0, 240, 645, $red, $ttf, $review_begin_time);
        // imagefttext($image, 12, 0, 385, 645, $red, $ttf, $review_end_time);
        // imagefttext($image, 12, 0, 245, 670, $red, $ttf, $agent_no);
        // imagefttext($image, 12, 0, 270, 695, $red, $ttf, C(WEB_SITE_URL));



        // imagefttext("Image", "Font Size", "Rotate Text", "Left Position", "Top Position", "Font Color", "Font Name", "Text To Print");
        imagefttext($image, 12, 0, 235, 365, $red, $ttf, $real_name);
        imagefttext($image, 12, 0, 235, 385, $red, $ttf, $wx_id);
        imagefttext($image, 12, 0, 235, 410, $red, $ttf, $mobile);
        imagefttext($image, 12, 0, 235, 430, $red, $ttf, $id_no);
        imagefttext($image, 20, 0, 280, 520, $red, $ttf, $agent_grade);
        imagefttext($image, 20, 0, 281, 521, $red, $ttf, $agent_grade);

        imagefttext($image, 12, 0, 240, 630, $red, $ttf, $review_begin_year);
        imagefttext($image, 12, 0, 310, 630, $red, $ttf, $review_begin_month);
        imagefttext($image, 12, 0, 360, 630, $red, $ttf, $review_begin_day);

        imagefttext($image, 12, 0, 430, 630, $red, $ttf, $review_end_year);
        imagefttext($image, 12, 0, 500, 630, $red, $ttf, $review_end_month);
        imagefttext($image, 12, 0, 555, 630, $red, $ttf, $review_end_day);

        imagefttext($image, 12, 0, 240, 655, $red, $ttf, $agent_no);
        imagefttext($image, 12, 0, 240, 675, $red, $ttf, C(WEB_SITE_URL));
        /* If you want to display the file in browser */
        /*
        header('Content-type: image/png');
        ImagePng($image);
        imagedestroy($image);
        */
        /* if you want to save the file in the web server */

        $filename = './Uploads/Certs/'.$agent_info['username'].'-cert-'.$agent_info['id'].'.png';
        if(file_exists($filename)){
            $del = unlink($filename); 
        }
        ImagePng($image, $filename, 9);
        imagedestroy($image);

        /* If you want the user to download the file */
        /*
        $filename = 'certificate_aadarsh.png';
        ImagePng($image,$filename);
        header('Pragma: public');
        header('Cache-Control: public, no-cache');
        header('Content-Type: application/octet-stream');
        header('Content-Length: ' . filesize($filename));
        header('Content-Disposition: attachment; filename="' .
         basename($filename) . '"');
        header('Content-Transfer-Encoding: binary');
        readfile($filename);
        imagedestroy($image);
        */
        return $filename;
    }
    
}
