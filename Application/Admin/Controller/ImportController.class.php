<?php

namespace Admin\Controller;

/**
 * @Description:【代码实现】PHP导入Excel和导出数据为Excel文件
*/

class ImportController extends AdminController{

	public function index(){

		$this->display();
	}

	//导入XLS
	public function import(){
		$host="localhost";
		$db_user="root";
		$db_pass="root";
		$db_name="demo";
		$timezone="Asia/Shanghai";

		$link=mysql_connect($host,$db_user,$db_pass);
		mysql_select_db($db_name,$link);
		mysql_query("SET names UTF8");
		header("Content-Type: text/html; charset=utf-8");

		include_once(__ROOT__."/Public/static/excel/reader.php");
		$tmp = $_FILES['file']['tmp_name'];
		if (empty ($tmp)) {
			echo '请选择要导入的Excel文件！';
			exit;
		}
		p($_FILES);
		$save_path = __ROOT__."/Uploads/Xls/";
		$file_name = $save_path.date('Ymdhis') . ".xls";
		if (copy($tmp, $file_name)) {
			$xls = new Spreadsheet_Excel_Reader();
			$xls->setOutputEncoding('utf-8');
			$xls->read($file_name);
			for ($i=2; $i<=$xls->sheets[0]['numRows']; $i++) {
				$name = $xls->sheets[0]['cells'][$i][1];
				$sex = $xls->sheets[0]['cells'][$i][2];
				$age = $xls->sheets[0]['cells'][$i][3];
				$data_values .= "('$name','$sex','$age'),";
			}
			$data_values = substr($data_values,0,-1); //去掉最后一个逗号
			// p($_FILES);
	        //echo $sql = "insert into student (name,sex,age) values $data_values";
	        // $Model = new Model(); // 实例化一个model对象 没有对应任何数据表
	        // $Model->execute("insert into ot_url (url,short,status) values $data_values");
			$query = mysql_query("insert into student (name,sex,age) values $data_values");//批量插入数据表中
			// $query = M("Url")->add($data);
		    if($query){
			    echo '导入成功！';
		    }else{
			    echo '导入失败！';
		    }
		}
	}
	

	//导出XLS
	public function export(){
		$result = mysql_query("select * from student");
	    $str = "姓名\t性别\t年龄\t\n";
	    $str = iconv('utf-8','gb2312',$str);
	    while($row=mysql_fetch_array($result)){
	        $name = iconv('utf-8','gb2312',$row['name']);
	        $sex = iconv('utf-8','gb2312',$row['sex']);
	    	$str .= $name."\t".$sex."\t".$row['age']."\t\n";
	    }
	    $filename = date('Ymd').'.xls';
	    exportExcel($filename,$str);
	}


	public function exportExcel($filename,$content){
	 	header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
		header("Content-Type: application/vnd.ms-execl");
		header("Content-Type: application/force-download");
		header("Content-Type: application/download");
	    header("Content-Disposition: attachment; filename=".$filename);
	    header("Content-Transfer-Encoding: binary");
	    header("Pragma: no-cache");
	    header("Expires: 0");

	    echo $content;
	}

}