<?php
// +----------------------------------------------------------------------
// | No Think [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.fartry.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

/**
 * 系统配文件
 * 所有系统级别的配置
 */
return array(
    /* 模块相关配置 */
    'AUTOLOAD_NAMESPACE' => array('Addons' => ONETHINK_ADDON_PATH), //扩展模块列表
    'DEFAULT_MODULE'     => 'Home',
    'MODULE_DENY_LIST'   => array('Common', 'User'),
    //'MODULE_ALLOW_LIST'  => array('Home','Admin'),

    /* 系统数据加密设置 */
    'DATA_AUTH_KEY' => 'DNa,5=h+/|M%mp:{dJCY}Fet?;]OwZbVX!9[qi~^', //默认数据加密KEY

    /* 调试配置 */
    'SHOW_PAGE_TRACE' => true,

    /* 用户相关设置 */
    'USER_MAX_CACHE'     => 1000, //最大缓存用户数
    'USER_ADMINISTRATOR' => 1, //管理员用户ID

    /* URL配置 */
    'URL_CASE_INSENSITIVE' => true, //默认false 表示URL区分大小写 true则表示不区分大小写
    'URL_MODEL'            => 1, //URL模式
    'VAR_URL_PARAMS'       => '', // PATHINFO URL参数变量
    'URL_PATHINFO_DEPR'    => '/', //PATHINFO URL分割符

    'URL_HTML_SUFFIX'      => 'html|shtml|xml',
    // 'DEFAULT_MODULE'       =>    'Home''html|shtml|xml'
    // 'MODULE_ALLOW_LIST'    =>    array('Home','Admin','User'),
    // 'MODULE_DENY_LIST'      =>  array('Common','Runtime'),

    /* 全局过滤配置 */
    'DEFAULT_FILTER' => '', //全局过滤函数

    /* 数据库配置 */
    'DB_TYPE'   => 'mysqli', // 数据库类型

    // 'DB_HOST'   => '127.0.0.1', // 服务器地址
    // 'DB_NAME'   => 'ot', // 数据库名
    // 'DB_USER'   => 'root', // 用户名
    // 'DB_PWD'    => 'root',  // 密码

    'DB_HOST'   => 'qdm220352508.my3w.com', // 服务器地址
    'DB_NAME'   => 'qdm220352508_db', // 数据库名
    'DB_USER'   => 'qdm220352508', // 用户名
    'DB_PWD'    => 'wodemima',  // 密码

    'DB_PORT'   => '3306', // 端口
    'DB_PREFIX' => 'ot_', // 数据库表前缀

    /* 文档模型配置 (文档模型核心配置，请勿更改) */
    'DOCUMENT_MODEL_TYPE' => array(2 => '主题', 1 => '目录', 3 => '段落'),


    // 配置邮件发送服务器
    'MAIL_HOST' =>'smtp.126.com',//smtp服务器的名称
    'MAIL_SMTPAUTH' =>TRUE, //启用smtp认证
    'MAIL_USERNAME' =>'aikanglai@126.com',//你的邮箱名
    'MAIL_FROM' =>'aikanglai@126.com',//发件人地址
    'MAIL_FROMNAME'=>'艾康莱科技有限公司',//发件人姓名
    'MAIL_PASSWORD' =>'Abc123',//邮箱密码
    'MAIL_CHARSET' =>'utf-8',//设置邮件编码
    'MAIL_ISHTML' =>TRUE, // 是否HTML格式邮件
    // 'MAIL_SECURE'=>'ssl',
    // 'MAIL_PORT' => '465',

);
