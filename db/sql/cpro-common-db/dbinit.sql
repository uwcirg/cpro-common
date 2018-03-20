-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: cpro_common
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('e7c930963743');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connect`
--

DROP TABLE IF EXISTS `connect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `connect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `token_type` varchar(20) DEFAULT NULL,
  `access_token` varchar(255) NOT NULL,
  `alt_token` varchar(255) DEFAULT NULL,
  `expires_at` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_connect` (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connect`
--

LOCK TABLES `connect` WRITE;
/*!40000 ALTER TABLE `connect` DISABLE KEYS */;
/*!40000 ALTER TABLE `connect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_client`
--

DROP TABLE IF EXISTS `oauth2_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_client` (
  `client_id` varchar(48) DEFAULT NULL,
  `client_secret` varchar(120) NOT NULL,
  `is_confidential` tinyint(1) NOT NULL,
  `redirect_uris` text NOT NULL,
  `default_redirect_uri` text NOT NULL,
  `allowed_scopes` text NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(48) NOT NULL,
  `website` text,
  `allowed_grants` text,
  PRIMARY KEY (`id`),
  KEY `ix_oauth2_client_client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_client`
--

LOCK TABLES `oauth2_client` WRITE;
/*!40000 ALTER TABLE `oauth2_client` DISABLE KEYS */;
INSERT INTO `oauth2_client` VALUES ('skwIPnbi7N3uIvNysUbi0xfXwnWaIMR1MCJxz8rV0dGxeMJD','0',0,'http://lvh.me:3060/redirect','http://lvh.me:3060/redirect','email',1,1,'tb-mobile-app','lvh.me:3060','implicit');
/*!40000 ALTER TABLE `oauth2_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_code`
--

DROP TABLE IF EXISTS `oauth2_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_code` (
  `code` varchar(120) NOT NULL,
  `client_id` varchar(48) DEFAULT NULL,
  `redirect_uri` text,
  `scope` text,
  `expires_at` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_code`
--

LOCK TABLES `oauth2_code` WRITE;
/*!40000 ALTER TABLE `oauth2_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_token`
--

DROP TABLE IF EXISTS `oauth2_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_token` (
  `client_id` varchar(48) DEFAULT NULL,
  `token_type` varchar(40) DEFAULT NULL,
  `access_token` varchar(255) NOT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `scope` text,
  `created_at` int(11) NOT NULL,
  `expires_in` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token` (`access_token`),
  KEY `ix_oauth2_token_refresh_token` (`refresh_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_token`
--

LOCK TABLES `oauth2_token` WRITE;
/*!40000 ALTER TABLE `oauth2_token` DISABLE KEYS */;
INSERT INTO `oauth2_token` VALUES ('skwIPnbi7N3uIvNysUbi0xfXwnWaIMR1MCJxz8rV0dGxeMJD','Bearer','YCKFtgasJwYoq7C6nPDcryJwuHqpXAn3Q1ErobdCFB',NULL,'email',1520153873,3600,1,647);
/*!40000 ALTER TABLE `oauth2_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-20 12:14:40
