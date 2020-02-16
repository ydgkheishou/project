/*
 Navicat Premium Data Transfer

 Source Server         : mysql_link
 Source Server Type    : MySQL
 Source Server Version : 50528
 Source Host           : localhost:3306
 Source Schema         : jwglxt

 Target Server Type    : MySQL
 Target Server Version : 50528
 File Encoding         : 65001

 Date: 16/02/2020 14:36:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for center
-- ----------------------------
DROP TABLE IF EXISTS `center`;
CREATE TABLE `center`  (
  `cid` int(15) NULL DEFAULT NULL,
  `sid` int(15) NULL DEFAULT NULL,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `sid`(`sid`) USING BTREE,
  CONSTRAINT `center_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `center_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `t_admin` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of center
-- ----------------------------
INSERT INTO `center` VALUES (8, 2);
INSERT INTO `center` VALUES (7, 5);
INSERT INTO `center` VALUES (8, 5);
INSERT INTO `center` VALUES (7, 6);
INSERT INTO `center` VALUES (8, 6);
INSERT INTO `center` VALUES (8, 7);
INSERT INTO `center` VALUES (8, 35);
INSERT INTO `center` VALUES (7, 40);
INSERT INTO `center` VALUES (7, 2);
INSERT INTO `center` VALUES (9, 2);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `cid` int(15) NOT NULL AUTO_INCREMENT,
  `coursename` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `courseclass` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tid` int(15) NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `t_admin` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (7, 'java程序设计', 'j2-408', 3);
INSERT INTO `course` VALUES (8, '数据结构', 'j3-502', 4);
INSERT INTO `course` VALUES (9, '高等代数', 'j1-302', 8);

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `gid` int(15) NOT NULL AUTO_INCREMENT,
  `chinese` int(11) NULL DEFAULT NULL,
  `math` int(15) NULL DEFAULT NULL,
  `english` int(11) NULL DEFAULT NULL,
  `sum` int(25) NULL DEFAULT NULL,
  `gorder` int(15) NULL DEFAULT NULL,
  `sid` int(15) NULL DEFAULT NULL,
  PRIMARY KEY (`gid`) USING BTREE,
  INDEX `sid`(`gorder`) USING BTREE,
  INDEX `sid_2`(`sid`) USING BTREE,
  CONSTRAINT `grade_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `t_admin` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES (51, 97, 88, 75, 260, 1, 5);
INSERT INTO `grade` VALUES (52, 80, 89, 0, 169, 1, 6);
INSERT INTO `grade` VALUES (54, 0, 95, 80, 175, 1, 7);
INSERT INTO `grade` VALUES (55, 0, 80, 0, 80, 1, 35);
INSERT INTO `grade` VALUES (56, 87, 0, 0, 87, 1, 40);
INSERT INTO `grade` VALUES (57, 85, 80, 60, 225, 1, 2);

-- ----------------------------
-- Table structure for grade_test
-- ----------------------------
DROP TABLE IF EXISTS `grade_test`;
CREATE TABLE `grade_test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` int(11) NULL DEFAULT NULL,
  `gorder` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for infomation
-- ----------------------------
DROP TABLE IF EXISTS `infomation`;
CREATE TABLE `infomation`  (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` date NULL DEFAULT NULL,
  PRIMARY KEY (`nid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of infomation
-- ----------------------------
INSERT INTO `infomation` VALUES (1, '重要通知！请全体学员在2020年1月20日前完成选课，最起码要选择一门课程。', '2019-12-20');
INSERT INTO `infomation` VALUES (2, '选完课程后请尽快完成相关的考试！', '2019-12-21');
INSERT INTO `infomation` VALUES (3, '祝愿大家考个好成绩！', '2019-12-22');
INSERT INTO `infomation` VALUES (4, '马上快要过年了，祝大家新年快乐！', '2019-12-28');
INSERT INTO `infomation` VALUES (5, '新年快乐！', '2020-01-23');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `roleid` int(15) NOT NULL AUTO_INCREMENT,
  `role` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`roleid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '学生');
INSERT INTO `role` VALUES (2, '教师');
INSERT INTO `role` VALUES (3, '教务处');

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin`  (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userpwd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `problem` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `answer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rid` int(15) NULL DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  INDEX `userid`(`userid`, `rid`) USING BTREE,
  CONSTRAINT `t_admin_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `role` (`roleid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES (1, '管理员', '123456', '我的小学名称是？', '官庄小学', 3);
INSERT INTO `t_admin` VALUES (2, '学生1', '123456', '我最喜欢的水果是？', '香蕉和西瓜', 1);
INSERT INTO `t_admin` VALUES (3, '教师1', '12345', '我最想去的地方是？', '德国', 2);
INSERT INTO `t_admin` VALUES (4, '教师2', '3216', '我最不喜欢的地方是？', '没有', 2);
INSERT INTO `t_admin` VALUES (5, '学生2', '66666', '很厉害!', '那可不', 1);
INSERT INTO `t_admin` VALUES (6, '学生3', '666555', '喜欢去哪个城市？', '武汉', 1);
INSERT INTO `t_admin` VALUES (7, '学生4', '12345', '最喜欢的一首歌是？', '桥边姑娘', 1);
INSERT INTO `t_admin` VALUES (8, '教师3', '123456', '最中意的明星是？', '舟一', 2);
INSERT INTO `t_admin` VALUES (20, '新教师1', '888666', '喜欢去？', '张家界', 2);
INSERT INTO `t_admin` VALUES (35, '新生1', '123', '喜欢走？', '别人没走过的路', 1);
INSERT INTO `t_admin` VALUES (36, '新生2', '888888', '喜欢跳？', '皮筋', 1);
INSERT INTO `t_admin` VALUES (37, '新教师2', '888999', '喜欢玩？', '泥鳅', 2);
INSERT INTO `t_admin` VALUES (38, '新生3', '987654321', '喜欢跑？', '大神', 1);
INSERT INTO `t_admin` VALUES (40, '学生5', '8888888', '乐意？', '玩耍', 1);
INSERT INTO `t_admin` VALUES (41, '新生6', '999', '我最喜欢的地方是？', '磁湖', 1);

SET FOREIGN_KEY_CHECKS = 1;
