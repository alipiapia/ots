/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50547
Source Host           : localhost:3306
Source Database       : ot

Target Server Type    : MYSQL
Target Server Version : 50547
File Encoding         : 65001

Date: 2016-07-22 16:31:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ot_ credential`
-- ----------------------------
DROP TABLE IF EXISTS `ot_ credential`;
CREATE TABLE `ot_ credential` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '证书id',
  `cert_no` varchar(255) NOT NULL COMMENT '证书编号',
  `create_admin` varchar(255) NOT NULL COMMENT '创建人',
  `create_time` int(11) NOT NULL COMMENT '生成时间',
  `v_period` int(11) NOT NULL COMMENT '有效期',
  `Begin_time` int(11) NOT NULL COMMENT '开始日期',
  `End_time` int(11) NOT NULL COMMENT '结束日期',
  `Cert_adminc` varchar(255) NOT NULL COMMENT '证书持有人',
  `Query_logs` int(11) NOT NULL COMMENT '查询次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_ credential
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_action`
-- ----------------------------
DROP TABLE IF EXISTS `ot_action`;
CREATE TABLE `ot_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of ot_action
-- ----------------------------
INSERT INTO `ot_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `ot_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `ot_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `ot_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `ot_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `ot_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `ot_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `ot_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `ot_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `ot_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `ot_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');

-- ----------------------------
-- Table structure for `ot_action_log`
-- ----------------------------
DROP TABLE IF EXISTS `ot_action_log`;
CREATE TABLE `ot_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=363 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of ot_action_log
-- ----------------------------
INSERT INTO `ot_action_log` VALUES ('287', '1', '31', '0', 'member', '31', 'pp1991在2016-05-13 16:03登录了后台', '1', '1463126580');
INSERT INTO `ot_action_log` VALUES ('288', '1', '17', '0', 'member', '17', 'pp1892在2016-05-13 16:37登录了后台', '1', '1463128636');
INSERT INTO `ot_action_log` VALUES ('289', '1', '1', '0', 'member', '1', 'admin在2016-05-16 09:09登录了后台', '1', '1463360961');
INSERT INTO `ot_action_log` VALUES ('290', '1', '31', '0', 'member', '31', 'pp1991在2016-05-16 09:09登录了后台', '1', '1463360982');
INSERT INTO `ot_action_log` VALUES ('291', '1', '34', '0', 'member', '34', 'pp1992在2016-05-16 09:21登录了后台', '1', '1463361717');
INSERT INTO `ot_action_log` VALUES ('292', '10', '1', '0', 'Menu', '150', '操作url：/ot/index.php/Admin/Menu/add.html', '1', '1463364758');
INSERT INTO `ot_action_log` VALUES ('293', '1', '31', '0', 'member', '31', 'pp1991在2016-05-16 16:03登录了后台', '1', '1463385795');
INSERT INTO `ot_action_log` VALUES ('294', '1', '31', '0', 'member', '31', 'pp1991在2016-05-16 16:03登录了后台', '1', '1463385833');
INSERT INTO `ot_action_log` VALUES ('295', '1', '31', '0', 'member', '31', 'pp1991在2016-05-16 17:45登录了后台', '1', '1463391916');
INSERT INTO `ot_action_log` VALUES ('296', '1', '1', '0', 'member', '1', 'admin在2016-05-17 09:04登录了后台', '1', '1463447040');
INSERT INTO `ot_action_log` VALUES ('297', '10', '1', '0', 'Menu', '151', '操作url：/ot/index.php/Admin/Menu/add.html', '1', '1463448444');
INSERT INTO `ot_action_log` VALUES ('298', '10', '1', '0', 'Menu', '152', '操作url：/ot/index.php/Admin/Menu/add.html', '1', '1463449842');
INSERT INTO `ot_action_log` VALUES ('299', '10', '1', '0', 'Menu', '153', '操作url：/ot/index.php/Admin/Menu/add.html', '1', '1463471211');
INSERT INTO `ot_action_log` VALUES ('300', '1', '30', '0', 'member', '30', 'pp1990在2016-05-17 17:03登录了后台', '1', '1463475799');
INSERT INTO `ot_action_log` VALUES ('301', '1', '17', '0', 'member', '17', 'pp1892在2016-05-17 17:09登录了后台', '1', '1463476188');
INSERT INTO `ot_action_log` VALUES ('302', '1', '17', '0', 'member', '17', 'pp1892在2016-05-17 17:17登录了后台', '1', '1463476679');
INSERT INTO `ot_action_log` VALUES ('303', '1', '1', '0', 'member', '1', 'admin在2016-05-17 17:18登录了后台', '1', '1463476695');
INSERT INTO `ot_action_log` VALUES ('304', '1', '17', '0', 'member', '17', 'pp1892在2016-05-17 17:26登录了后台', '1', '1463477173');
INSERT INTO `ot_action_log` VALUES ('305', '1', '17', '0', 'member', '17', 'pp1892在2016-05-17 17:28登录了后台', '1', '1463477328');
INSERT INTO `ot_action_log` VALUES ('306', '1', '35', '0', 'member', '35', 'pp1993在2016-05-17 17:40登录了后台', '1', '1463478054');
INSERT INTO `ot_action_log` VALUES ('307', '1', '35', '0', 'member', '35', 'pp1993在2016-05-17 17:45登录了后台', '1', '1463478312');
INSERT INTO `ot_action_log` VALUES ('308', '1', '1', '0', 'member', '1', 'admin在2016-05-17 19:38登录了后台', '1', '1463485133');
INSERT INTO `ot_action_log` VALUES ('309', '10', '1', '0', 'Menu', '154', '操作url：/ot/index.php/Admin/Menu/add.html', '1', '1463493646');
INSERT INTO `ot_action_log` VALUES ('310', '1', '17', '0', 'member', '17', 'pp1892在2016-05-17 22:54登录了后台', '1', '1463496875');
INSERT INTO `ot_action_log` VALUES ('311', '1', '1', '0', 'member', '1', 'admin在2016-05-17 22:56登录了后台', '1', '1463496965');
INSERT INTO `ot_action_log` VALUES ('312', '1', '31', '0', 'member', '31', 'pp1991在2016-05-18 09:44登录了后台', '1', '1463535862');
INSERT INTO `ot_action_log` VALUES ('313', '10', '1', '0', 'Menu', '155', '操作url：/ot/index.php/Admin/Menu/add.html', '1', '1463536508');
INSERT INTO `ot_action_log` VALUES ('314', '1', '17', '0', 'member', '17', 'pp1892在2016-05-18 10:05登录了后台', '1', '1463537119');
INSERT INTO `ot_action_log` VALUES ('315', '1', '36', '0', 'member', '36', 'pp1994在2016-05-18 10:30登录了后台', '1', '1463538636');
INSERT INTO `ot_action_log` VALUES ('316', '1', '36', '0', 'member', '36', 'pp1994在2016-05-18 10:30登录了后台', '1', '1463538654');
INSERT INTO `ot_action_log` VALUES ('317', '1', '36', '0', 'member', '36', 'pp1994在2016-05-18 11:24登录了后台', '1', '1463541856');
INSERT INTO `ot_action_log` VALUES ('318', '1', '17', '0', 'member', '17', 'pp1892在2016-05-18 14:02登录了后台', '1', '1463551353');
INSERT INTO `ot_action_log` VALUES ('319', '1', '17', '0', 'member', '17', 'pp1892在2016-05-18 14:03登录了后台', '1', '1463551417');
INSERT INTO `ot_action_log` VALUES ('320', '1', '37', '0', 'member', '37', 'pp1995在2016-05-18 14:07登录了后台', '1', '1463551629');
INSERT INTO `ot_action_log` VALUES ('321', '1', '38', '0', 'member', '38', 'pp1996在2016-05-18 14:11登录了后台', '1', '1463551871');
INSERT INTO `ot_action_log` VALUES ('322', '1', '39', '0', 'member', '39', 'pp1997在2016-05-18 14:12登录了后台', '1', '1463551974');
INSERT INTO `ot_action_log` VALUES ('323', '1', '39', '0', 'member', '39', 'pp1997在2016-05-18 14:15登录了后台', '1', '1463552130');
INSERT INTO `ot_action_log` VALUES ('324', '1', '40', '0', 'member', '40', 'pp1998在2016-05-18 14:16登录了后台', '1', '1463552204');
INSERT INTO `ot_action_log` VALUES ('325', '1', '41', '0', 'member', '41', 'pp1999在2016-05-18 14:18登录了后台', '1', '1463552289');
INSERT INTO `ot_action_log` VALUES ('326', '1', '41', '0', 'member', '41', 'pp1999在2016-05-18 14:18登录了后台', '1', '1463552322');
INSERT INTO `ot_action_log` VALUES ('327', '1', '41', '0', 'member', '41', 'pp1999在2016-05-18 14:42登录了后台', '1', '1463553745');
INSERT INTO `ot_action_log` VALUES ('328', '1', '42', '0', 'member', '42', 'pp2000在2016-05-18 14:43登录了后台', '1', '1463553838');
INSERT INTO `ot_action_log` VALUES ('329', '1', '42', '0', 'member', '42', 'pp2000在2016-05-18 14:44登录了后台', '1', '1463553880');
INSERT INTO `ot_action_log` VALUES ('330', '1', '43', '0', 'member', '43', 'pp2001在2016-05-18 14:46登录了后台', '1', '1463553977');
INSERT INTO `ot_action_log` VALUES ('331', '1', '43', '0', 'member', '43', 'pp2001在2016-05-18 14:47登录了后台', '1', '1463554022');
INSERT INTO `ot_action_log` VALUES ('332', '1', '1', '0', 'member', '1', 'admin在2016-05-19 09:04登录了后台', '1', '1463619869');
INSERT INTO `ot_action_log` VALUES ('333', '1', '41', '0', 'member', '41', 'pp1999在2016-05-19 09:05登录了后台', '1', '1463619929');
INSERT INTO `ot_action_log` VALUES ('334', '1', '17', '0', 'member', '17', 'pp1892在2016-05-19 09:05登录了后台', '1', '1463619946');
INSERT INTO `ot_action_log` VALUES ('335', '1', '20', '0', 'member', '20', 'pp1889在2016-05-19 09:52登录了后台', '1', '1463622763');
INSERT INTO `ot_action_log` VALUES ('336', '1', '20', '0', 'member', '20', 'pp1889在2016-05-19 10:10登录了后台', '1', '1463623803');
INSERT INTO `ot_action_log` VALUES ('337', '1', '20', '0', 'member', '20', 'pp1889在2016-05-19 10:17登录了后台', '1', '1463624277');
INSERT INTO `ot_action_log` VALUES ('338', '11', '1', '0', 'category', '54', '操作url：/ot/index.php/Admin/Category/add.html', '1', '1463624964');
INSERT INTO `ot_action_log` VALUES ('339', '1', '41', '0', 'member', '41', 'pp1999在2016-05-19 13:39登录了后台', '1', '1463636361');
INSERT INTO `ot_action_log` VALUES ('340', '10', '1', '0', 'Menu', '155', '操作url：/ot/index.php/Admin/Menu/edit.html', '1', '1463637911');
INSERT INTO `ot_action_log` VALUES ('341', '10', '1', '0', 'Menu', '156', '操作url：/ot/index.php/Admin/Menu/add.html', '1', '1463637941');
INSERT INTO `ot_action_log` VALUES ('342', '10', '1', '0', 'Menu', '157', '操作url：/ot/index.php/Admin/Menu/add.html', '1', '1463638290');
INSERT INTO `ot_action_log` VALUES ('343', '10', '1', '0', 'Menu', '157', '操作url：/ot/index.php/Admin/Menu/edit.html', '1', '1463638312');
INSERT INTO `ot_action_log` VALUES ('344', '1', '41', '0', 'member', '41', 'pp1999在2016-05-19 16:18登录了后台', '1', '1463645905');
INSERT INTO `ot_action_log` VALUES ('345', '1', '46', '0', 'member', '46', 'pp2005在2016-05-19 16:20登录了后台', '1', '1463646000');
INSERT INTO `ot_action_log` VALUES ('346', '1', '1', '0', 'member', '1', 'admin在2016-05-20 09:20登录了后台', '1', '1463707242');
INSERT INTO `ot_action_log` VALUES ('347', '1', '41', '0', 'member', '41', 'pp1999在2016-05-20 10:18登录了后台', '1', '1463710706');
INSERT INTO `ot_action_log` VALUES ('348', '1', '41', '0', 'member', '41', 'pp1999在2016-05-20 14:04登录了后台', '1', '1463724256');
INSERT INTO `ot_action_log` VALUES ('349', '1', '41', '0', 'member', '41', 'pp1999在2016-05-20 14:06登录了后台', '1', '1463724369');
INSERT INTO `ot_action_log` VALUES ('350', '1', '41', '0', 'member', '41', 'pp1999在2016-05-20 15:28登录了后台', '1', '1463729283');
INSERT INTO `ot_action_log` VALUES ('351', '1', '41', '0', 'member', '41', 'pp1999在2016-05-20 15:28登录了后台', '1', '1463729325');
INSERT INTO `ot_action_log` VALUES ('352', '1', '1', '2130706433', 'member', '1', 'admin在2016-06-20 20:11登录了后台', '1', '1466424715');
INSERT INTO `ot_action_log` VALUES ('353', '1', '1', '2130706433', 'member', '1', 'admin在2016-07-17 16:36登录了后台', '1', '1468744561');
INSERT INTO `ot_action_log` VALUES ('354', '1', '1', '2130706433', 'member', '1', 'admin在2016-07-17 21:25登录了后台', '1', '1468761939');
INSERT INTO `ot_action_log` VALUES ('355', '1', '1', '2130706433', 'member', '1', 'admin在2016-07-17 21:48登录了后台', '1', '1468763298');
INSERT INTO `ot_action_log` VALUES ('356', '1', '1', '2130706433', 'member', '1', 'admin在2016-07-17 21:53登录了后台', '1', '1468763615');
INSERT INTO `ot_action_log` VALUES ('357', '1', '1', '2130706433', 'member', '1', 'admin在2016-07-17 22:08登录了后台', '1', '1468764530');
INSERT INTO `ot_action_log` VALUES ('358', '1', '1', '2130706433', 'member', '1', 'admin在2016-07-18 11:27登录了后台', '1', '1468812425');
INSERT INTO `ot_action_log` VALUES ('359', '1', '1', '2130706433', 'member', '1', 'admin在2016-07-18 12:10登录了后台', '1', '1468815030');
INSERT INTO `ot_action_log` VALUES ('360', '1', '1', '0', 'member', '1', 'admin在2016-07-22 15:57登录了后台', '1', '1469174264');
INSERT INTO `ot_action_log` VALUES ('361', '1', '41', '0', 'member', '41', 'pp1999在2016-07-22 16:21登录了后台', '1', '1469175700');
INSERT INTO `ot_action_log` VALUES ('362', '1', '1', '0', 'member', '1', 'admin在2016-07-22 16:22登录了后台', '1', '1469175740');

-- ----------------------------
-- Table structure for `ot_addons`
-- ----------------------------
DROP TABLE IF EXISTS `ot_addons`;
CREATE TABLE `ot_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of ot_addons
-- ----------------------------
INSERT INTO `ot_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `ot_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `ot_addons` VALUES ('3', 'DevTeam', '开发团队信息', '开发团队成员信息', '1', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512022', '0');
INSERT INTO `ot_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `ot_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"2\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `ot_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `ot_addons` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'thinkphp', '0.1', '1380273962', '0');

-- ----------------------------
-- Table structure for `ot_agents`
-- ----------------------------
DROP TABLE IF EXISTS `ot_agents`;
CREATE TABLE `ot_agents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级ID',
  `agent_grade` tinyint(4) NOT NULL COMMENT '代理级别',
  `agent_no` varchar(64) NOT NULL COMMENT '代理商编号',
  `agent_product` varchar(255) NOT NULL COMMENT '授权品牌',
  `real_name` varchar(255) NOT NULL COMMENT '真实姓名',
  `username` varchar(255) NOT NULL COMMENT '姓名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `wx_id` varchar(255) NOT NULL COMMENT '微信号',
  `email` varchar(255) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` varchar(64) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录ip',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '代理商状态；（0试用、1正式、2已暂停、3违规）；',
  `is_review` tinyint(4) NOT NULL COMMENT '审核状态',
  `id_no` varchar(20) NOT NULL COMMENT '身份证号码',
  `company` varchar(255) NOT NULL COMMENT '公司名称',
  `region` varchar(255) NOT NULL COMMENT '地区',
  `review_begin_time` int(11) NOT NULL COMMENT '授权开始日期',
  `review_end_time` int(11) NOT NULL COMMENT '授权结束日期',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of ot_agents
-- ----------------------------
INSERT INTO `ot_agents` VALUES ('1', '0', '0', '1166-A505-AB62-4D99', '', '', 'admin', '333be91203a410a590e9e7e141119fe1', '', 'admin@admin.com', '77', '1462324945', '0', '0', '0', '1462324945', '1', '1', '', 'c', 'd', '0', '0');
INSERT INTO `ot_agents` VALUES ('2', '1', '2', '', '', '', 'pengpu', '404a10052653c29f4383dba3108c9da6', '', '1@q.com', '33', '1462327163', '0', '0', '0', '1462327163', '1', '0', '', 'h', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('12', '11', '0', '', '', '', 'pp1882', '111111', '', 'pp1882@qq.com', '18788881111', '1462375898', '0', '0', '0', '1462375898', '1', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('11', '2', '1', '', '', '', 'pp1881', '111111', '', 'pp1881@qq.com', '13011110000', '1462375723', '0', '0', '0', '1462375723', '1', '0', '', 'ddd', 'ccc', '0', '0');
INSERT INTO `ot_agents` VALUES ('13', '1', '0', '', '', '', 'pp1883', '404a10052653c29f4383dba3108c9da6', '', 'pp1883@qq.com', '', '1462375928', '0', '0', '0', '1462375928', '2', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('14', '1', '0', '', '', '', 'pp1884', '404a10052653c29f4383dba3108c9da6', '', 'pp1884@qq.com', '', '1462411829', '0', '0', '0', '1462411829', '1', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('15', '14', '2', '', '', '', 'pp1885', '111111', '', 'pp1885@gmail.com', '18900098765', '1462412273', '0', '0', '0', '1462412273', '1', '0', '', 'vvvv', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('16', '13', '2', '', '', '', 'pp1886', '111111', '', 'pp1886@qq.com', '15833332222', '1462412378', '0', '0', '0', '1462412378', '1', '0', '', 'nn', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('17', '2', '7', 'F4F5-479E-189C-B690-7A6D', '大力丸111', '白展堂', 'pp1887', 'c6a4610156bb7df0ea0f9d6adf94ef47', 'eviss', 'pp1887@qq.com', '18765676543', '1462412440', '0', '0', '0', '1462412440', '1', '1', '530325190012131111', '富士康111', '成都', '1470931200', '1930521600');
INSERT INTO `ot_agents` VALUES ('18', '12', '1', '', '', '', 'pp1888', '404a10052653c29f4383dba3108c9da6', '', 'pp1888@qq.com', '18654320989', '1462413125', '0', '0', '0', '1462413125', '0', '0', '', 'c', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('19', '17', '7', '7292-E79C-E909-489E', '阿迪达斯', '', 'pp8887', '404a10052653c29f4383dba3108c9da6', 'vvv', 'pp8887@qq.com', '18299999999', '1462417372', '0', '0', '0', '1462417372', '3', '1', '', '玩大', '昆明', '0', '0');
INSERT INTO `ot_agents` VALUES ('20', '19', '2', '', '', '', 'pp1889', '404a10052653c29f4383dba3108c9da6', '', 'pp1889@qq.com', '18900097877', '1462420650', '0', '0', '0', '1462420650', '0', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('21', '1', '1', '', '', '', 'pp1890', '8d8a5713b5ac8f9c05b51d4fe55028c5', '', 'pp1890@qq.com', '18765434444', '1462420915', '0', '0', '0', '1462420915', '0', '0', '', 'wfwfwefwfwfw', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('22', '17', '7', '66E3-4960-7B2B-9FA7-8B41', '小米辣盖饭', '李大嘴', 'pp1891', '404a10052653c29f4383dba3108c9da6', 'alipiapia', 'pp1891@qq.com', '18566665555', '1462421006', '0', '0', '0', '1462421006', '1', '1', '530325199999999990', '大中华', '昆明', '1425600000', '1706659200');
INSERT INTO `ot_agents` VALUES ('23', '0', '0', '', '', '', 'pp1893', '404a10052653c29f4383dba3108c9da6', '', '1@qwq.com', '18255556666', '1462773146', '0', '0', '0', '1462773146', '0', '0', '', '急急急', '云南', '0', '0');
INSERT INTO `ot_agents` VALUES ('24', '17', '7', '', '', '', 'pp1894', '404a10052653c29f4383dba3108c9da6', '', '23222@wwwww.com', '18259554444', '1462773245', '0', '0', '0', '1462773245', '0', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('26', '1', '1', '', '', '', 'pp1896', '404a10052653c29f4383dba3108c9da6', '', 'wwww@moinjc.com', '18233336665', '1462773691', '0', '0', '0', '1462773691', '0', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('29', '1', '1', '96BC-4761-D1A6-9D18-21DB', '黑心棉1122', '', 'pp1899', '404a10052653c29f4383dba3108c9da6', '', '23w333@mnvde.com', '18965456665', '1462784722', '0', '0', '0', '1462784722', '1', '1', '', '', '', '1265068800', '1394064000');
INSERT INTO `ot_agents` VALUES ('30', '1', '1', 'C8A8-4F53-EB1C-B52D-F2E7', '春城', '', 'pp1990', '404a10052653c29f4383dba3108c9da6', '', '2@eeeeeeeee.com', '18564569887', '1462785319', '0', '0', '0', '1462785319', '1', '1', '', '', '', '86400', '71366400');
INSERT INTO `ot_agents` VALUES ('31', '1', '1', '', 'ffff', '莫小贝', 'pp1991', '404a10052653c29f4383dba3108c9da6', 'siweididadi', '2@eee2eeeeee.com', '18561569887', '1462785445', '0', '0', '0', '1462785445', '0', '0', '530325190011111111', '同讯科技', '昆明', '0', '0');
INSERT INTO `ot_agents` VALUES ('32', '1', '1', '', '', '', 'mobile', 'b4113d07a599df1d9670504ae3c23e84', '', 'q@ss.com', '18566666666', '1463045112', '0', '0', '0', '1463045112', '0', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('33', '2', '6', '', '', '', 'pp1900', '404a10052653c29f4383dba3108c9da6', '', 'n@qq.com', '18208702258', '1463056427', '0', '0', '0', '1463056427', '0', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('34', '31', '2', '8234-49C6-F285-AF7F-4BF2', '红河111', '王小虎', 'pp1992', '404a10052653c29f4383dba3108c9da6', 'siweididadi1', '124@qqq.com', '18566667777', '1463361705', '0', '0', '0', '1463361705', '1', '1', '530325199999999999', '卷烟厂', '曲靖', '1462147200', '1574812800');
INSERT INTO `ot_agents` VALUES ('35', '18', '7', '', '', '', 'pp1993', '111111', '', '123@qqq.com', '18800000000', '1463478043', '0', '0', '0', '1463478043', '0', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('36', '20', '6', '', '大力丸2222', '', 'pp1994', 'c540d6e67132f251bce6575d6580f99b', '365poieee', 'we@cc.com', '18259468888', '1463538615', '0', '0', '0', '1463538615', '0', '0', '530326555544445555', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('37', '24', '2', '', 'dedede', '', 'pp1995', '404a10052653c29f4383dba3108c9da6', 'efwefwfwfwe', '2@qqqqwwww.com', '18900001111', '1463538898', '0', '0', '0', '1463538898', '0', '0', '530222222222223333', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('38', '0', '0', '', 'dddd', '', 'pp1996', '404a10052653c29f4383dba3108c9da6', 'ddwdwd', '1m@qqq.com', '18566698887', '1463551830', '0', '0', '0', '1463551830', '0', '0', '530333333333333333', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('39', '0', '0', '', 'vsdvsds', '', 'pp1997', '404a10052653c29f4383dba3108c9da6', 'wkhwew', '1wwwwwwwwwww@qq.com', '18788889999', '1463551967', '0', '0', '0', '1463551967', '3', '0', '530325190012131112', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('40', '0', '0', '', 'wfwfw', '', 'pp1998', '404a10052653c29f4383dba3108c9da6', 'fwfwefw', '121@qqqq.com', '18799990000', '1463552170', '0', '0', '0', '1463552170', '0', '0', '539888877776666', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('41', '0', '0', '75304F0F998BA737', 'efwefwf', '吕轻侯', 'pp1999', '404a10052653c29f4383dba3108c9da6', 'aliuu', '124910168@qq.com', '18766666666', '1463552264', '0', '0', '0', '1463552264', '1', '1', '530325199988887778', '兴苑路', '重庆', '1463555280', '1540883280');
INSERT INTO `ot_agents` VALUES ('42', '0', '0', 'A90F4F02A75D628A', 'gere', '令狐冲', 'pp2000', 'c50a040388181b2e297c68ed11673b95', 'sffwf', 'dddddeqq@qqq.com', '18799996665', '1463553821', '0', '0', '0', '1463553821', '1', '1', '545555555555555555', '', '大理', '1463554740', '1574319540');
INSERT INTO `ot_agents` VALUES ('43', '0', '0', 'D3574EE0F50C', 'gggg', '李大嘴', 'pp2001', 'e4dcd9ef89857a9faaed1e6f054bacaf', 'fwfwf', '10dddddm@qqo.com', '18765434442', '1463553938', '0', '0', '0', '1463553938', '1', '1', '530325444444444444', '', '', '1463554260', '1574923860');
INSERT INTO `ot_agents` VALUES ('44', '31', '2', '', '', '', 'pp2002', '404a10052653c29f4383dba3108c9da6', '', '223e@www.com', '18900003522', '1463635095', '0', '0', '0', '1463635095', '0', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('45', '1', '1', '', '', '', 'pp2003', '404a10052653c29f4383dba3108c9da6', '', 'fewqqq@ppp.com', '18577768889', '1463635685', '0', '0', '0', '1463635685', '0', '0', '', '', '', '0', '0');
INSERT INTO `ot_agents` VALUES ('46', '1', '1', '', '', '', 'pp2005', '8d8a5713b5ac8f9c05b51d4fe55028c5', '', '13555555555@qq.com', '13555555555', '1463645993', '0', '0', '0', '1463645993', '0', '0', '', '', '', '0', '0');

-- ----------------------------
-- Table structure for `ot_agents_grade`
-- ----------------------------
DROP TABLE IF EXISTS `ot_agents_grade`;
CREATE TABLE `ot_agents_grade` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_agents_grade
-- ----------------------------
INSERT INTO `ot_agents_grade` VALUES ('1', '省级', '0', '0');
INSERT INTO `ot_agents_grade` VALUES ('2', '市级', '1', '0');
INSERT INTO `ot_agents_grade` VALUES ('6', '县级', '2', '0');
INSERT INTO `ot_agents_grade` VALUES ('7', '镇级', '6', '0');

-- ----------------------------
-- Table structure for `ot_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `ot_attachment`;
CREATE TABLE `ot_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of ot_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `ot_attribute`;
CREATE TABLE `ot_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of ot_attribute
-- ----------------------------
INSERT INTO `ot_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '1:列表推荐\r\n2:频道页推荐\r\n4:首页推荐', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `ot_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `ot_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `ot_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `ot_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `ot_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');

-- ----------------------------
-- Table structure for `ot_auth_extend`
-- ----------------------------
DROP TABLE IF EXISTS `ot_auth_extend`;
CREATE TABLE `ot_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of ot_auth_extend
-- ----------------------------
INSERT INTO `ot_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `ot_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `ot_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `ot_auth_extend` VALUES ('2', '1', '1');
INSERT INTO `ot_auth_extend` VALUES ('2', '2', '1');
INSERT INTO `ot_auth_extend` VALUES ('2', '39', '1');
INSERT INTO `ot_auth_extend` VALUES ('2', '40', '1');

-- ----------------------------
-- Table structure for `ot_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `ot_auth_group`;
CREATE TABLE `ot_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_auth_group
-- ----------------------------
INSERT INTO `ot_auth_group` VALUES ('1', 'admin', '1', '代理商用户组', '代理商用户组', '1', '1,53,108,109,221,222,223,224,227,228,235,236,239,240,242,243,245,247,248');
INSERT INTO `ot_auth_group` VALUES ('2', 'admin', '1', '测试用户组', '测试用户组', '1', '1');

-- ----------------------------
-- Table structure for `ot_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `ot_auth_group_access`;
CREATE TABLE `ot_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_auth_group_access
-- ----------------------------
INSERT INTO `ot_auth_group_access` VALUES ('2', '1');
INSERT INTO `ot_auth_group_access` VALUES ('9', '1');
INSERT INTO `ot_auth_group_access` VALUES ('10', '1');
INSERT INTO `ot_auth_group_access` VALUES ('11', '1');
INSERT INTO `ot_auth_group_access` VALUES ('12', '1');
INSERT INTO `ot_auth_group_access` VALUES ('13', '1');
INSERT INTO `ot_auth_group_access` VALUES ('14', '1');
INSERT INTO `ot_auth_group_access` VALUES ('15', '1');
INSERT INTO `ot_auth_group_access` VALUES ('16', '1');
INSERT INTO `ot_auth_group_access` VALUES ('17', '1');
INSERT INTO `ot_auth_group_access` VALUES ('18', '1');
INSERT INTO `ot_auth_group_access` VALUES ('19', '1');
INSERT INTO `ot_auth_group_access` VALUES ('20', '1');
INSERT INTO `ot_auth_group_access` VALUES ('21', '1');
INSERT INTO `ot_auth_group_access` VALUES ('23', '1');
INSERT INTO `ot_auth_group_access` VALUES ('25', '1');
INSERT INTO `ot_auth_group_access` VALUES ('31', '1');
INSERT INTO `ot_auth_group_access` VALUES ('32', '1');
INSERT INTO `ot_auth_group_access` VALUES ('33', '1');
INSERT INTO `ot_auth_group_access` VALUES ('34', '1');
INSERT INTO `ot_auth_group_access` VALUES ('35', '1');
INSERT INTO `ot_auth_group_access` VALUES ('41', '1');
INSERT INTO `ot_auth_group_access` VALUES ('42', '1');
INSERT INTO `ot_auth_group_access` VALUES ('43', '1');

-- ----------------------------
-- Table structure for `ot_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `ot_auth_rule`;
CREATE TABLE `ot_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=249 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_auth_rule
-- ----------------------------
INSERT INTO `ot_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/mydocument', '内容', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '用户', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '用户信息', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `ot_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('217', 'admin', '1', 'Admin/Products/p_list', '产品列表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('218', 'admin', '1', 'Admin/Products/add', '产品添加', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('219', 'admin', '1', 'Admin/News/n_list', '新闻列表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('220', 'admin', '1', 'Admin/News/add', '添加新闻', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('221', 'admin', '1', 'Admin/Agents/a_list', '代理商列表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('222', 'admin', '1', 'Admin/InvCode/i_list', '邀请码列表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('223', 'admin', '1', 'Admin/Certs/c_list', '证书列表', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('224', 'admin', '1', 'Admin/InvCode/add', '添加邀请码', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('225', 'admin', '1', 'Admin/Agents/add', '添加代理商', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('226', 'admin', '1', 'Admin/Certs/add', '添加证书', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('227', 'admin', '2', 'Admin/Agents/a_list', '代理商', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('228', 'admin', '1', 'Admin/Reports/r_list', '违规举报', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('229', 'admin', '1', 'Admin/AgentsGrade/add', '添加代理商等级', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('230', 'admin', '1', 'Admin/AgentsGrade/edit', '编辑代理商等级', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('231', 'admin', '1', 'Admin/Certs/edit', '编辑证书', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('232', 'admin', '1', 'Admin/InvCode/edit', '编辑邀请码', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('233', 'admin', '1', 'Admin/Products/edit', '编辑产品', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('234', 'admin', '1', 'Admin/News/edit', '编辑新闻', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('235', 'admin', '1', 'Admin/Reports/add', '添加举报', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('236', 'admin', '1', 'Admin/Reports/edit', '编辑举报', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('237', 'admin', '1', 'Admin/AgentsGrade/g_list', '代理商等级', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('238', 'admin', '1', 'Admin/Agents/edit', '编辑代理商', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('239', 'admin', '1', 'Admin/Agents/review', '代理商审核', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('240', 'admin', '1', 'Admin/Agents/view', '代理商查看', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('241', 'admin', '1', 'Admin/Reports/review', '违规审核', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('242', 'admin', '1', 'Admin/User/updateProfile', '完善资料', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('243', 'admin', '1', 'Admin/Certs/view', '查看证书', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('244', 'admin', '1', 'Admin/Products/auto_create', '批量生成产品', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('245', 'admin', '1', 'Admin/Reports/view', '查看举报', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('246', 'admin', '1', 'Admin/Products/pro_import', '产品导入', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('247', 'admin', '2', 'Admin/Home/Index/index', '前台首页', '1', '');
INSERT INTO `ot_auth_rule` VALUES ('248', 'admin', '1', 'Admin/Agents/index_tree', '代理商列表（树形）', '1', '');

-- ----------------------------
-- Table structure for `ot_category`
-- ----------------------------
DROP TABLE IF EXISTS `ot_category`;
CREATE TABLE `ot_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of ot_category
-- ----------------------------
INSERT INTO `ot_category` VALUES ('1', 'enterprise', '企业介绍', '0', '3', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '0', '0', '1', '', '1379474947', '1462696996', '1', '0');
INSERT INTO `ot_category` VALUES ('2', 'enterprise_brief', '企业概况', '1', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '0', '0', '1', '', '1379475028', '1462629911', '1', '31');
INSERT INTO `ot_category` VALUES ('39', 'news', '新闻中心', '0', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1461721083', '1463033948', '1', '0');
INSERT INTO `ot_category` VALUES ('40', 'news_company', '公司动态', '39', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1461721132', '1462697011', '1', '0');
INSERT INTO `ot_category` VALUES ('41', 'news_industry', '行业新闻', '39', '2', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462629800', '1462697013', '1', '0');
INSERT INTO `ot_category` VALUES ('42', 'news_activity', '活动专栏', '39', '3', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462629834', '1462697015', '1', '0');
INSERT INTO `ot_category` VALUES ('43', 'news_video', '企业视频', '39', '4', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462629874', '1462697017', '1', '0');
INSERT INTO `ot_category` VALUES ('44', 'enterprise_culture', '企业文化', '1', '2', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462629983', '1462697004', '1', '0');
INSERT INTO `ot_category` VALUES ('45', 'enterprise_advantage', '核心优势', '1', '3', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462630076', '1462697009', '1', '0');
INSERT INTO `ot_category` VALUES ('46', 'products', '产品展示', '0', '2', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462696347', '1462696998', '1', '0');
INSERT INTO `ot_category` VALUES ('47', 'products_new', '护肤产品', '46', '0', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462706614', '1463108342', '1', '0');
INSERT INTO `ot_category` VALUES ('48', 'intro', '宣传', '43', '0', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462760909', '1462760909', '1', '0');
INSERT INTO `ot_category` VALUES ('49', 'contact', '联系我们', '0', '0', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462760974', '1462760974', '1', '0');
INSERT INTO `ot_category` VALUES ('50', 'contact_way', '联系方式', '49', '0', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462780268', '1462780268', '1', '0');
INSERT INTO `ot_category` VALUES ('51', 'contact_map', '电子地图', '49', '0', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1462780291', '1462780291', '1', '0');
INSERT INTO `ot_category` VALUES ('52', 'products_old', '保湿产品', '46', '0', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '1', '1', '1', '0', '', '', '1463030429', '1463108352', '1', '0');
INSERT INTO `ot_category` VALUES ('53', 'products_pot', '洗浴产品', '46', '0', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1463039176', '1463108336', '1', '0');
INSERT INTO `ot_category` VALUES ('54', 'Join', '加盟流程', '0', '0', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '2', '1', '1', '0', '', '', '1463624964', '1463624964', '1', '0');

-- ----------------------------
-- Table structure for `ot_certs`
-- ----------------------------
DROP TABLE IF EXISTS `ot_certs`;
CREATE TABLE `ot_certs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '证书id',
  `cert_no` varchar(255) NOT NULL COMMENT '证书编号',
  `create_admin` varchar(255) NOT NULL COMMENT '创始人',
  `create_time` int(11) NOT NULL COMMENT '生成时间',
  `v_period` int(11) NOT NULL COMMENT '有效期',
  `pic_url` varchar(255) NOT NULL COMMENT '证书上传地址',
  `begin_time` int(11) NOT NULL COMMENT '开始日期',
  `end_time` int(11) NOT NULL COMMENT '结束日期',
  `cert_admin` varchar(255) NOT NULL COMMENT '证书持有人',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_certs
-- ----------------------------
INSERT INTO `ot_certs` VALUES ('4', 'xh001', '1', '1462342089', '0', '', '123456', '123456', '');
INSERT INTO `ot_certs` VALUES ('7', 'F4F5-479E-189C-B690-7A6D', '1', '1462872954', '0', './Uploads/Certs/cert-pp1887-2016-05-10.png', '1470931200', '1930521600', '17');
INSERT INTO `ot_certs` VALUES ('8', '96BC-4761-D1A6-9D18-21DB', '1', '1462873459', '0', './Uploads/Certs/cert-pp1899-2016-05-10.png', '1265068800', '1394064000', '29');
INSERT INTO `ot_certs` VALUES ('9', '66E3-4960-7B2B-9FA7-8B41', '1', '1463060648', '0', '/Uploads/Certs/pp1891-cert-22.png', '1425600000', '1706659200', '22');
INSERT INTO `ot_certs` VALUES ('10', '8234-49C6-F285-AF7F-4BF2', '1', '1463362301', '0', '/Uploads/Certs/pp1992-cert-34.png', '1462147200', '1574812800', '34');
INSERT INTO `ot_certs` VALUES ('11', 'D3574EE0F50C', '1', '1463554318', '0', '/Uploads/Certs/pp2001-cert-43.png', '1463554260', '1574923860', '43');
INSERT INTO `ot_certs` VALUES ('12', 'A90F4F02A75D628A', '1', '1463554797', '0', '/Uploads/Certs/pp2000-cert-42.png', '1463554740', '1574319540', '42');
INSERT INTO `ot_certs` VALUES ('13', '75304F0F998BA737', '1', '1463555346', '0', '/Uploads/Certs/pp1999-cert-41.png', '1463555280', '1540883280', '41');

-- ----------------------------
-- Table structure for `ot_channel`
-- ----------------------------
DROP TABLE IF EXISTS `ot_channel`;
CREATE TABLE `ot_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_channel
-- ----------------------------
INSERT INTO `ot_channel` VALUES ('1', '0', '首页', 'Index/index', '1', '1379475111', '1379923177', '1', '0');
INSERT INTO `ot_channel` VALUES ('2', '0', '产品', 'Article/index?category=products', '2', '1379475131', '1462696824', '1', '0');
INSERT INTO `ot_channel` VALUES ('3', '0', '新闻', 'Article/index?category=news', '3', '1379475154', '1461723711', '1', '0');
INSERT INTO `ot_channel` VALUES ('4', '0', '企业', 'Article/index?category=enterprise', '4', '1462696856', '1462696935', '1', '0');
INSERT INTO `ot_channel` VALUES ('5', '0', '联系我们', 'Article/index?category=contact', '5', '1462760855', '1462760855', '1', '0');

-- ----------------------------
-- Table structure for `ot_comments`
-- ----------------------------
DROP TABLE IF EXISTS `ot_comments`;
CREATE TABLE `ot_comments` (
  ` id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `com_id` int(11) NOT NULL COMMENT '评论文章id',
  `contents` text NOT NULL COMMENT '内容',
  `com_admin` int(11) NOT NULL COMMENT '评论人',
  `com_time` int(11) NOT NULL COMMENT '评论时间',
  `com_ip` int(64) NOT NULL COMMENT '评论ip',
  `is_review` tinyint(4) NOT NULL COMMENT '是否审核',
  PRIMARY KEY (` id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_comments
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_config`
-- ----------------------------
DROP TABLE IF EXISTS `ot_config`;
CREATE TABLE `ot_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_config
-- ----------------------------
INSERT INTO `ot_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', '艾康莱', '0');
INSERT INTO `ot_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', '艾康莱代理商管理系统', '1');
INSERT INTO `ot_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'ThinkPHP', '8');
INSERT INTO `ot_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `ot_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '2');
INSERT INTO `ot_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '滇ICP备15008235号', '9');
INSERT INTO `ot_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', '3');
INSERT INTO `ot_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `ot_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'default_color', '10');
INSERT INTO `ot_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', '4');
INSERT INTO `ot_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `ot_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `ot_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `ot_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `ot_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '10', '10');
INSERT INTO `ot_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `ot_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '3');
INSERT INTO `ot_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `ot_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `ot_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `ot_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `ot_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `ot_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '0');
INSERT INTO `ot_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `ot_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '0');
INSERT INTO `ot_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `ot_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '1');
INSERT INTO `ot_config` VALUES ('38', 'COMPANY_NAME', '1', '公司名称', '3', '', '公司名称', '1463021411', '1463021411', '1', '艾康莱（北京）科技有限公司', '0');
INSERT INTO `ot_config` VALUES ('39', 'COMPANY_PHONE', '1', '业务电话', '3', '', '业务电话', '1463021480', '1463022414', '1', '0871-63935390', '0');
INSERT INTO `ot_config` VALUES ('40', 'COMPANY_QQ', '1', 'QQ', '3', '', 'QQ', '1463021501', '1463022424', '1', '12043006', '0');
INSERT INTO `ot_config` VALUES ('41', 'COMPANY_EMAIL', '1', 'email', '3', '', 'email', '1463021520', '1463022436', '1', 'info@ynweb.com', '0');
INSERT INTO `ot_config` VALUES ('42', 'COMPANY_GRAPH', '1', '传真', '3', '', '传真', '1463021575', '1463022444', '1', '0871-68217962', '0');
INSERT INTO `ot_config` VALUES ('43', 'COMPANY_ADDRESS', '1', '公司地址', '3', '', '公司地址', '1463021604', '1463022451', '1', '北京市海淀区阜成路28号航医大厦三层（308）', '0');
INSERT INTO `ot_config` VALUES ('44', 'WEB_SITE_URL', '1', '站点URL', '1', '', '站点URL', '1463060457', '1463060457', '1', 'www.aklwealth.com', '0');

-- ----------------------------
-- Table structure for `ot_contact`
-- ----------------------------
DROP TABLE IF EXISTS `ot_contact`;
CREATE TABLE `ot_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `re_ip` varchar(255) NOT NULL COMMENT '修改ip',
  `re_admin` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_contact
-- ----------------------------
INSERT INTO `ot_contact` VALUES ('1', '联系方式', '<p>\r\n	电话：1314159\r\n</p>\r\n<p>\r\n	qq:1314159\r\n</p>\r\n<p>\r\n	<br />\r\n</p>', '192.168.1.155', '1');
INSERT INTO `ot_contact` VALUES ('2', '电子地图', '<p>\r\n	<iframe src=\"/ot/Public/static/kindeditor/plugins/baidumap/index.html?center=102.673306%2C25.035493&zoom=17&width=558&height=360&markers=102.673306%2C25.035493&markerStyles=l%2CA\" frameborder=\"0\" style=\"width:560px;height:362px;\">\r\n	</iframe>\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>', '192.168.1.155', '1');

-- ----------------------------
-- Table structure for `ot_document`
-- ----------------------------
DROP TABLE IF EXISTS `ot_document`;
CREATE TABLE `ot_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of ot_document
-- ----------------------------
INSERT INTO `ot_document` VALUES ('1', '1', '', '企业概况', '2', '同讯网络专业提供信息化解决方案，专注于为企业提供计算机软件开发、网站建设、效果分析、移动互联网微信及APP智能系统开发等互联网信息一站式服务的IT公司。核心技术产品为整合“传统PC网络+移动互联网+微信及APP大数据”', '0', '0', '2', '2', '0', '0', '5', '1', '0', '0', '17', '0', '0', '0', '1387260660', '1463108696', '1');
INSERT INTO `ot_document` VALUES ('3', '1', '', '网站建设中容易忽视的内容以及一些误区', '40', '互联网平台已经成为企业推广的重要平台，适应客户碎片化时间的网络营销不断在逐步发展，正由于互联网发展的', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '7', '0', '0', '0', '1461721320', '1463108796', '1');
INSERT INTO `ot_document` VALUES ('4', '1', '', '行业新闻001', '41', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '1', '0', '0', '0', '1462697052', '1462697052', '1');
INSERT INTO `ot_document` VALUES ('5', '1', '', '活动专栏001', '42', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '1', '0', '0', '0', '1462697070', '1462697070', '1');
INSERT INTO `ot_document` VALUES ('6', '1', '', '企业视频001', '43', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '2', '0', '0', '0', '1462697085', '1462697085', '1');
INSERT INTO `ot_document` VALUES ('8', '1', '', '企业文化001', '44', '企业文化001', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '1', '0', '0', '0', '1462697100', '1463108528', '1');
INSERT INTO `ot_document` VALUES ('9', '1', '', '核心优势001', '45', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '2', '0', '0', '0', '1462697156', '1462697156', '1');
INSERT INTO `ot_document` VALUES ('10', '1', '', '护肤产品001', '47', '护肤产品', '0', '0', '2', '2', '0', '0', '3', '1', '0', '0', '1', '0', '0', '0', '1462706580', '1463391629', '1');
INSERT INTO `ot_document` VALUES ('11', '1', '', '电子地图', '51', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '1', '0', '0', '0', '1462780383', '1462780383', '1');
INSERT INTO `ot_document` VALUES ('12', '1', '', '联系方式', '50', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '1', '0', '0', '0', '1462780423', '1462780423', '1');
INSERT INTO `ot_document` VALUES ('13', '1', '', '保湿产品', '52', '保湿产品', '0', '0', '2', '2', '0', '0', '4', '1', '0', '0', '0', '0', '0', '0', '1463030400', '1463108442', '1');
INSERT INTO `ot_document` VALUES ('19', '1', '', '网站建设中容易忽视的内容以及一些误区', '40', '互联网平台已经成为企业推广的重要平台，适应客户碎片化时间的网络营销不断在逐步发展，正由于互联网发展的', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1463108811', '1463108811', '1');
INSERT INTO `ot_document` VALUES ('18', '1', '', '洗浴产品', '53', '洗浴产品', '0', '0', '2', '2', '0', '0', '2', '1', '0', '0', '0', '0', '0', '0', '1463108311', '1463108311', '1');
INSERT INTO `ot_document` VALUES ('21', '1', '', '新闻中心', '39', '', '0', '0', '2', '2', '0', '0', '6', '1', '0', '0', '0', '0', '0', '0', '1463390354', '1463390354', '1');
INSERT INTO `ot_document` VALUES ('22', '1', '', '企业介绍', '1', '', '0', '0', '2', '2', '0', '0', '7', '1', '0', '0', '0', '0', '0', '0', '1463390760', '1463391346', '1');
INSERT INTO `ot_document` VALUES ('23', '1', '', '产品展示', '46', '', '0', '0', '2', '2', '0', '0', '9', '1', '0', '0', '0', '0', '0', '0', '1463390820', '1463391409', '1');
INSERT INTO `ot_document` VALUES ('24', '1', '', '护肤产品002', '47', '', '0', '0', '2', '2', '0', '0', '10', '1', '0', '0', '0', '0', '0', '0', '1463391532', '1463391532', '1');
INSERT INTO `ot_document` VALUES ('25', '1', '', '护肤产品003', '47', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1463391542', '1463391542', '1');
INSERT INTO `ot_document` VALUES ('26', '1', '', '护肤产品004', '47', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1463391551', '1463391551', '1');
INSERT INTO `ot_document` VALUES ('27', '1', '', '护肤产品005', '47', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1463391567', '1463391567', '1');
INSERT INTO `ot_document` VALUES ('28', '1', '', '护肤产品006', '47', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1463391641', '1463391641', '1');
INSERT INTO `ot_document` VALUES ('29', '1', '', '加盟流程', '54', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1463625014', '1463625014', '1');
INSERT INTO `ot_document` VALUES ('30', '1', '', 'hhhh', '40', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1463629535', '1463629535', '1');

-- ----------------------------
-- Table structure for `ot_document_article`
-- ----------------------------
DROP TABLE IF EXISTS `ot_document_article`;
CREATE TABLE `ot_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of ot_document_article
-- ----------------------------
INSERT INTO `ot_document_article` VALUES ('1', '0', '<h1 style=\"text-align:left;\">\r\n	同讯网络专业提供信息化解决方案，专注于为企业提供计算机软件开发、网站建设、效果分析、移动互联网微信及APP智能系统开发等互联网信息一站式服务的IT公司。核心技术产品为整合“传统PC网络+移动互联网+微信及APP大数据”\r\n</h1>\r\n<p style=\"text-align:left;\">\r\n	<br />\r\n</p>', '', '0');
INSERT INTO `ot_document_article` VALUES ('3', '0', '互联网平台已经成为企业推广的重要平台，适应客户碎片化时间的网络营销不断在逐步发展，正由于互联网发展的<br />', '', '0');
INSERT INTO `ot_document_article` VALUES ('19', '0', '互联网平台已经成为企业推广的重要平台，适应客户碎片化时间的网络营销不断在逐步发展，正由于互联网发展的', '', '0');
INSERT INTO `ot_document_article` VALUES ('4', '0', '行业新闻001', '', '0');
INSERT INTO `ot_document_article` VALUES ('5', '0', '活动专栏001', '', '0');
INSERT INTO `ot_document_article` VALUES ('6', '0', '企业视频001', '', '0');
INSERT INTO `ot_document_article` VALUES ('8', '0', '企业文化001', '', '0');
INSERT INTO `ot_document_article` VALUES ('9', '0', '核心优势001', '', '0');
INSERT INTO `ot_document_article` VALUES ('10', '0', '护肤产品001', '', '0');
INSERT INTO `ot_document_article` VALUES ('11', '0', '<iframe src=\"/ot/Public/static/kindeditor/plugins/baidumap/index.html?center=102.672852%2C25.036748&zoom=17&width=558&height=360&markers=102.672852%2C25.036748&markerStyles=l%2CA\" frameborder=\"0\" style=\"width:560px;height:362px;\">\r\n</iframe>', '', '0');
INSERT INTO `ot_document_article` VALUES ('12', '0', '18888888888', '', '0');
INSERT INTO `ot_document_article` VALUES ('13', '0', '保湿产品', '', '0');
INSERT INTO `ot_document_article` VALUES ('18', '0', '洗浴产品', '', '0');
INSERT INTO `ot_document_article` VALUES ('21', '0', '新闻中心', '', '0');
INSERT INTO `ot_document_article` VALUES ('22', '0', '企业介绍', '', '0');
INSERT INTO `ot_document_article` VALUES ('23', '0', '产品展示', '', '0');
INSERT INTO `ot_document_article` VALUES ('24', '0', '护肤产品002', '', '0');
INSERT INTO `ot_document_article` VALUES ('25', '0', '护肤产品003', '', '0');
INSERT INTO `ot_document_article` VALUES ('26', '0', '护肤产品004', '', '0');
INSERT INTO `ot_document_article` VALUES ('27', '0', '护肤产品005', '', '0');
INSERT INTO `ot_document_article` VALUES ('28', '0', '护肤产品006', '', '0');
INSERT INTO `ot_document_article` VALUES ('29', '0', '第一步：咨询签约（服务部门：加盟中心）1.通过电话、QQ、邮件等方式详细咨询外婆心18小时特色快餐项目的情况，是否适合自己和当地的市场消费；2.填写加盟申请表，详细介绍自己的投资预算，意向投资区域的市场状况等3.到外婆心重庆总部实地考察，了解公司的实力和连锁餐厅的经营状况，免费品尝菜品，确定加盟意向 4.正式签约。第二步：专业培训（服务部门：人力资源部） 1.对加盟商进行专业的选址培训和店址评估；2.对加盟餐厅的核心岗位成员进行专业实战培训，掌握新餐厅筹备、餐厅管理和产品制作技术标准；3.考核通三步：营运支持（服务部门：营运中业选址评估，餐厅装修设计并实施；市场调研，商圈论证，定制开业经营方案；.正式开业；6.后续营运支持。第一步：咨询签约（服务部门：加盟中心）1.通过电话、QQ、邮件等方式详细咨询外婆心18小时特色快餐项目的情况，是否适合自己和当地的市场消费；2.填写加盟申请表，详细介绍自己的投资预算，意向投资区域的市场状况等3.到外婆心重庆总部实地考察，了解公司的实力和连锁餐厅的经营状况，免费品尝菜品，确定加盟意向 4.正式签约。第二步：专业培训（服务部门：人力资源部） 1.对加盟商进行专业的选址培训和店址评估；；.正式开业；6.后续营运支持。', '', '0');
INSERT INTO `ot_document_article` VALUES ('30', '0', 'wfwfwefwefw', '', '0');

-- ----------------------------
-- Table structure for `ot_document_download`
-- ----------------------------
DROP TABLE IF EXISTS `ot_document_download`;
CREATE TABLE `ot_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- ----------------------------
-- Records of ot_document_download
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_file`
-- ----------------------------
DROP TABLE IF EXISTS `ot_file`;
CREATE TABLE `ot_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of ot_file
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_goods`
-- ----------------------------
DROP TABLE IF EXISTS `ot_goods`;
CREATE TABLE `ot_goods` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL COMMENT '商品名称',
  `PNO` varchar(250) NOT NULL COMMENT '零件号',
  `old_PNO` varchar(250) NOT NULL COMMENT '原厂参考零件号',
  `brand_id` int(10) NOT NULL COMMENT '品牌',
  `price` decimal(10,2) NOT NULL COMMENT '含税价格',
  `type_ids` mediumtext NOT NULL COMMENT '适用机型',
  `category_id` int(10) NOT NULL COMMENT '类别',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态,1：正常，0：回收站，默认1',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `PNO` (`PNO`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_goods
-- ----------------------------
INSERT INTO `ot_goods` VALUES ('7', '凯撒1111 油气分离芯（替代件）', '3003363010', '123456', '10', '123.00', ',47,76,', '4', '1', '2015-01-06 23:07:07');
INSERT INTO `ot_goods` VALUES ('8', '英格索兰 全合成酯类润滑油 超冷 Coolant 46 （5加仑）替代件', '3003100320', '250022669', '12', '3755.70', ',78,,79,', '14', '1', '2015-01-06 23:22:21');
INSERT INTO `ot_goods` VALUES ('10', 'ceshi1', '1234', '54595442', '10', '3000.00', ',48,', '9', '1', '2015-01-06 23:55:03');

-- ----------------------------
-- Table structure for `ot_hooks`
-- ----------------------------
DROP TABLE IF EXISTS `ot_hooks`;
CREATE TABLE `ot_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_hooks
-- ----------------------------
INSERT INTO `ot_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '');
INSERT INTO `ot_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop');
INSERT INTO `ot_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment');
INSERT INTO `ot_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,SocialComment');
INSERT INTO `ot_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '');
INSERT INTO `ot_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment');
INSERT INTO `ot_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor');
INSERT INTO `ot_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin');
INSERT INTO `ot_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam');
INSERT INTO `ot_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor');
INSERT INTO `ot_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '');

-- ----------------------------
-- Table structure for `ot_introduce`
-- ----------------------------
DROP TABLE IF EXISTS `ot_introduce`;
CREATE TABLE `ot_introduce` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `re_ip` varchar(255) NOT NULL COMMENT '修改ip',
  `re_admin` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_introduce
-- ----------------------------
INSERT INTO `ot_introduce` VALUES ('1', '企业概况', 's', '192.168.1.155', '1');
INSERT INTO `ot_introduce` VALUES ('2', '企业文化', '', '192.168.1.155', '1');
INSERT INTO `ot_introduce` VALUES ('3', '核心优势', 'data修改 &nbsp;foreach 循环', '192.168.1.155', '1');

-- ----------------------------
-- Table structure for `ot_inv_code`
-- ----------------------------
DROP TABLE IF EXISTS `ot_inv_code`;
CREATE TABLE `ot_inv_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `xcode` varchar(255) NOT NULL COMMENT '内容',
  `agent_grade` tinyint(4) NOT NULL COMMENT '代理级别',
  `create_admin` varchar(255) NOT NULL COMMENT '生成者',
  `create_time` int(11) NOT NULL COMMENT '生成时间',
  `use_time` int(11) NOT NULL COMMENT '使用时间',
  `use_admin` varchar(255) NOT NULL COMMENT '使用者',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '使用状态；0：未使用；1：已使用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`xcode`),
  UNIQUE KEY `email` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of ot_inv_code
-- ----------------------------
INSERT INTO `ot_inv_code` VALUES ('1', 'F206-6BEC-7917-42C1-A28B-A3BD-4789-BEAB', '0', '1', '1462327236', '1462784722', '29', '1');
INSERT INTO `ot_inv_code` VALUES ('2', 'E171-1161-FFD6-4C05-A492-BE56-6892-675D', '0', '1', '1462327239', '1463045112', '32', '1');
INSERT INTO `ot_inv_code` VALUES ('3', '3CEF-F27C-AF15-4D6A-AB06-14F1-7203-69E9', '0', '1', '1462327240', '1462773691', '26', '1');
INSERT INTO `ot_inv_code` VALUES ('4', 'B2C8-660E-0F47-4A1B-9D6F-DA05-E2E2-4F51', '0', '2', '1462327254', '1463056428', '33', '1');
INSERT INTO `ot_inv_code` VALUES ('5', 'F3A6-3038-1970-4359-B0E9-6E54-2A92-10AC', '0', '2', '1462327256', '0', '', '0');
INSERT INTO `ot_inv_code` VALUES ('6', '788C-1138-B765-45DC-8C62-E7AC-F367-F031', '0', '2', '1462327258', '0', '', '0');
INSERT INTO `ot_inv_code` VALUES ('7', '7554-C825-15D6-49FE-9787-0ED3-267B-43DD', '0', '17', '1462417306', '1462421006', '22', '1');
INSERT INTO `ot_inv_code` VALUES ('8', '81B7-D42B-4C4D-41EB-949A-26C6-9161-973B', '0', '17', '1462417309', '1462417373', '19', '1');
INSERT INTO `ot_inv_code` VALUES ('9', '3177-10F2-1157-4987-BCB7-A8CE-E0CD-D779', '0', '17', '1462420969', '1462773245', '24', '1');
INSERT INTO `ot_inv_code` VALUES ('10', 'AEC3-9457-4AB0-4FD6-986B-6E49-054A-E548', '0', '17', '1462440201', '0', '', '0');
INSERT INTO `ot_inv_code` VALUES ('11', '0C41-CB32-0D3E-4129-A8B7-2B7C-7F70-8C4A', '0', '1', '1462624638', '1463635685', '45', '1');
INSERT INTO `ot_inv_code` VALUES ('12', '76CD-463F-5780-93FE-4BA6', '0', '1', '1462785305', '1462785319', '30', '1');
INSERT INTO `ot_inv_code` VALUES ('13', '7420-490E-6216-AA12-2D44', '0', '1', '1462785432', '1462785445', '31', '1');
INSERT INTO `ot_inv_code` VALUES ('14', '429E-4C7A-B3B1-BBE4-FC8C', '0', '31', '1462785949', '1463635095', '44', '1');
INSERT INTO `ot_inv_code` VALUES ('15', '1BE1-4126-7A5C-A8DF-1069', '0', '32', '1463045347', '0', '', '0');
INSERT INTO `ot_inv_code` VALUES ('16', '62CB-48C3-C785-A6FA-5460', '0', '31', '1463056508', '1463361706', '34', '1');
INSERT INTO `ot_inv_code` VALUES ('17', 'F7B3-48F9-4D08-B004-6568', '0', '1', '1463124905', '0', '', '0');
INSERT INTO `ot_inv_code` VALUES ('18', '1EA4-4B91-043D-8F2F-E53F', '0', '1', '1463124907', '0', '', '0');
INSERT INTO `ot_inv_code` VALUES ('19', '9278-410F-6BC3-8312-34D4', '0', '1', '1463124909', '0', '', '0');
INSERT INTO `ot_inv_code` VALUES ('20', 'B8D3-427E-66A4-89CF-8C2C', '0', '1', '1463124910', '0', '', '0');
INSERT INTO `ot_inv_code` VALUES ('21', 'B5E8-4CDB-E620-BADD-DC4D', '0', '1', '1463124912', '1463645993', '46', '1');
INSERT INTO `ot_inv_code` VALUES ('22', '4CFA5B02A403', '0', '1', '1469174270', '0', '', '0');

-- ----------------------------
-- Table structure for `ot_logo`
-- ----------------------------
DROP TABLE IF EXISTS `ot_logo`;
CREATE TABLE `ot_logo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pic_id` int(11) NOT NULL COMMENT '地址',
  `title` varchar(500) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ot_logo
-- ----------------------------
INSERT INTO `ot_logo` VALUES ('1', '12', 'logo', '1463588708');

-- ----------------------------
-- Table structure for `ot_member`
-- ----------------------------
DROP TABLE IF EXISTS `ot_member`;
CREATE TABLE `ot_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of ot_member
-- ----------------------------
INSERT INTO `ot_member` VALUES ('1', 'admin', '0', '0000-00-00', '', '80', '44', '0', '1462324945', '0', '1469175740', '1');
INSERT INTO `ot_member` VALUES ('2', 'pengpu', '0', '0000-00-00', '', '10', '7', '0', '1462327163', '0', '1462778254', '1');
INSERT INTO `ot_member` VALUES ('12', 'pp1882', '0', '0000-00-00', '', '0', '0', '0', '1462375898', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('11', 'pp1881', '0', '0000-00-00', '', '0', '0', '0', '1462375723', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('13', 'pp1883', '0', '0000-00-00', '', '0', '0', '0', '1462375928', '0', '1462375928', '1');
INSERT INTO `ot_member` VALUES ('14', 'pp1884', '0', '0000-00-00', '', '0', '0', '0', '1462411829', '0', '1462411829', '1');
INSERT INTO `ot_member` VALUES ('15', 'pp1885', '0', '0000-00-00', '', '10', '2', '0', '1462412273', '0', '1462420225', '1');
INSERT INTO `ot_member` VALUES ('16', 'pp1886', '0', '0000-00-00', '', '10', '2', '0', '1462412378', '0', '1462419531', '1');
INSERT INTO `ot_member` VALUES ('17', 'pp1892', '0', '0000-00-00', '', '50', '32', '0', '1462412440', '0', '1463619946', '1');
INSERT INTO `ot_member` VALUES ('18', 'pp1888', '0', '0000-00-00', '', '10', '1', '0', '1462413125', '0', '1462413984', '1');
INSERT INTO `ot_member` VALUES ('19', 'pp8887', '0', '0000-00-00', '', '10', '2', '0', '1462417372', '0', '1462458635', '1');
INSERT INTO `ot_member` VALUES ('20', 'pp1889', '0', '0000-00-00', '', '10', '3', '0', '1462420650', '0', '1463624277', '1');
INSERT INTO `ot_member` VALUES ('21', 'pp1890', '0', '0000-00-00', '', '0', '0', '0', '1462420915', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('22', 'pp1891', '0', '0000-00-00', '', '10', '1', '0', '1462421006', '0', '1462421050', '1');
INSERT INTO `ot_member` VALUES ('23', 'pp1893', '0', '0000-00-00', '', '0', '0', '0', '1462773146', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('24', 'pp1894', '0', '0000-00-00', '', '0', '0', '0', '1462773245', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('26', 'pp1896', '0', '0000-00-00', '', '10', '1', '0', '1462773691', '0', '1462773699', '1');
INSERT INTO `ot_member` VALUES ('27', 'pp1897', '0', '0000-00-00', '', '0', '0', '0', '1462783826', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('28', 'pp1898', '0', '0000-00-00', '', '0', '0', '0', '1462784238', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('29', 'pp1899', '0', '0000-00-00', '', '0', '0', '0', '1462784722', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('30', 'pp1990', '0', '0000-00-00', '', '20', '2', '0', '1462785319', '0', '1463475799', '1');
INSERT INTO `ot_member` VALUES ('31', 'pp1991', '0', '0000-00-00', '', '50', '17', '0', '1462785445', '0', '1463535862', '1');
INSERT INTO `ot_member` VALUES ('32', 'mobile', '0', '0000-00-00', '', '10', '3', '0', '1463045112', '0', '1463045398', '1');
INSERT INTO `ot_member` VALUES ('33', 'pp1900', '0', '0000-00-00', '', '0', '0', '0', '1463056427', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('34', 'pp1992', '0', '0000-00-00', '', '10', '1', '0', '1463361705', '0', '1463361717', '1');
INSERT INTO `ot_member` VALUES ('35', 'pp1993', '0', '0000-00-00', '', '10', '2', '0', '1463478043', '0', '1463478312', '1');
INSERT INTO `ot_member` VALUES ('36', 'pp1994', '0', '0000-00-00', '', '10', '3', '0', '1463538615', '0', '1463541856', '1');
INSERT INTO `ot_member` VALUES ('37', 'pp1995', '0', '0000-00-00', '', '10', '1', '0', '1463538898', '0', '1463551629', '1');
INSERT INTO `ot_member` VALUES ('38', 'pp1996', '0', '0000-00-00', '', '10', '1', '0', '1463551830', '0', '1463551871', '1');
INSERT INTO `ot_member` VALUES ('39', 'pp1997', '0', '0000-00-00', '', '10', '2', '0', '1463551967', '0', '1463552130', '1');
INSERT INTO `ot_member` VALUES ('40', 'pp1998', '0', '0000-00-00', '', '10', '1', '0', '1463552170', '0', '1463552204', '1');
INSERT INTO `ot_member` VALUES ('41', 'pp1999', '0', '0000-00-00', '', '20', '12', '0', '1463552264', '0', '1469175700', '1');
INSERT INTO `ot_member` VALUES ('42', 'pp2000', '0', '0000-00-00', '', '10', '2', '0', '1463553821', '0', '1463553880', '1');
INSERT INTO `ot_member` VALUES ('43', 'pp2001', '0', '0000-00-00', '', '10', '2', '0', '1463553938', '0', '1463554022', '1');
INSERT INTO `ot_member` VALUES ('44', 'pp2002', '0', '0000-00-00', '', '0', '0', '0', '1463635095', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('45', 'pp2003', '0', '0000-00-00', '', '0', '0', '0', '1463635685', '0', '0', '1');
INSERT INTO `ot_member` VALUES ('46', 'pp2005', '0', '0000-00-00', '', '10', '1', '0', '1463645993', '0', '1463646000', '1');

-- ----------------------------
-- Table structure for `ot_member_bak`
-- ----------------------------
DROP TABLE IF EXISTS `ot_member_bak`;
CREATE TABLE `ot_member_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `v_code` varchar(255) NOT NULL COMMENT '密文',
  `begin_time` int(11) NOT NULL COMMENT '生效时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0：未使用；1：已使用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_member_bak
-- ----------------------------
INSERT INTO `ot_member_bak` VALUES ('1', '0', 'pp1887', '', '1463565766', '0');
INSERT INTO `ot_member_bak` VALUES ('2', '0', 'pp8887', '', '1463566114', '0');
INSERT INTO `ot_member_bak` VALUES ('3', '0', 'pp1887', '', '1463566222', '0');
INSERT INTO `ot_member_bak` VALUES ('4', '0', 'pp1887', '', '1463566265', '0');
INSERT INTO `ot_member_bak` VALUES ('5', '0', 'pp1887', '', '1463566377', '0');
INSERT INTO `ot_member_bak` VALUES ('6', '0', 'pp1887', '', '1463566429', '0');
INSERT INTO `ot_member_bak` VALUES ('7', '0', 'pp1887', '', '1463566477', '0');
INSERT INTO `ot_member_bak` VALUES ('8', '0', 'pp1887', '', '1463566493', '0');
INSERT INTO `ot_member_bak` VALUES ('9', '0', 'pp1887', '', '1463566553', '0');
INSERT INTO `ot_member_bak` VALUES ('10', '0', 'pp1887', '', '1463566666', '0');
INSERT INTO `ot_member_bak` VALUES ('11', '0', 'pp1887', '', '1463566713', '0');
INSERT INTO `ot_member_bak` VALUES ('12', '0', 'pp1887', '', '1463566951', '0');
INSERT INTO `ot_member_bak` VALUES ('13', '0', 'pp1887', '', '1463566976', '0');
INSERT INTO `ot_member_bak` VALUES ('14', '0', 'pp1887', '', '1463567047', '0');
INSERT INTO `ot_member_bak` VALUES ('15', '0', 'pp1887', '', '1463567171', '0');
INSERT INTO `ot_member_bak` VALUES ('16', '0', 'pp1887', '', '1463567435', '0');
INSERT INTO `ot_member_bak` VALUES ('17', '0', 'pp1887', '', '1463567540', '0');
INSERT INTO `ot_member_bak` VALUES ('18', '0', 'pp1887', '', '1463567623', '0');
INSERT INTO `ot_member_bak` VALUES ('19', '0', 'pp1887', '', '1463567779', '0');
INSERT INTO `ot_member_bak` VALUES ('20', '0', 'pp1887', '', '1463567935', '0');
INSERT INTO `ot_member_bak` VALUES ('21', '0', 'pp1887', '', '1463567989', '0');
INSERT INTO `ot_member_bak` VALUES ('22', '0', 'pp1887', '', '1463568090', '0');
INSERT INTO `ot_member_bak` VALUES ('23', '0', 'pp1887', '', '1463568127', '0');
INSERT INTO `ot_member_bak` VALUES ('24', '0', 'pp1887', '', '1463568166', '0');
INSERT INTO `ot_member_bak` VALUES ('25', '0', 'pp1888', '', '1463620408', '0');
INSERT INTO `ot_member_bak` VALUES ('26', '0', 'pp1889', '', '1463620466', '0');
INSERT INTO `ot_member_bak` VALUES ('27', '0', 'pp1889', '', '1463620753', '0');
INSERT INTO `ot_member_bak` VALUES ('28', '0', 'pp1889', 'c2f7781a5893ea6b657ca37eba8ed134', '1463621218', '0');
INSERT INTO `ot_member_bak` VALUES ('29', '0', 'pp1889', '1c578a0bc1070848cc70acfb5023e1bc', '1463621446', '0');
INSERT INTO `ot_member_bak` VALUES ('30', '20', 'pp1889', '0bf42d09af3c1ad3d156d8e873138f4a', '1463622898', '0');
INSERT INTO `ot_member_bak` VALUES ('31', '20', 'pp1889', '7471e304b168d0d6d60ea47c0760b791', '1463623240', '0');
INSERT INTO `ot_member_bak` VALUES ('32', '20', 'pp1889', '7637f4ed70e0554171357fe38c7306cb', '1463624210', '1');
INSERT INTO `ot_member_bak` VALUES ('33', '17', 'pp1887', 'a0a4a29d790232cde3f2df8465e37cc7', '1463634053', '0');
INSERT INTO `ot_member_bak` VALUES ('34', '41', 'pp1999', '696385efb09ed2b09705d53d3b5fc0a3', '1463636324', '1');
INSERT INTO `ot_member_bak` VALUES ('35', '41', 'pp1999', '00bf74ae2ae4763ae5c51dedc31cf84b', '1463710600', '1');
INSERT INTO `ot_member_bak` VALUES ('36', '41', 'pp1999', '526158af2c9ec4a56fe7a2ad7c4e874f', '1463710728', '1');
INSERT INTO `ot_member_bak` VALUES ('37', '41', 'pp1999', '9cbe268b0cf98348a6873f59f19001a3', '1463711179', '0');
INSERT INTO `ot_member_bak` VALUES ('38', '41', 'pp1999', '57771291674d73544f945c4fd64298db', '1463711826', '0');
INSERT INTO `ot_member_bak` VALUES ('39', '41', 'pp1999', '516205a5c666166046cd18b318764c94', '1463713446', '0');
INSERT INTO `ot_member_bak` VALUES ('40', '41', 'pp1999', '7d297601aab6421505758577e5cfba35', '1463714289', '0');
INSERT INTO `ot_member_bak` VALUES ('41', '41', 'pp1999', '0d8486e894b57b99c03988252a516448', '1463714356', '0');
INSERT INTO `ot_member_bak` VALUES ('42', '41', 'pp1999', '6e7063395101aaa8c59e663bf0d37adf', '1463714798', '0');
INSERT INTO `ot_member_bak` VALUES ('43', '41', 'pp1999', '2daff1a73756dfdec8eb35494f0f7643', '1463721590', '0');
INSERT INTO `ot_member_bak` VALUES ('44', '41', 'pp1999', '05dca2f654e6c2a4f1309f2436f469b3', '1463721627', '0');
INSERT INTO `ot_member_bak` VALUES ('45', '41', 'pp1999', '500fad131c34b9cf6ddee31922e18d58', '1463721721', '0');
INSERT INTO `ot_member_bak` VALUES ('46', '41', 'pp1999', '05d3c6b91e605fa05a77413eeaea476e', '1463721733', '0');
INSERT INTO `ot_member_bak` VALUES ('47', '41', 'pp1999', 'ef82bc75f6031cb2e02eda02e7825846', '1463730744', '0');
INSERT INTO `ot_member_bak` VALUES ('48', '41', 'pp1999', '55fb5e674fa40fc84c88d10f2ae1c834', '1463730755', '0');
INSERT INTO `ot_member_bak` VALUES ('49', '41', 'pp1999', '167559bdc1fdce57919d1df2fc8dfd73', '1463730760', '0');
INSERT INTO `ot_member_bak` VALUES ('50', '41', 'pp1999', '5650f6769a3ab3d57ab590f0804e6d2c', '1463730779', '0');
INSERT INTO `ot_member_bak` VALUES ('51', '41', 'pp1999', 'a8664cf7dcdefc5b7b14e3d8a04c909b', '1463730811', '0');
INSERT INTO `ot_member_bak` VALUES ('52', '41', 'pp1999', 'e2c7bd7a247417cd8e916ed4d6bd397d', '1463730878', '0');

-- ----------------------------
-- Table structure for `ot_menu`
-- ----------------------------
DROP TABLE IF EXISTS `ot_menu`;
CREATE TABLE `ot_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_menu
-- ----------------------------
INSERT INTO `ot_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('2', '内容', '0', '2', 'Article/mydocument', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('3', '文档列表', '2', '0', 'article/index', '1', '', '内容', '0');
INSERT INTO `ot_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('13', '回收站', '2', '0', 'article/recycle', '1', '', '内容', '0');
INSERT INTO `ot_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('16', '用户', '0', '3', 'User/index', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('17', '用户信息', '16', '0', 'User/index', '0', '', '用户管理', '0');
INSERT INTO `ot_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0');
INSERT INTO `ot_menu` VALUES ('19', '用户行为', '16', '0', 'User/action', '0', '', '行为管理', '0');
INSERT INTO `ot_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0');
INSERT INTO `ot_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0');
INSERT INTO `ot_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0');
INSERT INTO `ot_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0');
INSERT INTO `ot_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0');
INSERT INTO `ot_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0');
INSERT INTO `ot_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0');
INSERT INTO `ot_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0');
INSERT INTO `ot_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0');
INSERT INTO `ot_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0');
INSERT INTO `ot_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0');
INSERT INTO `ot_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0');
INSERT INTO `ot_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0');
INSERT INTO `ot_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0');
INSERT INTO `ot_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0');
INSERT INTO `ot_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0');
INSERT INTO `ot_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0');
INSERT INTO `ot_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0');
INSERT INTO `ot_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `ot_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0');
INSERT INTO `ot_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `ot_menu` VALUES ('43', '扩展', '0', '4', 'Addons/index', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('44', '插件管理', '43', '1', 'Addons/index', '0', '', '扩展', '0');
INSERT INTO `ot_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0');
INSERT INTO `ot_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0');
INSERT INTO `ot_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0');
INSERT INTO `ot_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0');
INSERT INTO `ot_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0');
INSERT INTO `ot_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0');
INSERT INTO `ot_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0');
INSERT INTO `ot_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0');
INSERT INTO `ot_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0');
INSERT INTO `ot_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0');
INSERT INTO `ot_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0');
INSERT INTO `ot_menu` VALUES ('57', '钩子管理', '43', '2', 'Addons/hooks', '0', '', '扩展', '0');
INSERT INTO `ot_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '0');
INSERT INTO `ot_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0');
INSERT INTO `ot_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('68', '系统', '0', '6', 'Config/group', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0');
INSERT INTO `ot_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0');
INSERT INTO `ot_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0');
INSERT INTO `ot_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0');
INSERT INTO `ot_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0');
INSERT INTO `ot_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0');
INSERT INTO `ot_menu` VALUES ('75', '菜单管理', '68', '0', 'Menu/index', '0', '', '菜单管理', '0');
INSERT INTO `ot_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0');
INSERT INTO `ot_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('80', '分类管理', '68', '2', 'Category/index', '0', '', '系统设置', '0');
INSERT INTO `ot_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0');
INSERT INTO `ot_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0');
INSERT INTO `ot_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0');
INSERT INTO `ot_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0');
INSERT INTO `ot_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0');
INSERT INTO `ot_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0');
INSERT INTO `ot_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0');
INSERT INTO `ot_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0');
INSERT INTO `ot_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0');
INSERT INTO `ot_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0');
INSERT INTO `ot_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0');
INSERT INTO `ot_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0');
INSERT INTO `ot_menu` VALUES ('93', '其他', '0', '5', 'other', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0');
INSERT INTO `ot_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('104', '下载管理', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('105', '配置管理', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('106', '行为日志', '16', '0', 'Action/actionlog', '0', '', '行为管理', '0');
INSERT INTO `ot_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('122', '代理商', '0', '7', 'Agents/a_list', '0', '', '', '0');
INSERT INTO `ot_menu` VALUES ('123', '代理商列表', '122', '1', 'Agents/a_list', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('124', '邀请码列表', '122', '5', 'InvCode/i_list', '0', '', '邀请码管理', '0');
INSERT INTO `ot_menu` VALUES ('125', '编辑代理商', '123', '8', 'Agents/edit', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('126', '产品列表', '122', '4', 'Products/p_list', '0', '产品管理', '产品管理', '0');
INSERT INTO `ot_menu` VALUES ('127', '添加邀请码', '124', '4', 'InvCode/add', '1', '', '邀请码管理', '0');
INSERT INTO `ot_menu` VALUES ('128', '添加代理商', '123', '5', 'Agents/add', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('129', '添加产品', '126', '0', 'Products/add', '0', '', '产品管理', '0');
INSERT INTO `ot_menu` VALUES ('130', '产品添加', '129', '0', 'Products/add', '0', '', '产品管理', '0');
INSERT INTO `ot_menu` VALUES ('131', '新闻列表', '122', '3', 'News/n_list', '1', '新闻发布系统', '新闻管理', '0');
INSERT INTO `ot_menu` VALUES ('132', '添加新闻', '131', '0', 'News/add', '0', '', '新闻管理', '0');
INSERT INTO `ot_menu` VALUES ('133', '证书列表', '122', '6', 'Certs/c_list', '0', '', '证书管理', '0');
INSERT INTO `ot_menu` VALUES ('134', '添加证书', '133', '6', 'Certs/add', '1', '', '证书管理', '0');
INSERT INTO `ot_menu` VALUES ('135', '违规举报', '122', '7', 'Reports/r_list', '0', '', '违规举报', '0');
INSERT INTO `ot_menu` VALUES ('136', '代理商等级', '122', '2', 'AgentsGrade/g_list', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('137', '添加代理商等级', '136', '0', 'AgentsGrade/add', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('138', '编辑代理商等级', '136', '0', 'AgentsGrade/edit', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('139', '编辑证书', '133', '0', 'Certs/edit', '0', '', '证书管理', '0');
INSERT INTO `ot_menu` VALUES ('140', '编辑邀请码', '124', '0', 'InvCode/edit', '0', '', '邀请码管理', '0');
INSERT INTO `ot_menu` VALUES ('141', '编辑产品', '126', '0', 'Products/edit', '0', '', '产品管理', '0');
INSERT INTO `ot_menu` VALUES ('142', '编辑新闻', '131', '0', 'News/edit', '0', '', '新闻管理', '0');
INSERT INTO `ot_menu` VALUES ('143', '添加举报', '135', '0', 'Reports/add', '0', '', '举报管理', '0');
INSERT INTO `ot_menu` VALUES ('144', '编辑举报', '135', '0', 'Reports/edit', '0', '', '举报管理', '0');
INSERT INTO `ot_menu` VALUES ('145', '代理商审核', '123', '0', 'Agents/review', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('146', '代理商查看', '123', '0', 'Agents/view', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('147', '违规审核', '135', '0', 'Reports/review', '0', '', '举报管理', '0');
INSERT INTO `ot_menu` VALUES ('148', '完善资料', '16', '0', 'User/updateProfile', '1', '', '', '0');
INSERT INTO `ot_menu` VALUES ('149', '查看证书', '133', '0', 'Certs/view', '0', '', '证书管理', '0');
INSERT INTO `ot_menu` VALUES ('150', '前台首页', '0', '8', 'Home/Index/index', '0', '前台首页', '', '0');
INSERT INTO `ot_menu` VALUES ('151', '批量生成产品', '126', '0', 'Products/auto_create', '0', '', '产品管理', '0');
INSERT INTO `ot_menu` VALUES ('152', '查看举报', '135', '0', 'Reports/view', '0', '', '举报管理', '0');
INSERT INTO `ot_menu` VALUES ('153', '产品导入', '126', '0', 'Products/pro_import', '0', '', '产品管理', '0');
INSERT INTO `ot_menu` VALUES ('154', '代理商列表（树形）', '123', '0', 'Agents/index_tree', '0', '', '代理商管理', '0');
INSERT INTO `ot_menu` VALUES ('155', '轮播图片', '122', '0', 'Slider/index', '0', '', '前台图片', '0');
INSERT INTO `ot_menu` VALUES ('156', 'LOGO', '122', '0', 'Logo/index', '0', '', '前台图片', '0');
INSERT INTO `ot_menu` VALUES ('157', '轮播图编辑', '155', '0', 'Slider/add', '0', '', '', '0');

-- ----------------------------
-- Table structure for `ot_model`
-- ----------------------------
DROP TABLE IF EXISTS `ot_model`;
CREATE TABLE `ot_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of ot_model
-- ----------------------------
INSERT INTO `ot_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:类型\r\nlevel:优先级\r\nupdate_time|time_format:最后更新\r\nstatus_text:状态\r\nview:浏览\r\nid:操作:[EDIT]&cate_id=[category_id]|编辑,article/setstatus?status=-1&ids=[id]|删除', '0', '', '', '1383891233', '1384507827', '1', 'MyISAM');
INSERT INTO `ot_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:内容', '0', '', '', '1383891243', '1387260622', '1', 'MyISAM');
INSERT INTO `ot_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');

-- ----------------------------
-- Table structure for `ot_news`
-- ----------------------------
DROP TABLE IF EXISTS `ot_news`;
CREATE TABLE `ot_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻id',
  `title` varchar(255) NOT NULL COMMENT '新闻标题',
  `contents` text NOT NULL COMMENT '新闻内容',
  `n_cate` int(11) NOT NULL COMMENT '二级栏目',
  `rel_admin` int(11) NOT NULL COMMENT '发布人',
  `rel_time` int(11) NOT NULL COMMENT '发布时间',
  `rel_ip` varchar(255) NOT NULL COMMENT '发布ip',
  `comments` int(11) NOT NULL COMMENT '评论数量',
  `views` int(11) NOT NULL COMMENT '浏览数量',
  `is_review` tinyint(4) NOT NULL COMMENT '是否审核',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_news
-- ----------------------------
INSERT INTO `ot_news` VALUES ('9', '新闻发布测试', '新闻发布测试新闻发布测试新闻发布测试新闻发布测试新闻发布测试新闻发布测试新闻发布测试', '0', '1', '1462338584', '192.168.1.155', '0', '0', '0');
INSERT INTO `ot_news` VALUES ('10', '新闻修改测试', '修改测试sss', '0', '1', '1462338603', '192.168.1.155', '0', '0', '0');
INSERT INTO `ot_news` VALUES ('22', 'sdfsdf', '乒乒乓乓天下无双', '0', '1', '1462352519', '192.168.1.155', '0', '0', '0');
INSERT INTO `ot_news` VALUES ('23', 'ooooo', 'poopoo', '0', '1', '1462526808', '192.168.1.155', '0', '0', '0');
INSERT INTO `ot_news` VALUES ('24', '地地道道', '<div style=\"text-align:left;\">\r\n	<span style=\"line-height:1.5;\">地地道道</span>\r\n</div>', '0', '1', '1462952838', '192.168.1.153', '0', '0', '0');

-- ----------------------------
-- Table structure for `ot_picture`
-- ----------------------------
DROP TABLE IF EXISTS `ot_picture`;
CREATE TABLE `ot_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_picture
-- ----------------------------
INSERT INTO `ot_picture` VALUES ('1', '/Uploads/Picture/2016-04-27/5720169daed55.jpg', '', '301456e2d6b046781f8d680994e921d4', '07c7dbab170accf716d487811b55125bd273f37a', '1', '1461720733');
INSERT INTO `ot_picture` VALUES ('2', '/Uploads/Picture/2016-05-13/573542d4885e0.png', '', '94c172bd621533f4e69cf964ade52a1f', '1e644a46c4c1cbbba9344f5e66e2b31b55cf12fc', '1', '1463108308');
INSERT INTO `ot_picture` VALUES ('3', '/Uploads/Picture/2016-05-13/5735433cb3214.png', '', '50b7a40f4d97cbfe3cb89297b652b85d', 'e0dfde46c35bbb6e51455ad6fb611a7026aaf5fb', '1', '1463108412');
INSERT INTO `ot_picture` VALUES ('4', '/Uploads/Picture/2016-05-13/5735435924d2a.png', '', 'c0bde9353e53692fb561978c8c427e53', 'cfc7443a3aa0683fdadd3405748a67693ee9feed', '1', '1463108441');
INSERT INTO `ot_picture` VALUES ('5', '/Uploads/Picture/2016-05-13/57354457cf8c9.png', '', '1c3c7a0db2211555635636181b71b6d4', '6eede3e70ef615a877e5962a1edec69e3ddbc901', '1', '1463108695');
INSERT INTO `ot_picture` VALUES ('6', '/Uploads/Picture/2016-05-16/573990828478c.png', '', 'ceedb30d53508d1bc04cfebc34921ec7', 'b9ff60ec2c803dc3f2f1ead12673266e3b28dae4', '1', '1463390338');
INSERT INTO `ot_picture` VALUES ('7', '/Uploads/Picture/2016-05-16/57399470a415b.png', '', '7263a3526621f651adba62eb209d2c54', '0788f30c7a151e79c3ca5e824f16f16006cb5bb9', '1', '1463391344');
INSERT INTO `ot_picture` VALUES ('8', '/Uploads/Picture/2016-05-16/5739949151a2b.jpg', '', '0081a4b189b2e5e4485061ae1f6a4711', '9c738114868f5cdb84e38435a112967be7dd3850', '1', '1463391377');
INSERT INTO `ot_picture` VALUES ('9', '/Uploads/Picture/2016-05-16/573994af8fe4f.png', '', 'eaec0e465c375ecda7fb7186d5855c5e', 'b3f7f80ccb450b0f0d32664cf7b35412fbf83b69', '1', '1463391407');
INSERT INTO `ot_picture` VALUES ('10', '/Uploads/Picture/2016-05-16/5739952aa405f.png', '', 'cdf6f72c7c23bc027e5d524f1613c4de', '1bdeea7ed17b73660106cccb039a4b1df846296b', '1', '1463391530');
INSERT INTO `ot_picture` VALUES ('13', '/Uploads/Picture/2016-05-19/573d581d227fc.png', '', '8204981874bb5d981f31d25fb39fc329', '1413a6f23891d3c41870db8b3df5e4783bd7ca35', '1', '1463638045');
INSERT INTO `ot_picture` VALUES ('12', '/Uploads/Picture/2016-05-19/573d580417c0e.png', '', 'efb1f73549ac48bfdb718b7381f7eb4d', 'd2d43b8bce5617d75b3e400dba844704e04744bc', '1', '1463638020');
INSERT INTO `ot_picture` VALUES ('14', '/Uploads/Picture/2016-05-19/573d59498d93d.png', '', 'e6be0a47893e85748a3d9c39746c3a48', 'a633cf6e7148f5170b33cb65c4c1c9996c716f25', '1', '1463638345');
INSERT INTO `ot_picture` VALUES ('15', '/Uploads/Picture/2016-05-19/573d59849350b.png', '', 'dfef3e4d242e716198aab8306f2f2520', '7a7164a3e3a5e16df9f8945431bd7aed7c077767', '1', '1463638404');
INSERT INTO `ot_picture` VALUES ('16', '/Uploads/Picture/2016-05-19/573d59a4c1a5f.png', '', 'ed79a479f9068c8b07ccaa8b6769a07b', '1fc2a08be35f8195fb1b84c5578b635e76ce32fa', '1', '1463638436');
INSERT INTO `ot_picture` VALUES ('17', '/Uploads/Picture/2016-05-19/573d59efb3978.jpg', '', 'f8aeb3c5e3fad6d22306741522b10b4f', '99f08057892c9ae95a013996b7b1f39fb0cde024', '1', '1463638511');
INSERT INTO `ot_picture` VALUES ('18', '/Uploads/Picture/2016-07-18/578c55a1285b3.png', '', 'fe37d2dcb3a6bce4884bece60d389265', '5a4843283aab0a0b231cb15b3bb3666bad1e6d73', '1', '1468814753');
INSERT INTO `ot_picture` VALUES ('19', '/Uploads/Picture/2016-07-18/578c55b55ea53.jpg', '', '36ea7e35eb3c779dbd3dd176f7d0e66f', 'e831ef7a48c053de00637c4d1e666c1ec0772050', '1', '1468814773');
INSERT INTO `ot_picture` VALUES ('20', '/Uploads/Picture/2016-07-22/5791d7d5e10ad.jpg', '', 'c4109b4bf42d6f81a5aad21bff20745a', 'ee3fd57bf153c7b878a6cf2a13129726e5afa335', '1', '1469175765');

-- ----------------------------
-- Table structure for `ot_products`
-- ----------------------------
DROP TABLE IF EXISTS `ot_products`;
CREATE TABLE `ot_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品id',
  `pro_name` varchar(255) NOT NULL COMMENT '产品名称',
  `pro_content` text NOT NULL COMMENT '产品介绍',
  `pro_no` varchar(255) NOT NULL COMMENT '产品编号',
  `pro_brand` varchar(255) NOT NULL COMMENT '品牌',
  `create_admin` varchar(255) NOT NULL COMMENT '添加人',
  `create_time` int(11) NOT NULL COMMENT '添加时间',
  `comments` int(11) NOT NULL COMMENT '评论数量',
  `query_logs` int(11) NOT NULL COMMENT '查询次数',
  `is_review` tinyint(4) NOT NULL COMMENT '是否审核',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_products
-- ----------------------------
INSERT INTO `ot_products` VALUES ('1', '面膜1', '产地：中国\n生产企业：XXX公司', '9564245328798200', '美即', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('2', '面膜2', '产地：中国\n生产企业：XXX公司', '3215569845612598', '雅诗兰黛', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('3', '面膜3', '产地：中国\n生产企业：XXX公司', '4569123598543201', '美即', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('4', '面膜4', '产地：中国\n生产企业：XXX公司', '4598452103269862', '雅诗兰黛', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('5', '面膜5', '产地：中国\n生产企业：XXX公司', '1230781262541987', '美即', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('6', '面膜6', '产地：中国\n生产企业：XXX公司', '3289214769851022', '雅诗兰黛', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('7', '面膜7', '产地：中国\n生产企业：XXX公司', '6984562048793580', '美即', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('8', '面膜8', '产地：中国\n生产企业：XXX公司', '1203452314601125', '雅诗兰黛', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('9', '面膜9', '产地：中国\n生产企业：XXX公司', '9850154122331654', '美即', '1', '1463468777', '0', '0', '0');
INSERT INTO `ot_products` VALUES ('10', '面膜10', '产地：中国\n生产企业：XXX公司', '1126552478416210', '雅诗兰黛', '1', '1463468777', '0', '0', '0');

-- ----------------------------
-- Table structure for `ot_reports`
-- ----------------------------
DROP TABLE IF EXISTS `ot_reports`;
CREATE TABLE `ot_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '举报人id',
  `agent_name` varchar(255) NOT NULL COMMENT '被举报的代理商用户名',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `contents` text NOT NULL COMMENT '举报内容',
  `rep_admin` int(11) NOT NULL COMMENT '举报人',
  `rep_ip` varchar(64) NOT NULL COMMENT '举报人ip',
  `create_time` int(11) NOT NULL COMMENT '举报时间',
  `is_review` tinyint(4) NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_reports
-- ----------------------------
INSERT INTO `ot_reports` VALUES ('1', '3', '违规造假', '违规造价内容', '13', '192.168.1.110', '1444444', '1');
INSERT INTO `ot_reports` VALUES ('18', 'pp1887', '我要举报', '发反反复复', '17', '192.168.1.164', '1462765118', '1');
INSERT INTO `ot_reports` VALUES ('19', 'pp1889', '俺要举报0001', '诈骗1111<br />', '31', '192.168.1.164', '1462787719', '0');
INSERT INTO `ot_reports` VALUES ('10', 'pp1887', '诈骗', '<span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span><span>这是一个真实的故事&nbsp;</span>', '16', '192.168.1.155', '1462497592', '1');
INSERT INTO `ot_reports` VALUES ('11', 'pp1889', '骗子', '111111', '1', '192.168.1.164', '1462762817', '0');
INSERT INTO `ot_reports` VALUES ('13', '68678', '68676', '7878678', '1', '192.168.1.164', '1462763739', '1');
INSERT INTO `ot_reports` VALUES ('14', '777', '888', '999', '1', '192.168.1.164', '1462763760', '1');
INSERT INTO `ot_reports` VALUES ('15', '898', '000', '和融合和任何', '1', '192.168.1.164', '1462763771', '0');
INSERT INTO `ot_reports` VALUES ('16', '12222', '11111', '你那你你你你你你你你你你', '1', '192.168.1.164', '1462763783', '0');
INSERT INTO `ot_reports` VALUES ('17', '34534', '666', '啦啦啦啦啦啦啦', '1', '192.168.1.164', '1462763793', '1');
INSERT INTO `ot_reports` VALUES ('20', 'admin111', '举报自己', '举报自己举报自己举报自己举报自己', '1', '192.168.1.163', '1463124897', '0');
INSERT INTO `ot_reports` VALUES ('21', '滴滴答滴答', '滴滴答滴答', '滴滴答滴答滴滴答滴答滴滴答滴答', '1', '192.168.1.163', '1463125063', '0');
INSERT INTO `ot_reports` VALUES ('22', 'pp9999999', '飞飞飞', 'ssdadsa<img src=\"/ot/Uploads/Editor/2016-05-17/573a7a0b1feb6.png\" alt=\"\" />', '1', '192.168.1.163', '1463450124', '0');
INSERT INTO `ot_reports` VALUES ('23', 'pp18888', '举报啊111', '<img src=\"/ot/Uploads/Editor/2016-05-17/573ae5ac56360.png\" alt=\"\" /><br />', '17', '192.168.1.163', '1463477372', '0');
INSERT INTO `ot_reports` VALUES ('24', 'wwww', 'ggg', 'wwwww', '41', '192.168.1.106', '1469175728', '0');

-- ----------------------------
-- Table structure for `ot_slider`
-- ----------------------------
DROP TABLE IF EXISTS `ot_slider`;
CREATE TABLE `ot_slider` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pic_id` int(11) NOT NULL COMMENT '地址',
  `title` varchar(500) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ot_slider
-- ----------------------------
INSERT INTO `ot_slider` VALUES ('29', '14', '1', '1463638348');
INSERT INTO `ot_slider` VALUES ('30', '15', '2', '1463638406');
INSERT INTO `ot_slider` VALUES ('35', '20', '', '1469175766');
INSERT INTO `ot_slider` VALUES ('34', '1', '', '1469175211');

-- ----------------------------
-- Table structure for `ot_ucenter_admin`
-- ----------------------------
DROP TABLE IF EXISTS `ot_ucenter_admin`;
CREATE TABLE `ot_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of ot_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_ucenter_app`
-- ----------------------------
DROP TABLE IF EXISTS `ot_ucenter_app`;
CREATE TABLE `ot_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of ot_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_ucenter_member`
-- ----------------------------
DROP TABLE IF EXISTS `ot_ucenter_member`;
CREATE TABLE `ot_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of ot_ucenter_member
-- ----------------------------
INSERT INTO `ot_ucenter_member` VALUES ('1', 'admin', '333be91203a410a590e9e7e141119fe1', 'admin@admin.com', '', '1462457054', '0', '1469175740', '0', '1462457054', '1');
INSERT INTO `ot_ucenter_member` VALUES ('2', 'pengpu', '404a10052653c29f4383dba3108c9da6', '1@q.com', '', '1462327163', '0', '1462778254', '0', '1462327163', '1');
INSERT INTO `ot_ucenter_member` VALUES ('12', 'pp1882', '404a10052653c29f4383dba3108c9da6', 'pp1882@qq.com', '18788881111', '1462375898', '0', '0', '0', '1462375898', '1');
INSERT INTO `ot_ucenter_member` VALUES ('11', 'pp1881', '404a10052653c29f4383dba3108c9da6', 'pp1881@qq.com', '13011110000', '1462375723', '0', '0', '0', '1462375723', '1');
INSERT INTO `ot_ucenter_member` VALUES ('13', 'pp1883', '404a10052653c29f4383dba3108c9da6', 'pp1883@qq.com', '', '1462375928', '0', '0', '0', '1462375928', '1');
INSERT INTO `ot_ucenter_member` VALUES ('14', 'pp1884', '404a10052653c29f4383dba3108c9da6', 'pp1884@qq.com', '', '1462411829', '0', '0', '0', '1462411829', '1');
INSERT INTO `ot_ucenter_member` VALUES ('15', 'pp1885', '404a10052653c29f4383dba3108c9da6', 'pp1885@gmail.com', '', '1462412273', '0', '1462420225', '0', '1462412273', '1');
INSERT INTO `ot_ucenter_member` VALUES ('16', 'pp1886', '2fc34682256d5f1e6b2e961ba3018ced', 'pp1886@qq.com', '15833332222', '1462419649', '0', '1462419531', '0', '1462419649', '1');
INSERT INTO `ot_ucenter_member` VALUES ('17', 'pp1887', 'c6a4610156bb7df0ea0f9d6adf94ef47', 'c6a4610156bb7df0ea0f9d6adf94ef47', '18765676543', '1462458041', '0', '1463619946', '0', '1462458041', '1');
INSERT INTO `ot_ucenter_member` VALUES ('18', 'pp1888', '404a10052653c29f4383dba3108c9da6', 'pp1888@qq.com', '', '1462413125', '0', '1462413984', '0', '1462413125', '1');
INSERT INTO `ot_ucenter_member` VALUES ('19', 'pp8887', '404a10052653c29f4383dba3108c9da6', 'pp8887@qq.com', '', '1462419184', '0', '1462458635', '0', '1462419184', '1');
INSERT INTO `ot_ucenter_member` VALUES ('20', 'pp1889', '404a10052653c29f4383dba3108c9da6', 'pp1889@qq.com', '18900097877', '1462420650', '0', '1463624277', '0', '1462420650', '1');
INSERT INTO `ot_ucenter_member` VALUES ('21', 'pp1890', '8d8a5713b5ac8f9c05b51d4fe55028c5', 'pp1890@qq.com', '18765434444', '1462420915', '0', '0', '0', '1462420915', '1');
INSERT INTO `ot_ucenter_member` VALUES ('22', 'pp1891', '404a10052653c29f4383dba3108c9da6', 'pp1891@qq.com', '', '1462421006', '0', '1462421050', '0', '1462421006', '1');
INSERT INTO `ot_ucenter_member` VALUES ('23', 'pp1893', '404a10052653c29f4383dba3108c9da6', '1@qwq.com', '18255556666', '1462773146', '0', '0', '0', '1462773146', '1');
INSERT INTO `ot_ucenter_member` VALUES ('24', 'pp1894', '404a10052653c29f4383dba3108c9da6', '23222@wwwww.com', '18259554444', '1462773245', '0', '0', '0', '1462773245', '1');
INSERT INTO `ot_ucenter_member` VALUES ('26', 'pp1896', '404a10052653c29f4383dba3108c9da6', 'wwww@moinjc.com', '18233336665', '1462773691', '0', '1462773699', '0', '1462773691', '1');
INSERT INTO `ot_ucenter_member` VALUES ('27', 'pp1897', '404a10052653c29f4383dba3108c9da6', '1@qqqqqqq.com', '18788888888', '1462783826', '0', '0', '0', '1462783826', '1');
INSERT INTO `ot_ucenter_member` VALUES ('28', 'pp1898', '404a10052653c29f4383dba3108c9da6', '23w@mnvde.com', '18565456665', '1462784238', '0', '0', '0', '1462784238', '1');
INSERT INTO `ot_ucenter_member` VALUES ('29', 'pp1899', '404a10052653c29f4383dba3108c9da6', '23w333@mnvde.com', '18965456665', '1462784722', '0', '0', '0', '1462784722', '1');
INSERT INTO `ot_ucenter_member` VALUES ('30', 'pp1990', '404a10052653c29f4383dba3108c9da6', '2@eeeeeeeee.com', '18564569887', '1462785319', '0', '1463475799', '0', '1462785319', '1');
INSERT INTO `ot_ucenter_member` VALUES ('31', 'pp1991', '404a10052653c29f4383dba3108c9da6', '2@eee2eeeeee.com', '18561569887', '1463116713', '0', '1463535862', '0', '1463116713', '1');
INSERT INTO `ot_ucenter_member` VALUES ('32', 'mobile', 'b4113d07a599df1d9670504ae3c23e84', 'q@ss.com', '18566666666', '1463045112', '0', '1463045398', '0', '1463045112', '1');
INSERT INTO `ot_ucenter_member` VALUES ('33', 'pp1900', '404a10052653c29f4383dba3108c9da6', 'n@qq.com', '18208702258', '1463056427', '0', '0', '0', '1463056427', '1');
INSERT INTO `ot_ucenter_member` VALUES ('34', 'pp1992', '404a10052653c29f4383dba3108c9da6', '124@qqq.com', '18566667777', '1463361705', '0', '1463361717', '0', '1463361705', '1');
INSERT INTO `ot_ucenter_member` VALUES ('35', 'pp1993', '404a10052653c29f4383dba3108c9da6', '123@qqq.com', '18800000000', '1463478043', '0', '1463478312', '0', '1463478043', '1');
INSERT INTO `ot_ucenter_member` VALUES ('36', 'pp1994', 'c540d6e67132f251bce6575d6580f99b', 'we@cc.com', '18259468888', '1463538615', '0', '1463541856', '0', '1463538615', '0');
INSERT INTO `ot_ucenter_member` VALUES ('37', 'pp1995', '404a10052653c29f4383dba3108c9da6', '2@qqqqwwww.com', '18900001111', '1463538898', '0', '1463551629', '0', '1463538898', '1');
INSERT INTO `ot_ucenter_member` VALUES ('38', 'pp1996', '404a10052653c29f4383dba3108c9da6', '1m@qqq.com', '18566698887', '1463551830', '0', '1463551871', '0', '1463551830', '1');
INSERT INTO `ot_ucenter_member` VALUES ('39', 'pp1997', '404a10052653c29f4383dba3108c9da6', '1wwwwwwwwwww@qq.com', '18788889999', '1463551967', '0', '1463552130', '0', '1463551967', '1');
INSERT INTO `ot_ucenter_member` VALUES ('40', 'pp1998', '404a10052653c29f4383dba3108c9da6', '121@qqqq.com', '18799990000', '1463552170', '0', '1463552204', '0', '1463552170', '1');
INSERT INTO `ot_ucenter_member` VALUES ('41', 'pp1999', '404a10052653c29f4383dba3108c9da6', '124910168@qq.com', '18766666666', '1463645588', '0', '1469175700', '0', '1463645588', '1');
INSERT INTO `ot_ucenter_member` VALUES ('42', 'pp2000', 'c50a040388181b2e297c68ed11673b95', 'dddddeqq@qqq.com', '18799996665', '1463553821', '0', '1463553880', '0', '1463553821', '1');
INSERT INTO `ot_ucenter_member` VALUES ('43', 'pp2001', 'e4dcd9ef89857a9faaed1e6f054bacaf', '10dddddm@qqo.com', '18765434442', '1463553938', '0', '1463554022', '0', '1463553938', '1');
INSERT INTO `ot_ucenter_member` VALUES ('44', 'pp2002', '404a10052653c29f4383dba3108c9da6', '223e@www.com', '18900003522', '1463635095', '0', '0', '0', '1463635095', '1');
INSERT INTO `ot_ucenter_member` VALUES ('45', 'pp2003', '404a10052653c29f4383dba3108c9da6', 'fewqqq@ppp.com', '18577768889', '1463635685', '0', '0', '0', '1463635685', '1');
INSERT INTO `ot_ucenter_member` VALUES ('46', 'pp2005', '8d8a5713b5ac8f9c05b51d4fe55028c5', '13555555555@qq.com', '13555555555', '1463646024', '0', '1463646000', '0', '1463646024', '1');

-- ----------------------------
-- Table structure for `ot_ucenter_setting`
-- ----------------------------
DROP TABLE IF EXISTS `ot_ucenter_setting`;
CREATE TABLE `ot_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of ot_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_url`
-- ----------------------------
DROP TABLE IF EXISTS `ot_url`;
CREATE TABLE `ot_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of ot_url
-- ----------------------------

-- ----------------------------
-- Table structure for `ot_userdata`
-- ----------------------------
DROP TABLE IF EXISTS `ot_userdata`;
CREATE TABLE `ot_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ot_userdata
-- ----------------------------
