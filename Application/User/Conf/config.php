<?php
// +----------------------------------------------------------------------
// | No Think [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.fartry.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

/**
 * UCenter客户端配置文件
 * 注意：该配置文件请使用常量方式定义
 */

define('UC_APP_ID', 1); //应用ID
define('UC_API_TYPE', 'Model'); //可选值 Model / Service
define('UC_AUTH_KEY', 'DNa,5=h+/|M%mp:{dJCY}Fet?;]OwZbVX!9[qi~^'); //加密KEY
// define('UC_DB_DSN', 'mysqli://root:root@127.0.0.1:3306/ot'); // 数据库连接，使用Model方式调用API必须配置此项
define('UC_DB_DSN', 'mysqli://qdm220352508:wodemima@qdm220352508.my3w.com:3306/qdm220352508_db'); // 数据库连接，使用Model方式调用API必须配置此项
define('UC_TABLE_PREFIX', 'ot_'); // 数据表前缀，使用Model方式调用API必须配置此项
