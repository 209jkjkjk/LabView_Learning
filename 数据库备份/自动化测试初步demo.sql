/*
 Navicat Premium Data Transfer

 Source Server         : 本地的mysql8
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : jsontest

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 04/04/2023 12:54:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for component
-- ----------------------------
DROP TABLE IF EXISTS `component`;
CREATE TABLE `component`  (
  `id` int(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_final_product` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of component
-- ----------------------------
INSERT INTO `component` VALUES (1010, '元件1', 0);
INSERT INTO `component` VALUES (1011, '元件2', 0);
INSERT INTO `component` VALUES (1020, '板子1', 0);
INSERT INTO `component` VALUES (1022, '板子2', 0);
INSERT INTO `component` VALUES (3000, '产品1', 1);

-- ----------------------------
-- Table structure for component_detail
-- ----------------------------
DROP TABLE IF EXISTS `component_detail`;
CREATE TABLE `component_detail`  (
  `parent_id` int(0) NOT NULL,
  `son_id` int(0) NOT NULL,
  PRIMARY KEY (`parent_id`, `son_id`) USING BTREE,
  INDEX `component_detail_fk_2`(`son_id`) USING BTREE,
  CONSTRAINT `component_detail_fk_1` FOREIGN KEY (`parent_id`) REFERENCES `component` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `component_detail_fk_2` FOREIGN KEY (`son_id`) REFERENCES `component` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of component_detail
-- ----------------------------
INSERT INTO `component_detail` VALUES (1020, 1010);
INSERT INTO `component_detail` VALUES (1020, 1011);
INSERT INTO `component_detail` VALUES (3000, 1020);
INSERT INTO `component_detail` VALUES (3000, 1022);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` smallint(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (0, '黄浩然');
INSERT INTO `employee` VALUES (1, '姬子正');
INSERT INTO `employee` VALUES (2, '宋鑫');
INSERT INTO `employee` VALUES (3, '李想');
INSERT INTO `employee` VALUES (4, '王丽雅');
INSERT INTO `employee` VALUES (5, '李丽雅');
INSERT INTO `employee` VALUES (6, '张丽雅');
INSERT INTO `employee` VALUES (7, '宋丽雅');

-- ----------------------------
-- Table structure for jsontable
-- ----------------------------
DROP TABLE IF EXISTS `jsontable`;
CREATE TABLE `jsontable`  (
  `thisisjson` json NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jsontable
-- ----------------------------
INSERT INTO `jsontable` VALUES ('{\"email\": \"abc@example.com\", \"phone\": \"+11800000000\", \"address\": {\"pin\": \"560103\", \"city\": \"Bangalore\", \"line1\": \"abc\", \"line2\": \"xyz street\"}, \"location\": \"IN\"}');
INSERT INTO `jsontable` VALUES ('{}');
INSERT INTO `jsontable` VALUES ('{\"good\": \"one\"}');
INSERT INTO `jsontable` VALUES ('{\"good\": \"TWO\"}');

-- ----------------------------
-- Table structure for workshop_record
-- ----------------------------
DROP TABLE IF EXISTS `workshop_record`;
CREATE TABLE `workshop_record`  (
  `id` int(0) NOT NULL,
  `test_result` json NOT NULL,
  `component_id` int(0) NOT NULL,
  `employee_id` smallint(0) NOT NULL,
  `photo_folder_path` varchar(1023) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `datetime` datetime(0) NOT NULL,
  `process_numer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '加工单号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `component_id`(`component_id`) USING BTREE,
  INDEX `employee_id`(`employee_id`) USING BTREE,
  CONSTRAINT `workshop_record_ibfk_1` FOREIGN KEY (`component_id`) REFERENCES `component` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `workshop_record_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of workshop_record
-- ----------------------------
INSERT INTO `workshop_record` VALUES (1, '{\"测试项目1\": true}', 1010, 0, NULL, '2023-04-03 09:39:17', NULL);
INSERT INTO `workshop_record` VALUES (2, '{\"测试项目1\": true, \"测试项目2\": true, \"测试项目3\": true, \"测试项目4\": true, \"测试项目5\": true}', 1011, 1, NULL, '2023-04-03 09:42:31', NULL);
INSERT INTO `workshop_record` VALUES (3, '{\"项目2\": false, \"试项目1\": true}', 1022, 2, NULL, '2023-04-03 09:43:02', NULL);
INSERT INTO `workshop_record` VALUES (4, '{\"项目2\": false, \"试项目1\": true}', 3000, 7, NULL, '2023-04-03 09:45:20', NULL);

SET FOREIGN_KEY_CHECKS = 1;
