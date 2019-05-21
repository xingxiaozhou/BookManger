/*
Navicat MySQL Data Transfer

Source Server         : 新链接
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : custormerdb

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2019-05-21 18:44:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for book_info
-- ----------------------------
DROP TABLE IF EXISTS `book_info`;
CREATE TABLE `book_info` (
  `book_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '图书id',
  `book_code` varchar(50) NOT NULL COMMENT '图书编号',
  `book_name` varchar(50) NOT NULL COMMENT '图书名称',
  `book_type` int(10) NOT NULL COMMENT '图书类型',
  `book_author` varchar(20) NOT NULL COMMENT '图书作者',
  `publish_press` varchar(200) NOT NULL COMMENT '出版社',
  `publish_date` date NOT NULL COMMENT '出版日期',
  `is_borrow` int(1) NOT NULL COMMENT '是否借阅（1、已借阅0、未借阅）',
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  KEY `book _type` (`book_type`),
  CONSTRAINT `book_info_ibfk_1` FOREIGN KEY (`book_type`) REFERENCES `book_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book_info
-- ----------------------------
INSERT INTO `book_info` VALUES ('85', '002', '斗破苍穹', '5', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '0', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('90', '007', '斗破苍穹', '2', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '0', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('92', '009', '斗破苍穹', '7', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '1', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('94', '011', '斗破苍穹', '2', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '1', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('96', '013', '斗破苍穹', '3', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '1', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('97', '014', '斗破苍穹', '4', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '0', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('98', '015', '斗破苍穹', '4', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '0', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('99', '016', '斗破苍穹', '6', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '1', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('100', '017', '斗破苍穹', '6', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '0', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('101', '018', '斗破苍穹', '7', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '1', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('102', '019', '斗破苍穹', '7', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '0', 'images/002.jpg');
INSERT INTO `book_info` VALUES ('104', '020', '斗破苍穹', '8', '天蚕土豆', '天蚕土豆出版社', '2018-04-04', '0', 'images/002.jpg');

-- ----------------------------
-- Table structure for book_type
-- ----------------------------
DROP TABLE IF EXISTS `book_type`;
CREATE TABLE `book_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type_name` varchar(20) NOT NULL COMMENT '图书类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book_type
-- ----------------------------
INSERT INTO `book_type` VALUES ('1', '小说');
INSERT INTO `book_type` VALUES ('2', '文学');
INSERT INTO `book_type` VALUES ('3', '传记');
INSERT INTO `book_type` VALUES ('4', '艺术');
INSERT INTO `book_type` VALUES ('5', '少儿');
INSERT INTO `book_type` VALUES ('6', '经济');
INSERT INTO `book_type` VALUES ('7', '管理');
INSERT INTO `book_type` VALUES ('8', '科技');
