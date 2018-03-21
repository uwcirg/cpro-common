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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_client`
--

LOCK TABLES `oauth2_client` WRITE;
/*!40000 ALTER TABLE `oauth2_client` DISABLE KEYS */;
INSERT INTO `oauth2_client` VALUES ('skwIPnbi7N3uIvNysUbi0xfXwnWaIMR1MCJxz8rV0dGxeMJD','0',0,'http://lvh.me:3060/redirect','http://lvh.me:3060/redirect','email',1,1,'tb-mobile-app','lvh.me:3060','implicit'),('TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','Mrp1Df4KLllsFnHSSnh6QHwk7KODLa32I2SThTEr4Ew2osBtTmFQsxV3OTZfJ5nRRKNTIwE52f1iSq',1,'https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email connects',2,1,'mPOWEr','https://cpro.cirg.washington.edu','authorization_code implicit password client_credentials'),('hk0CjPE4JdREfS1C3OXGHNYkcljtyaXPoyzmugZHMpuASyaK','TjU7uegOCDH7VwUKfUALt7PHO0f6rGSzIXDWNJolT3vsOeNZXOx13V2cZcqe2YqSiYidAw9W9Kiwxl',1,'https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email connects',3,1,'localTest','https://cpro.cirg.washington.edu','authorization_code implicit password client_credentials');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_code`
--

LOCK TABLES `oauth2_code` WRITE;
/*!40000 ALTER TABLE `oauth2_code` DISABLE KEYS */;
INSERT INTO `oauth2_code` VALUES ('u4OCf5eSMPk3otHAm03OgHCW8ZKqYiiAtgOOemRxsA0Qitkj','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664576,1,1),('KWdQFabIhf2OSHrdROJv6n2ypcb3BfdT4r87gJkjl9MfsVvH','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664619,2,1),('NjYNERo64bjvUSPs8Y65HCP7jY5vgniUDqY6rmXqDEhpASaK','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664619,3,1),('VmoxpVklhEAldCkNojzLnrJ5Gfif6MBx2T1yUWVOHVvykx1T','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664624,4,1),('lZxvtavMqcim0XtDh5JUnXdDuURPodL4KVqig5PTXcIKfzYd','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664625,5,1),('2g1rtD2g509hWVJ9DXjktGFzhCO3JsyOgDbet3P0Z0A6V6ZI','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664626,6,1),('TYt35pE1moNPlbXMnpyWOhjxnW3YcHXXqCV2syxWYQdLDrNx','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664627,7,1),('6XmddOJpvoYGuV0jkL8zr9aqHtYQR0VwAyss4xaOb395neDY','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664628,8,1),('LjO4lFwJaY5UIoKNnNK26uWAnaLZI7EmZxMgw7AQvDBn2ALT','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664628,9,1),('OApigujRBJLexu5PqZTumz2ejBh5iidu86IDzyQTzpwvwSA5','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664629,10,1),('V50rYhza23w7hoGUyyNl3VhlT1eHxLq16zkAfCW2HfS2mFoK','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664630,11,1),('TpIHJ9TiomSI5tDG4UWog7sraOwK1awb85jT5SO3x9h1FFPW','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664630,12,1),('IIhIXCIFDcrCBY95KBNFlsVTWe2xxZbfSoBTacFpKdfQ2AMv','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664631,13,1),('Wi0mgs9S3qvYL10HPZ94d30Npd5MhHZC370hKT4jWjGlXuVK','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664636,14,1),('Sh97JEVVKurv1dKZQ0A0l9WGpCqZkOzT6ohHJcK6YTpjapOD','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664637,15,1),('dhXRBQoWZrp7bwLnLXUqCT8f0GxnsGUngbsHrGxbrvYMGtCT','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664638,16,1),('MPD5Pfx2u5gxtliWggPWnMZbKlKJQK4Jbs08JHdBn1Uy1OQu','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664639,17,1),('yZLOeLDb3KXtLWRRge4R2C0Sgf4nRSh4sbdc6v4MYiOAC7C2','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664640,18,1),('FtvW3L4O1nwq8t8CKbvLPdVpfFJTU7mXE8lfBHg0jkT0gEbW','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664670,19,1),('byyTzkwK7vras0jok3AFPURCBfYOGTbcnmV2rqY1AiOGX8LE','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664671,20,1),('CUyrxZUREIC5M6iS0yS5z1ARnG0x3gH4OZeCsOtBi4xRDeqQ','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664672,21,1),('bg2HYqLMxBzE4iac4U1Cz7tQDn7XlpSeXi0PrKWUSSPv67cW','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664672,22,1),('nKGZpyLwqrT8miPihJmoDfpBPv1XNfrpQabXnqyRCLyy2wsC','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664673,23,1),('OZpUHp1Ms0eBmFrgj9ICLKRZTnNVZLoWmIQXQQUp81hVYFEe','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521664757,24,1),('sfVhpRdptmi2bhGjCeoKcWR5zkc39VuZZeq6rr4NrsPKJlkg','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521667057,25,1),('rryShPOhonuveQMXjKqayhmUiNeWoItctzVk2QlSNJtJEj5A','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521667058,26,1),('G5UgifiQ9fgFGBoxrYjDJl6P75VpImQE2nqw4hgEjTXiV34x','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521667150,27,1),('FRLFSqNEz6l9cIcNCcWWABdgTjsf61gHh8LveJoNsr0zcALV','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521669236,28,1),('ty0aXkuwAJvHpZgEXRVhmwYXh0wgWTdzYkMSjloRqMem7UbC','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521669453,29,1),('hanpDhWTS1I232VkOYlieZX9uRQ6BuqyTGx5zpWsyETT6kqM','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521669454,30,1),('gpNf4iLzCo24aUWxzxX9lo0r4m51J9AOYt2A7RgXjd0bk0iv','TCjfaD0ZWsQMU06rYztBmeO0WENWvl2csMG3mvnW0dBdTdya','https://mpower.cpro.cirg.washington.edu/auth/cprocommon/oauth2callback','email',1521669593,31,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'test@test.com','pbkdf2:sha256:50000$CmkYppMC$04b47298070342d180a7d21edd3994b597ca88ff418bca9219c60220008a24ec',NULL,'2018-03-21 18:45:52','2018-03-21 18:45:52');
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

-- Dump completed on 2018-03-21 16:56:12
