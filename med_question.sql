/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3308
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : laravel

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 10/04/2021 04:05:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blog_categories
-- ----------------------------
DROP TABLE IF EXISTS `blog_categories`;
CREATE TABLE `blog_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `blog_categories_slug_unique`(`slug`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `blog_tags`;
CREATE TABLE `blog_tags`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `blog_tags_blog_id_foreign`(`blog_id`) USING BTREE,
  CONSTRAINT `blog_tags_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for blogs
-- ----------------------------
DROP TABLE IF EXISTS `blogs`;
CREATE TABLE `blogs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `blog_post` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `blog_category_id` bigint(20) UNSIGNED NOT NULL,
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `blogs_blog_category_id_foreign`(`blog_category_id`) USING BTREE,
  CONSTRAINT `blogs_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (6, '2020_08_28_072131_create_blog_categories_table', 3);
INSERT INTO `migrations` VALUES (7, '2020_08_28_072234_create_blogs_table', 3);
INSERT INTO `migrations` VALUES (8, '2020_08_28_103502_create_variants_table', 3);
INSERT INTO `migrations` VALUES (10, '2020_08_28_104103_create_blog_tags_table', 3);
INSERT INTO `migrations` VALUES (14, '2020_08_28_063029_create_products_table', 4);
INSERT INTO `migrations` VALUES (15, '2020_08_28_103644_create_product_images_table', 4);
INSERT INTO `migrations` VALUES (16, '2020_08_31_065549_create_product_variants_table', 4);
INSERT INTO `migrations` VALUES (17, '2020_08_31_073704_create_product_variant_prices_table', 4);
INSERT INTO `migrations` VALUES (18, '2020_08_31_081510_create_product_variant_price_relation_table', 4);

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_images
-- ----------------------------
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` tinyint(1) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_images_product_id_foreign`(`product_id`) USING BTREE,
  CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_variant_prices
-- ----------------------------
DROP TABLE IF EXISTS `product_variant_prices`;
CREATE TABLE `product_variant_prices`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_variant_one` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `product_variant_two` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `product_variant_three` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `price` double NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_variant_prices_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `product_variant_prices_product_variant_one_foreign`(`product_variant_one`) USING BTREE,
  INDEX `product_variant_prices_product_variant_two_foreign`(`product_variant_two`) USING BTREE,
  INDEX `product_variant_prices_product_variant_three_foreign`(`product_variant_three`) USING BTREE,
  CONSTRAINT `product_variant_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_variant_prices_product_variant_one_foreign` FOREIGN KEY (`product_variant_one`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_variant_prices_product_variant_three_foreign` FOREIGN KEY (`product_variant_three`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_variant_prices_product_variant_two_foreign` FOREIGN KEY (`product_variant_two`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_variant_prices
-- ----------------------------
INSERT INTO `product_variant_prices` VALUES (1, 1, 4, NULL, 150, 150, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (2, 1, 5, NULL, 15, 54, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (3, 1, 6, NULL, 564564, 546, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (4, 2, 4, NULL, 54, 45, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (5, 2, 5, NULL, 45, 45, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (6, 2, 6, NULL, 454, 45, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (7, 3, 4, NULL, 45, 54, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (8, 3, 5, NULL, 54, 54, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (9, 3, 6, NULL, 54, 545, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variant_prices` VALUES (10, 4, 1, NULL, 150, 150, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variant_prices` VALUES (11, 4, 2, NULL, 15, 15, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variant_prices` VALUES (12, 4, 3, NULL, 15, 15, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variant_prices` VALUES (13, 8, 1, NULL, 15, 15, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variant_prices` VALUES (14, 8, 2, NULL, 15, 15, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variant_prices` VALUES (15, 8, 3, NULL, 51, 515, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variant_prices` VALUES (16, 1, 4, 17, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (17, 1, 4, 18, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (18, 1, 8, 17, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (19, 1, 8, 18, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (20, 1, 6, 17, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (21, 1, 6, 18, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (22, 2, 4, 17, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (23, 2, 4, 18, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (24, 2, 8, 17, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (25, 2, 8, 18, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (26, 2, 6, 17, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (27, 2, 6, 18, 0, 0, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variant_prices` VALUES (28, 1, 4, 17, 0, 0, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variant_prices` VALUES (29, 1, 4, 18, 0, 0, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variant_prices` VALUES (30, 1, 8, 17, 0, 0, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variant_prices` VALUES (31, 1, 8, 18, 0, 0, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variant_prices` VALUES (32, 1, 6, 17, 0, 0, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variant_prices` VALUES (33, 1, 6, 18, 0, 0, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variant_prices` VALUES (34, 2, 4, 17, 0, 0, 4, '2020-08-31 16:21:45', '2020-08-31 16:21:45');
INSERT INTO `product_variant_prices` VALUES (35, 2, 4, 18, 0, 0, 4, '2020-08-31 16:21:45', '2020-08-31 16:21:45');
INSERT INTO `product_variant_prices` VALUES (36, 2, 8, 17, 0, 0, 4, '2020-08-31 16:21:45', '2020-08-31 16:21:45');
INSERT INTO `product_variant_prices` VALUES (37, 2, 8, 18, 0, 0, 4, '2020-08-31 16:21:45', '2020-08-31 16:21:45');
INSERT INTO `product_variant_prices` VALUES (38, 2, 6, 17, 0, 0, 4, '2020-08-31 16:21:45', '2020-08-31 16:21:45');
INSERT INTO `product_variant_prices` VALUES (39, 2, 6, 18, 0, 0, 4, '2020-08-31 16:21:45', '2020-08-31 16:21:45');
INSERT INTO `product_variant_prices` VALUES (40, 1, 4, 17, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (41, 1, 4, 18, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (42, 1, 8, 17, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (43, 1, 8, 18, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (44, 1, 6, 17, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (45, 1, 6, 18, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (46, 2, 4, 17, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (47, 2, 4, 18, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (48, 2, 8, 17, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (49, 2, 8, 18, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (50, 2, 6, 17, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (51, 2, 6, 18, 0, 0, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variant_prices` VALUES (52, 1, 4, 17, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (53, 1, 4, 18, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (54, 1, 8, 17, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (55, 1, 8, 18, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (56, 1, 6, 17, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (57, 1, 6, 18, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (58, 2, 4, 17, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (59, 2, 4, 18, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (60, 2, 8, 17, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (61, 2, 8, 18, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (62, 2, 6, 17, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (63, 2, 6, 18, 0, 0, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variant_prices` VALUES (64, 1, 4, 17, 0, 0, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variant_prices` VALUES (65, 1, 4, 18, 0, 0, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variant_prices` VALUES (66, 1, 8, 17, 0, 0, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variant_prices` VALUES (67, 1, 8, 18, 0, 0, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variant_prices` VALUES (68, 1, 6, 17, 0, 0, 7, '2020-08-31 16:38:40', '2020-08-31 16:38:40');
INSERT INTO `product_variant_prices` VALUES (69, 1, 6, 18, 0, 0, 7, '2020-08-31 16:38:40', '2020-08-31 16:38:40');
INSERT INTO `product_variant_prices` VALUES (70, 2, 4, 17, 0, 0, 7, '2020-08-31 16:38:40', '2020-08-31 16:38:40');
INSERT INTO `product_variant_prices` VALUES (71, 2, 4, 18, 0, 0, 7, '2020-08-31 16:38:40', '2020-08-31 16:38:40');
INSERT INTO `product_variant_prices` VALUES (72, 2, 8, 17, 0, 0, 7, '2020-08-31 16:38:40', '2020-08-31 16:38:40');
INSERT INTO `product_variant_prices` VALUES (73, 2, 8, 18, 0, 0, 7, '2020-08-31 16:38:40', '2020-08-31 16:38:40');
INSERT INTO `product_variant_prices` VALUES (74, 2, 6, 17, 0, 0, 7, '2020-08-31 16:38:40', '2020-08-31 16:38:40');
INSERT INTO `product_variant_prices` VALUES (75, 2, 6, 18, 0, 0, 7, '2020-08-31 16:38:40', '2020-08-31 16:38:40');
INSERT INTO `product_variant_prices` VALUES (78, 47, 48, NULL, 50, 10, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variant_prices` VALUES (79, 49, 50, NULL, 12, 5, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variant_prices` VALUES (80, 51, 52, NULL, 10, 0, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variant_prices` VALUES (83, 59, 60, 61, 10, 5, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variant_prices` VALUES (84, 62, 63, 64, 15, 5, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variant_prices` VALUES (85, 65, 66, 67, 258, 269, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');

-- ----------------------------
-- Table structure for product_variants
-- ----------------------------
DROP TABLE IF EXISTS `product_variants`;
CREATE TABLE `product_variants`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `variant` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_variants_variant_id_foreign`(`variant_id`) USING BTREE,
  INDEX `product_variants_product_id_foreign`(`product_id`) USING BTREE,
  CONSTRAINT `product_variants_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_variants_variant_id_foreign` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_variants
-- ----------------------------
INSERT INTO `product_variants` VALUES (1, 'red', 1, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variants` VALUES (2, 'green', 1, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variants` VALUES (3, 'blue', 1, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variants` VALUES (4, 'xl', 2, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variants` VALUES (5, 'sm', 2, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variants` VALUES (6, 'm', 2, 1, '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `product_variants` VALUES (7, 'XL', 2, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variants` VALUES (8, 'L', 2, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variants` VALUES (9, 'red', 1, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variants` VALUES (10, 'green', 1, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variants` VALUES (11, 'blue', 1, 2, '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `product_variants` VALUES (12, 'red', 1, 3, '2020-08-31 16:21:29', '2020-08-31 16:21:29');
INSERT INTO `product_variants` VALUES (13, 'green', 1, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variants` VALUES (14, 'xl', 2, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variants` VALUES (15, 'l', 2, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variants` VALUES (16, 'm', 2, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variants` VALUES (17, 'v-nick', 6, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variants` VALUES (18, 'o-nick', 6, 3, '2020-08-31 16:21:30', '2020-08-31 16:21:30');
INSERT INTO `product_variants` VALUES (19, 'red', 1, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variants` VALUES (20, 'green', 1, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variants` VALUES (21, 'xl', 2, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variants` VALUES (22, 'l', 2, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variants` VALUES (23, 'm', 2, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variants` VALUES (24, 'v-nick', 6, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variants` VALUES (25, 'o-nick', 6, 4, '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `product_variants` VALUES (26, 'red', 1, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variants` VALUES (27, 'green', 1, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variants` VALUES (28, 'xl', 2, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variants` VALUES (29, 'l', 2, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variants` VALUES (30, 'm', 2, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variants` VALUES (31, 'v-nick', 6, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variants` VALUES (32, 'o-nick', 6, 5, '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `product_variants` VALUES (33, 'red', 1, 6, '2020-08-31 16:38:17', '2020-08-31 16:38:17');
INSERT INTO `product_variants` VALUES (34, 'green', 1, 6, '2020-08-31 16:38:17', '2020-08-31 16:38:17');
INSERT INTO `product_variants` VALUES (35, 'xl', 2, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variants` VALUES (36, 'l', 2, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variants` VALUES (37, 'm', 2, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variants` VALUES (38, 'v-nick', 6, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variants` VALUES (39, 'o-nick', 6, 6, '2020-08-31 16:38:18', '2020-08-31 16:38:18');
INSERT INTO `product_variants` VALUES (40, 'red', 1, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variants` VALUES (41, 'green', 1, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variants` VALUES (42, 'xl', 2, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variants` VALUES (43, 'l', 2, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variants` VALUES (44, 'm', 2, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variants` VALUES (45, 'v-nick', 6, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variants` VALUES (46, 'o-nick', 6, 7, '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `product_variants` VALUES (47, 'asdasds', 1, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variants` VALUES (48, 'asasdasd', 2, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variants` VALUES (49, 'asdasd', 1, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variants` VALUES (50, 'asdadas', 2, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variants` VALUES (51, 'asdasd', 1, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variants` VALUES (52, 'asdasd', 2, 12, '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `product_variants` VALUES (59, 'Yellow', 1, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variants` VALUES (60, 'XXl', 2, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variants` VALUES (61, 'Full', 6, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variants` VALUES (62, 'Coffee', 1, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variants` VALUES (63, 'Xl', 2, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variants` VALUES (64, 'FULL', 6, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variants` VALUES (65, 'asdasd', 1, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variants` VALUES (66, 'asdasdasd', 2, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');
INSERT INTO `product_variants` VALUES (67, 'asd123', 6, 14, '2021-04-09 22:04:59', '2021-04-09 22:04:59');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `products_sku_unique`(`sku`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Product Name', 'asdflasdf', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 08:18:53', '2020-08-31 08:18:53');
INSERT INTO `products` VALUES (2, 'Product Two', 'adfsadfsasf', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 15:25:57', '2020-08-31 15:25:57');
INSERT INTO `products` VALUES (3, 'Product Three', 'afdafdfasdfasasdf', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 16:21:29', '2020-08-31 16:21:29');
INSERT INTO `products` VALUES (4, 'Product Four', 'afdafdfasdfasasdfadsf', 'adsfadft is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 16:21:44', '2020-08-31 16:21:44');
INSERT INTO `products` VALUES (5, 'T-Shirt', 't-shirt', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 16:37:15', '2020-08-31 16:37:15');
INSERT INTO `products` VALUES (6, 'T-Shirt RED', 't-shirt-red', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 16:38:17', '2020-08-31 16:38:17');
INSERT INTO `products` VALUES (7, 'Formal Shirt', 'formal-shirt', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 16:38:39', '2020-08-31 16:38:39');
INSERT INTO `products` VALUES (12, 'Product Name Sdd', 'sads', 'dasasdffdsfagsdafsadfsdafsadfsadfasdfsadfsdafasdf s fsdf afa dfa ads fasdf asdt', '2021-04-09 20:39:17', '2021-04-09 20:39:17');
INSERT INTO `products` VALUES (14, 'Product Name Shirt', 'shirt-full', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2021-04-09 20:43:29', '2021-04-09 22:04:59');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp(0) NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Admin', 'admin@example.com', NULL, '$2y$12$RCwNpDy5Kr7h/k/kdFz1xOTeWhcbYLzmUq52yUh7QNpIokU3JWYVi', NULL, '2020-08-28 06:03:42', '2020-08-28 06:03:42');

-- ----------------------------
-- Table structure for variants
-- ----------------------------
DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `variants_title_unique`(`title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of variants
-- ----------------------------
INSERT INTO `variants` VALUES (1, 'Color', 'asdfadsf', NULL, '2020-08-31 14:53:32');
INSERT INTO `variants` VALUES (2, 'Size', 'adfsasdf', NULL, '2020-08-31 14:54:28');
INSERT INTO `variants` VALUES (6, 'Style', 'Description', '2020-08-31 15:46:24', '2020-08-31 15:46:24');

SET FOREIGN_KEY_CHECKS = 1;
