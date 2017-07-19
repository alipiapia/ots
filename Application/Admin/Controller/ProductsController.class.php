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
 * 后台产品控制器
 * @author alipiapia <124910168@qq.com>
 */
class ProductsController extends AdminController {

    /**
     * 代理商首页
     * @author alipiapia <124910168@qq.com>
     */
    public function index(){
        $this->meta_title = '产品首页';
        $this->display();
    }

    /**
     * 产品列表
     * @author alipiapia <124910168@qq.com>
     */
    public function p_list(){
        $keyword = i('keyword');
        if(is_numeric($keyword)){
            $map['id|pro_no'] =   array(intval($keyword) ,array('like','%'.(string)$keyword.'%'),'_multi'=>true);
        }else{
            $map['pro_name|pro_brand|pro_content'] =   array(array('like','%'.(string)$keyword.'%'),array('like','%'.(string)$keyword.'%'),array('like','%'.(string)$keyword.'%'),'_multi'=>true);
        }
        $list = $this->lists("Products", $map);
        $this->assign('data', $list);
        $this->meta_title = '产品列表';
        $this->display();
    }

    /**
     * 添加产品
     * @author alipiapia <124910168@qq.com>
     */
    public function add(){
        if (IS_POST) {
            $Products = M("Products");
            if(!$_POST['pro_name'])$this->error("产品名称不能为空！");
            if(!$_POST['pro_brand'])$this->error("品牌不能为空！");
            if(!$_POST['pro_no'])$this->error("产品编号不能为空！");
            if(!$_POST['pro_content'])$this->error("产品描述不能为空！");

            $_POST['create_admin'] = UID;
            $_POST['create_time'] = time();

            $insert_id = M("Products")->add($_POST);

            if ($insert_id) {
                $this->success('添加成功!', U('p_list'));
            }else{
                $this->error('添加失败!');
            }
        }else{
            $this->meta_title = '添加产品';
            $this->display();
        }
    }

    /**
     * 修改产品
     * @return [type] [description]
     */
    public function edit(){
        $id = I('id',0);
        if ( empty($id) ) $this->error('请选择要操作的数据!');
        if(IS_POST){
            //修改操作
           $Products = M("Products");
            if(!$_POST['pro_name'])$this->error("产品名称不能为空！");
            if(!$_POST['pro_brand'])$this->error("品牌不能为空！");
            if(!$_POST['pro_content'])$this->error("产品描述不能为空！");
            if ($Products->save($_POST)) {
                $this->success('产品编辑成功！', U('p_list'));
            } else {
                $this->error('产品编辑失败！');
            }
        }else{
            //读取数据
            $list = M('Products')->where(array('id' => $id))->find();
            $this->assign('data', $list);
            $this->meta_title = '产品编辑';
            $this->display();
        }
    }

    /**
     * 删除产品
     * @return [type] [descripintion]
     */
    public function del(){
        $id = array_unique((array)I('id',0));
        $this->error($id);

        if ( empty($id) ) $this->error('请选择要操作的数据!');
        $map = array('id' => array('in', $id) );

        M('Products')->where($map)->delete() ? $this->success('删除成功') : $this->error('删除失败！');
    }

    /**
     * 批量添加产品
     * @author alipiapia <124910168@qq.com>
     */
    public function auto_create(){
        if (IS_POST) {
            // p($_POST);
            //添加数据 
            $Products = M("Products");
            // $_POST['create_time'] = time();
            // $_POST['create_admin'] = UID;
            $pro_brand = get_brand_no();
            if(!$_POST['pro_name'])$this->error("产品名称不能为空！");
            if(!$_POST['pro_brand'])$this->error("品牌不能为空！");
            if(!$_POST['pro_content'])$this->error("产品描述不能为空！");
            if(!$_POST['pro_num'])$this->error("数量不能为空！");
            for($i=1;$i<=$_POST['pro_num'];$i++){
                $new_pro[$i]['pro_name'] = $_POST['pro_name'];
                $new_pro[$i]['create_admin'] = UID;
                $new_pro[$i]['create_time'] = time();
                $new_pro[$i]['pro_brand'] = $_POST['pro_brand'];
                $new_pro[$i]['pro_content'] = $_POST['pro_content'];
                $new_pro[$i]['pro_no'] = $pro_brand.'00'.$i;

            }

            $walk_array = array_walk($new_pro, 'array_walk_product');
            // p($new_pro);
            if ($walk_array) {
                $this->success('批量添加成功!', U('p_list'));
            }else{
                $this->error('批量添加失败!');
            }
        }else{
            $this->meta_title = '批量添加产品';
            $this->display();
        }
    }

    //上传方法
    public function upload()
    {
        header("Content-Type:text/html;charset=utf-8");
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     3145728 ;// 设置附件上传大小
        $upload->exts      =     array('xls', 'xlsx');// 设置附件上传类
        $upload->savePath  =      '/Xls/'; // 设置附件上传目录
        // 上传文件
        $info   =   $upload->uploadOne($_FILES['excelData']);
        $filename = './Uploads'.$info['savepath'].$info['savename'];
        $exts = $info['ext'];
        //print_r($info);exit;
        if(!$info) {// 上传错误提示错误信息
              $this->error($upload->getError());
          }else{// 上传成功
                  $this->goods_import($filename, $exts);
        }
    }

    //导入数据页面
    public function pro_import()
    {
        $this->display();
    }

    //导入数据方法
    public function goods_import($filename, $exts='xls')
    {
        //导入PHPExcel类库，因为PHPExcel没有用命名空间，只能inport导入
        import("Org.Util.PHPExcel");
        //创建PHPExcel对象，注意，不能少了\
        $PHPExcel=new \PHPExcel();
        //如果excel文件后缀名为.xls，导入这个类
        if($exts == 'xls'){
            import("Org.Util.PHPExcel.Reader.Excel5");
            $PHPReader=new \PHPExcel_Reader_Excel5();
        }else if($exts == 'xlsx'){
            import("Org.Util.PHPExcel.Reader.Excel2007");
            $PHPReader=new \PHPExcel_Reader_Excel2007();
        }


        //载入文件
        $PHPExcel=$PHPReader->load($filename);
        //获取表中的第一个工作表，如果要获取第二个，把0改为1，依次类推
        $currentSheet=$PHPExcel->getSheet(0);
        //获取总列数
        $allColumn=$currentSheet->getHighestColumn();
        //获取总行数
        $allRow=$currentSheet->getHighestRow();

        //循环获取表中的数据，$currentRow表示当前行，从哪行开始读取数据，索引值从0开始
        for($currentRow=1;$currentRow<=$allRow;$currentRow++){
            //从哪列开始，A表示第一列
            for($currentColumn='A';$currentColumn<=$allColumn;$currentColumn++){
                //数据坐标
                $address=$currentColumn.$currentRow;
                //读取到的数据，保存到数组$arr中
                $cell =$currentSheet->getCell($address)->getValue();
                $data[$currentRow][$currentColumn] = $cell;
                if($cell instanceof PHPExcel_RichText){
                    $cell  = $cell->__toString();
                }
                // print_r($cell);
            }

        }
        // p($data);die;
        $this->save_import($data);
    }

    //保存导入数据
    public function save_import($data)
    {
        // p($data);exit;

        $Products = M('Products');
        $add_time = date('Y-m-d H:i:s', time());
        foreach ($data as $k=>$v){
            if($k >= 2){
                $info['create_time'] = time();//产品添加时间
                $info['create_admin'] = UID;//产品添加人
                $info['pro_name'] = $v['A'];//产品名称
                $info['pro_brand'] = $v['B'];//产品品牌
                $info['pro_content'] = $v['D'];//产品描述
                $info['pro_no'] = strtr($v['C'], array(' ' => ''));//产品编号
                $pro_no = $Products->where(array('pro_no' => $info['pro_no']))->find();
                if($pro_no)continue;
                // $info[$k-2]['title'] = $pro_name;
                $result = $Products->add($info);
                // $pro_brand = $v['B'];

                // $old_pno=$v['E'];
                // $info[$k-2]['old_PNO'] = $old_pno;

                // $brand_title=$v['C'];
                // $brand_id = M('Brand')->where(array('title' => $brand_title))->getField('id');
                // if($brand_id){
                //     $info[$k-2]['brand_id'] = $brand_id;
                // }else{
                //     $new_brand_id = M('Brand')->add(array('title' => $brand_title, 'sort' => $k, 'add_time' => $add_time));
                //     $info[$k-2]['brand_id'] = $new_brand_id;
                // }

                // $price=$v['D'];
                // $info[$k-2]['price'] = $price;

                // $type_titles=$v['F'];
                // $type_array = explode(',', $type_titles);

                // foreach ($type_array as $type_info){
                //     $type_title = $type_info;
                //     $type_id = M('Type')->where(array('title' => $type_title))->getField('id');
                //     if($type_id){
                //         $info[$k-2]['type_ids'] .= $type_id.',';
                //     }else{
                //         $new_type_id = M('Type')->add(array('title' => $type_title, 'sort' => $k, 'add_time' => $add_time));
                //         $info[$k-2]['type_ids'] .= ','.$new_type_id.',';
                //     }

                // }

                // $category_title=$v['G'];
                // $category_id = M('Category')->where(array('title' => $category_title))->getField('id');
                // if($category_id){
                //     $info[$k-2]['category_id'] = $category_id;
                // }else{
                //     $new_category_id = M('Category')->add(array('title' => $category_title, 'sort' => $k, 'add_time' => $add_time));
                //     $info[$k-2]['category_id'] = $new_category_id;
                // }

                // $pno=$v['B'];
                // $result = $Products->where(array('PNO' => $pno))->find();

                // //print_r($info[$k-2]);exit;
                // if($result){
                //     //更新操作
                //     $result = $Products->where(array('PNO' => $pno))->save($info[$k-2]);
                // }else{
                //     //入库操作
                //     $info[$k-2]['PNO'] = $pno;
                //     $info[$k-2]['add_time'] = $add_time;

                //     $result = $Products->add($info[$k-2]);
                // }


                //print_r($info);exit;



            }

        }

        if(false !== $result || 0 !== $result){
            $this->success('产品导入成功', U('Admin/Products/p_list'));
        }else{
            $this->error('产品导入失败');
        }
        //print_r($info);

    }

    //导出数据方法
    public function goods_export($goods_list=array())
    {
        //print_r($goods_list);exit;
        $goods_list =  M("Products")->select();
        $data = array();
        foreach ($goods_list as $k=>$goods_info){
            $data[$k][id] = $goods_info['id'];
            $data[$k][title] = $goods_info['title'];
            $data[$k][PNO] = $goods_info['PNO'];
            $data[$k][old_PNO] = $goods_info['old_PNO'];
            $data[$k][price]  = $goods_info['price'];
            // $data[$k][brand_id]  = get_title('brand',$goods_info['brand_id']);
            // $data[$k][category_id]  = get_title('category',$goods_info['category_id']);
            // $data[$k][type_ids] = get_type_title($goods_info['id']);
            $data[$k][add_time] = $goods_info['add_time'];
        }

        //print_r($goods_list);
        //print_r($data);exit;

        foreach ($data as $field=>$v){
            if($field == 'id'){
                $headArr[]='产品ID';
            }

            if($field == 'title'){
                $headArr[]='产品名称';
            }

            if($field == 'PNO'){
                $headArr[]='零件号';
            }

            if($field == 'old_PNO'){
                $headArr[]='原厂参考零件号';
            }

            if($field == 'price'){
                $headArr[]='原厂参考面价';
            }

            if($field == 'type_ids'){
                $headArr[]='品牌';
            }

            if($field == 'brand_id'){
                $headArr[]='类别';
            }
            if($field == 'category_id'){
                $headArr[]='适用机型';
            }

            if($field == 'add_time'){
                $headArr[]='添加时间';
            }
        }

        $filename="goods_list";

        $this->getExcel($filename,$headArr,$data);
    }


    public  function getExcel($fileName,$headArr,$data){
        //导入PHPExcel类库，因为PHPExcel没有用命名空间，只能inport导入
        import("Org.Util.PHPExcel");
        import("Org.Util.PHPExcel.Writer.Excel5");
        import("Org.Util.PHPExcel.IOFactory.php");

        $date = date("Y_m_d",time());
        $fileName .= "_{$date}.xls";

        //创建PHPExcel对象，注意，不能少了\
        $objPHPExcel = new \PHPExcel();
        $objProps = $objPHPExcel->getProperties();

        //设置表头
        $key = ord("A");
        //print_r($headArr);exit;
        foreach($headArr as $v){
            $colum = chr($key);
            $objPHPExcel->setActiveSheetIndex(0) ->setCellValue($colum.'1', $v);
            $objPHPExcel->setActiveSheetIndex(0) ->setCellValue($colum.'1', $v);
            $key += 1;
        }

        $column = 2;
        $objActSheet = $objPHPExcel->getActiveSheet();

        //print_r($data);exit;
        foreach($data as $key => $rows){ //行写入
            $span = ord("A");
            foreach($rows as $keyName=>$value){// 列写入
                $j = chr($span);
                $objActSheet->setCellValue($j.$column, $value);
                $span++;
            }
            $column++;
        }

        $fileName = iconv("utf-8", "gb2312", $fileName);

        //重命名表
        //$objPHPExcel->getActiveSheet()->setTitle('test');
        //设置活动单指数到第一个表,所以Excel打开这是第一个表
        $objPHPExcel->setActiveSheetIndex(0);
        ob_end_clean();//清除缓冲区,避免乱码
        header('Content-Type: application/vnd.ms-excel');
        header("Content-Disposition: attachment;filename=\"$fileName\"");
        header('Cache-Control: max-age=0');

        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output'); //文件通过浏览器下载
        exit;
    }
}

