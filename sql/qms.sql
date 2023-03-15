/*
Navicat MySQL Data Transfer

Source Server         : library-management
Source Server Version : 50736
Source Host           : localhost:3306
Source Database       : library-management2

Target Server Type    : MYSQL
Target Server Version : 50736
File Encoding         : 65001

Date: 2023-03-15 18:21:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `createtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username_key` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '13988997788', '3373330965@qq.com', '2022-10-08 22:21:26', '2023-03-15 15:22:58', 'ead08e95e9c867a2ee833c232bf55dbc', '1');
INSERT INTO `admin` VALUES ('4', 'test', '13065175265', '3373330965@qq.com', '2023-03-15 15:22:44', '2023-03-15 15:23:12', 'b81506a4c981a1669f87fde98a1fb27c', '1');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `publish_date` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '出版日期',
  `author` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '作者',
  `publisher` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '出版社',
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类',
  `book_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标准码',
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  `createtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `score` int(10) DEFAULT NULL COMMENT '积分',
  `nums` int(10) DEFAULT '0' COMMENT '数量',
  `unitstatus` tinyint(1) DEFAULT '0' COMMENT '单元测试 0 未通过',
  `sysstatus` tinyint(1) DEFAULT '0' COMMENT '系统测试 0 未通过',
  `acstatus` tinyint(1) DEFAULT '0' COMMENT '验收测试 0 未通过',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `book_no_index` (`book_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('11', 'p1-20230301-周末抢大礼包', '新增埋点', '2023-03-01', '张文英', '黄栗', '【3月需求】 > 20230315-P', 'hhh', 'http://localhost:9090/api/book/file/download/1678857501131?&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzIiwiZXhwIjoxNjgwMTUzNTAxfQ.Ihg6b4Lmwx9ePB3bJu4FsoahvaG6hWAHb_aBIS3-u3I&play=1', '2023-03-15 13:18:22', '2023-03-15 00:00:00', '1', '12', '0', '0', '0');
INSERT INTO `book` VALUES ('12', 'p0-20230107-春节老虎机', '用户可以优惠价购买顺丰svip\n', '2023-01-07', '黄强，许两会', '唐青', '【2月需求】 > 20230215-G', '123', '', '2023-03-15 13:56:44', '2023-03-15 00:00:00', '1', '3', '0', '0', '0');
INSERT INTO `book` VALUES ('13', 'p0-20220215-技术债务', 'SCS线程池改同步或隔离', '2023-02-15', '黄强，李铭', '崔松', '【1月需求】 > 20230107-P', 'ww', '', '2023-03-15 14:31:47', '2023-03-15 00:00:00', '3', '1', '1', '0', '0');
INSERT INTO `book` VALUES ('14', 'p0-20220214-新精准测试', '覆盖率平台一期需求', '2023-02-14', '王焕，李俊峰', '李俊峰', '【1月需求】 > 20230115-G', null, '', '2023-03-15 14:36:23', '2023-03-15 00:00:00', '2', null, '1', '1', '1');
INSERT INTO `book` VALUES ('19', 'P0-20220601-赠送金下线', '储值卡赠送金礼品暂时下线需求', '2023-03-15', '王卓林，陈雅茹', '远志昊', '【3月需求】 > 20230315-P', null, '', '2023-03-15 16:18:47', '2023-03-15 00:00:00', '1', null, '1', '1', '0');
INSERT INTO `book` VALUES ('20', 'P0-20220609-扫码寄下单页', '新增储值卡开卡弹窗需求', '2023-03-15', '于家红', '蔡静怡', '【3月需求】 > 20230315-P', null, '', '2023-03-15 16:30:56', '2023-03-15 00:00:00', '1', null, '1', '0', '0');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `pid` int(11) DEFAULT NULL COMMENT '父级id',
  `createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatetime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('10', '【2月需求】', '', null, '2022-10-12 21:50:08', '2023-03-15 00:00:00');
INSERT INTO `category` VALUES ('11', '20230215-G', '灰度版本', '10', '2022-10-12 21:50:16', '2023-03-15 00:00:00');
INSERT INTO `category` VALUES ('12', '20230201-P', 'p环境版本', '10', '2022-10-12 21:50:22', '2023-03-15 00:00:00');
INSERT INTO `category` VALUES ('14', '【1月需求】', null, null, '2023-03-15 12:42:29', '2023-03-15 00:00:00');
INSERT INTO `category` VALUES ('15', '20230107-P', 'p环境版本', '14', '2023-03-15 12:43:20', '2023-03-15 00:00:00');
INSERT INTO `category` VALUES ('16', '20230115-G', '灰度版本', '14', '2023-03-15 12:44:13', '2023-03-15 00:00:00');
INSERT INTO `category` VALUES ('17', '20230227-H', 'hotfix版本', '10', '2023-03-15 12:49:14', null);
INSERT INTO `category` VALUES ('18', '【3月需求】', null, null, '2023-03-15 15:34:38', null);
INSERT INTO `category` VALUES ('19', '20230315-P', 'p环境版本', '18', '2023-03-15 15:35:30', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '会员码',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `sex` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `createtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime DEFAULT NULL,
  `account` int(10) DEFAULT '0' COMMENT '账户余额',
  `status` tinyint(1) DEFAULT '1' COMMENT '禁用状态 1不禁用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username_index` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('20', '王静', '20220927-2094581083', '25', '女', '138999009988', 'A栋24楼S区', '2022-09-27 22:16:03', '2023-03-15 12:33:49', '0', '1');
INSERT INTO `user` VALUES ('21', '陈仕', '202209271018800687', '28', '女', '138999009988', 'B栋24楼N区', '2022-09-27 22:17:06', '2023-03-15 12:32:17', '110', '1');
INSERT INTO `user` VALUES ('23', '袁红波', '20220927688792394', '33', '男', '13977889988', 'A栋24楼N区', '2022-09-27 22:35:35', '2023-03-15 15:21:45', '-40', '1');
INSERT INTO `user` VALUES ('24', '刘琰', '202303151591429620', '23', '男', '13909098989', 'A栋24楼N区', '2023-03-15 12:38:55', '2023-03-15 13:16:04', '100', '1');
INSERT INTO `user` VALUES ('25', '黄栗', '202303151064069911', '34', '男', '13422223333', 'A栋24楼N区', '2023-03-15 14:42:51', '2023-03-15 18:08:01', '100', '1');
INSERT INTO `user` VALUES ('27', '陈露露', '20230315591335106', '27', '女', '19512343456', 'A栋25楼S区', '2023-03-15 16:09:38', '2023-03-15 16:10:02', '100', '1');
