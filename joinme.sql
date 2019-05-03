-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: joinme
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity_images`
--

DROP TABLE IF EXISTS `activity_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_images` (
  `image_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` int(10) unsigned NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `image` longblob NOT NULL,
  `created_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  UNIQUE KEY `image_id_UNIQUE` (`image_id`),
  KEY `activity_images_idx` (`activity_id`),
  CONSTRAINT `activity_images` FOREIGN KEY (`activity_id`) REFERENCES `created_activity_list` (`activity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_images`
--

LOCK TABLES `activity_images` WRITE;
/*!40000 ALTER TABLE `activity_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_message`
--

DROP TABLE IF EXISTS `activity_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_message` (
  `activity_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `message` varchar(45) NOT NULL,
  `created_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` char(2) NOT NULL,
  `reply_user_message_id` int(11) NOT NULL,
  PRIMARY KEY (`activity_message_id`),
  UNIQUE KEY `idactivity_message_id_UNIQUE` (`activity_message_id`),
  KEY `activity_id_idx` (`activity_id`),
  CONSTRAINT `activity_id` FOREIGN KEY (`activity_id`) REFERENCES `created_activity_list` (`activity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_message`
--

LOCK TABLES `activity_message` WRITE;
/*!40000 ALTER TABLE `activity_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_request`
--

DROP TABLE IF EXISTS `activity_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_request` (
  `activity_request_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `requested_activity_name` varchar(100) DEFAULT NULL,
  `created_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` char(2) NOT NULL,
  PRIMARY KEY (`activity_request_id`),
  UNIQUE KEY `activity_request_id_UNIQUE` (`activity_request_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `user_id_activity_request` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_request`
--

LOCK TABLES `activity_request` WRITE;
/*!40000 ALTER TABLE `activity_request` DISABLE KEYS */;
INSERT INTO `activity_request` VALUES (4,62,'garba','2019-02-15 13:29:41','n');
/*!40000 ALTER TABLE `activity_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_status`
--

DROP TABLE IF EXISTS `app_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `app_status` (
  `app_status_id` int(10) unsigned NOT NULL,
  `app_download` int(10) unsigned DEFAULT NULL,
  `web_app_visit` int(10) unsigned DEFAULT NULL,
  `app_visit` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`app_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_status`
--

LOCK TABLES `app_status` WRITE;
/*!40000 ALTER TABLE `app_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `contact` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `friend_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `contact_f_idx` (`user_id`),
  CONSTRAINT `contact_foreign_key` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (11,70,65),(12,70,62),(13,70,72),(14,70,67),(15,70,66),(16,70,63),(17,70,68),(18,70,71),(19,63,67),(20,75,70),(21,79,70),(22,62,76),(23,62,70);
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `created_activity_list`
--

DROP TABLE IF EXISTS `created_activity_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `created_activity_list` (
  `activity_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(45) DEFAULT NULL,
  `activity_description` varchar(300) DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  `tag_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `activity_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cost` int(10) unsigned DEFAULT NULL,
  `lat` varchar(30) DEFAULT NULL,
  `lng` varchar(30) DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`activity_id`),
  UNIQUE KEY `activity_id_UNIQUE` (`activity_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `tag_id_idx` (`tag_id`),
  CONSTRAINT `tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `created_activity_list`
--

LOCK TABLES `created_activity_list` WRITE;
/*!40000 ALTER TABLE `created_activity_list` DISABLE KEYS */;
INSERT INTO `created_activity_list` VALUES (56,'Hackfest Jabalpur','Central India\'s largest Hackathon','a',246,70,'2019-01-12 09:15:00','2019-01-12 12:06:51',0,'23.162148','79.919966',20),(57,'Grand Diwali Mela','Celebrate diwali in grand new style','\0',248,62,'2019-10-27 22:00:00','2019-01-12 18:27:59',2000,'28.599455564417937','77.37464522213747',23),(58,'Holi hai','celebrate holi with celebs','\0',249,76,'2018-03-02 10:00:00','2019-01-12 18:32:11',2500,'19.164606155478296','73.12400152382338',7),(59,'table','the table in good condition','\0',267,62,'2019-03-12 01:00:00','2019-02-14 16:31:56',25000,'23.211803891143102','77.43537376500626',7);
/*!40000 ALTER TABLE `created_activity_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `event` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_name` varchar(45) NOT NULL,
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `event_id_UNIQUE` (`event_id`),
  UNIQUE KEY `event_name_UNIQUE` (`event_name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (21,'Club'),(19,'Competition'),(18,'Devotional'),(10,'Festival Celebration'),(14,'Games'),(9,'Hackathons'),(17,'Jobs'),(20,'Learn Art'),(8,'Live Show'),(11,'Meetups'),(16,'Rent'),(13,'Sell & Buy'),(12,'Studies'),(15,'Tourism');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `notification` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `activity_id` int(10) unsigned NOT NULL,
  `status` varchar(2) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  `created_datetime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  UNIQUE KEY `notification_id_UNIQUE` (`notification_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `activity_id_idx` (`activity_id`),
  CONSTRAINT `activity_id_notification` FOREIGN KEY (`activity_id`) REFERENCES `created_activity_list` (`activity_id`),
  CONSTRAINT `user_id_notification` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (9,70,56,'n','someone selected your activity','2019-01-12 19:56:01'),(10,76,58,'n','someone selected your activity','2019-01-13 03:54:37'),(11,62,57,'r','someone selected your activity','2019-01-31 16:30:26'),(12,62,57,'r','someone selected your activity','2019-01-31 16:33:07'),(13,76,58,'n','someone selected your activity','2019-01-31 16:33:35'),(14,62,59,'r','someone selected your activity','2019-02-14 16:39:50'),(16,70,56,'n','someone selected your activity','2019-02-15 13:27:54');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selected_activity_list`
--

DROP TABLE IF EXISTS `selected_activity_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `selected_activity_list` (
  `selected_activity_list_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `created_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activity_id` int(10) unsigned NOT NULL,
  `status` char(2) NOT NULL DEFAULT 'AA',
  `feedback_message` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`selected_activity_list_id`),
  UNIQUE KEY `idselected_activity_list_id_UNIQUE` (`selected_activity_list_id`),
  KEY `activity_id_idx` (`activity_id`),
  CONSTRAINT `select_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `created_activity_list` (`activity_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selected_activity_list`
--

LOCK TABLES `selected_activity_list` WRITE;
/*!40000 ALTER TABLE `selected_activity_list` DISABLE KEYS */;
INSERT INTO `selected_activity_list` VALUES (60,76,'2019-01-12 19:56:00',56,'AA','its a good hackathon for aspiring entrepreneur'),(61,63,'2019-01-13 03:54:37',58,'AA',''),(63,62,'2019-01-31 16:31:09',57,'AA','ghcvhjvjh'),(64,62,'2019-01-31 16:33:34',58,'AA',''),(65,62,'2019-02-14 16:33:27',59,'AA','i want to buy it'),(67,62,'2019-02-15 13:27:54',56,'AA','');
/*!40000 ALTER TABLE `selected_activity_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tags` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(45) NOT NULL,
  `tag_description` varchar(300) DEFAULT NULL,
  `created_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tag_image` varchar(100) DEFAULT NULL,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `tag_id_UNIQUE` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (54,'music concert ',NULL,'2019-01-11 02:19:03',NULL,8),(55,'Dance show',NULL,'2019-01-11 02:19:03',NULL,8),(56,'Acts ',NULL,'2019-01-11 02:19:03',NULL,8),(57,'Open Mic',NULL,'2019-01-11 02:19:03',NULL,8),(58,'Puppet Show',NULL,'2019-01-11 02:19:03',NULL,8),(244,'College Level',NULL,'2019-01-11 02:58:29',NULL,9),(245,'Job Level',NULL,'2019-01-11 02:58:29',NULL,9),(246,'Code challenge',NULL,'2019-01-11 02:58:29',NULL,9),(247,'StartUps',NULL,'2019-01-11 02:58:29',NULL,9),(248,'Diwali',NULL,'2019-01-11 02:58:29',NULL,10),(249,'Holi',NULL,'2019-01-11 02:58:29',NULL,10),(250,'New Year',NULL,'2019-01-11 02:58:29',NULL,10),(251,'Christmas',NULL,'2019-01-11 02:58:29',NULL,10),(252,'valentine\'s day',NULL,'2019-01-11 02:58:29',NULL,10),(253,'eid',NULL,'2019-01-11 02:58:29',NULL,10),(254,'Reunion',NULL,'2019-01-11 02:58:29',NULL,11),(255,'Dating',NULL,'2019-01-11 02:58:29',NULL,11),(256,'Cultural MeetUps',NULL,'2019-01-11 02:58:29',NULL,11),(257,'Tourist',NULL,'2019-01-11 02:58:29',NULL,11),(258,'Coading',NULL,'2019-01-11 02:58:29',NULL,12),(259,'Math',NULL,'2019-01-11 02:58:29',NULL,12),(260,'Chemistry',NULL,'2019-01-11 02:58:29',NULL,12),(261,'English',NULL,'2019-01-11 02:58:29',NULL,12),(262,'Social Science',NULL,'2019-01-11 02:58:29',NULL,12),(263,'Handwriting',NULL,'2019-01-11 02:58:29',NULL,12),(264,'Geography',NULL,'2019-01-11 02:58:29',NULL,12),(265,'Business ',NULL,'2019-01-11 02:58:29',NULL,12),(266,'IOT',NULL,'2019-01-11 02:58:29',NULL,12),(267,'Sell',NULL,'2019-01-11 02:58:29',NULL,13),(268,'Buy',NULL,'2019-01-11 02:58:29',NULL,13),(269,'Indoor',NULL,'2019-01-11 02:58:29',NULL,14),(270,'Outdoor',NULL,'2019-01-11 02:58:29',NULL,14),(271,'Physical',NULL,'2019-01-11 02:58:29',NULL,14),(272,'Races',NULL,'2019-01-11 02:58:29',NULL,14),(273,'Pubg',NULL,'2019-01-11 02:58:29',NULL,14),(274,'Couchsurfing',NULL,'2019-01-11 02:58:29',NULL,15),(275,'Hitchhiking',NULL,'2019-01-11 02:58:29',NULL,15),(276,'Priority Things For Travel(CHEAP)',NULL,'2019-01-11 02:58:29',NULL,15),(277,'Meetups',NULL,'2019-01-11 02:58:29',NULL,15),(278,'Things TODO',NULL,'2019-01-11 02:58:29',NULL,15),(279,'Room',NULL,'2019-01-11 02:58:29',NULL,16),(280,'Flats',NULL,'2019-01-11 02:58:29',NULL,16),(281,'Vehicle',NULL,'2019-01-11 02:58:29',NULL,16),(282,'Equipment',NULL,'2019-01-11 02:58:29',NULL,16),(283,'Full Time',NULL,'2019-01-11 02:58:29',NULL,17),(284,'Part Time',NULL,'2019-01-11 02:58:29',NULL,17),(285,'Work From Home',NULL,'2019-01-11 02:58:29',NULL,17),(286,'IT',NULL,'2019-01-11 02:58:29',NULL,17),(287,'Managemant',NULL,'2019-01-11 02:58:29',NULL,17),(288,'Special pooja',NULL,'2019-01-11 02:58:29',NULL,18),(289,'Bhajan',NULL,'2019-01-11 02:58:29',NULL,18),(290,'Statsang',NULL,'2019-01-11 02:58:29',NULL,18),(291,'Dance',NULL,'2019-01-11 02:58:29',NULL,19),(292,'Acting',NULL,'2019-01-11 02:58:29',NULL,19),(293,'Cricket',NULL,'2019-01-11 02:58:29',NULL,19),(294,'FootBall',NULL,'2019-01-11 02:58:29',NULL,19),(295,'art and craft',NULL,'2019-01-11 02:58:29',NULL,20),(296,'Singing',NULL,'2019-01-11 02:58:29',NULL,20),(297,'Photography',NULL,'2019-01-11 02:58:29',NULL,21),(298,'Chess',NULL,'2019-01-11 02:58:29',NULL,21),(299,'Gym',NULL,'2019-01-11 02:58:29',NULL,21),(300,'Coading',NULL,'2019-01-11 13:09:59',NULL,19),(301,'Open Mic',NULL,'2019-01-11 13:09:59',NULL,19),(302,'Dance',NULL,'2019-01-11 13:09:59',NULL,20),(303,'Singing',NULL,'2019-01-11 13:09:59',NULL,20),(304,'Photography',NULL,'2019-01-11 13:10:00',NULL,21),(305,'Coading',NULL,'2019-01-11 13:10:00',NULL,21),(306,'Dancing',NULL,'2019-01-12 12:56:47',NULL,21),(307,'Singinh',NULL,'2019-01-12 12:56:48',NULL,21);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `mobile_number` varchar(10) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `about` varchar(45) DEFAULT NULL,
  `created_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password` varchar(45) NOT NULL,
  `rating` int(2) DEFAULT NULL,
  `coins` int(10) DEFAULT NULL,
  `lat` varchar(30) DEFAULT '-15',
  `lng` varchar(30) DEFAULT '80',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  UNIQUE KEY `unique_id_UNIQUE` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (62,'sud','Sudhanshu','Gour',NULL,NULL,'8109049748',NULL,NULL,'2018-10-25 14:25:20','8109049748',NULL,NULL,NULL,NULL),(63,'jatin24','Jatin','Namdev',NULL,NULL,'7047059357',NULL,NULL,'2018-10-25 14:25:20','7047059357',NULL,NULL,NULL,NULL),(64,'lokesh4jg','Lokesh','Sarathe',NULL,NULL,'7774899340',NULL,NULL,'2018-10-25 14:25:20','7748993409',NULL,NULL,NULL,NULL),(65,'sumit','Sumit','Mishra',NULL,NULL,'7049458212',NULL,NULL,'2018-10-25 14:31:05','7049458212',NULL,NULL,NULL,NULL),(66,'akshay','Akshay','Upadhyay',NULL,NULL,'8982405026',NULL,NULL,'2018-10-25 14:31:05','8982405026',NULL,NULL,NULL,NULL),(67,'ajay','Ajay','Singh','2018-10-25',NULL,'9752342810','M','2018-10-25 ','2018-10-25 14:31:05','9752342810',7,NULL,NULL,NULL),(68,'akash','Akash','jain',NULL,NULL,'7987295842',NULL,NULL,'2018-10-25 14:44:27','7987295842',NULL,NULL,NULL,NULL),(69,'akshat','Akshat','Tamrakar',NULL,NULL,'8962303313',NULL,NULL,'2018-10-25 14:44:27','8962303313',NULL,NULL,NULL,NULL),(70,'aman','Aman','Gupta',NULL,NULL,'9754810898',NULL,NULL,'2018-10-25 14:44:27','9754810898',NULL,NULL,'-15','80'),(71,'geetu','Geetesh','Namdev',NULL,NULL,'8839835430',NULL,NULL,'2018-10-25 14:44:27','8839835430',NULL,NULL,NULL,NULL),(72,'8888888888','lok','lok',NULL,NULL,'8888888888','\0',NULL,'2018-10-26 21:10:36','8888888888',0,0,NULL,NULL),(73,'9999999999','sssss','sssss',NULL,NULL,'9999999999','\0',NULL,'2018-10-26 21:20:12','9999999999',0,0,NULL,NULL),(74,'9911221122','vijit','wedigt',NULL,NULL,'9911221122','\0',NULL,'2018-10-29 18:09:11','9911221122',0,0,NULL,NULL),(75,'jgvkjgk','Rajesh','Rai',NULL,NULL,'1234543216','\0',NULL,'2018-10-29 18:26:34','9993166917',0,0,NULL,NULL),(76,'lokesh','Lokesh','Sarathe',NULL,NULL,'7748993409','\0',NULL,'2018-10-29 18:45:00','qwerty4321',0,0,NULL,NULL),(77,'rajesh@gmail.com','Rajesh','Rai',NULL,NULL,'9993166917','\0',NULL,'2018-10-29 19:34:41','@0126it96#',0,0,NULL,NULL),(78,'safdar','safdar','khan',NULL,NULL,'9300480696','\0',NULL,'2018-10-30 11:11:21','123456789',0,0,NULL,NULL),(79,'mishra3452','Sumit','Mishra',NULL,NULL,'8770341360','\0',NULL,'2018-10-30 14:48:11','asdfghhbvvc@1',0,0,NULL,NULL),(80,'rahul','rahul','kumar',NULL,NULL,'9589668780','\0',NULL,'2018-12-10 19:39:58','9589668780Rahul@123',0,0,NULL,NULL),(81,'8888888887','sud','sud',NULL,NULL,'8888888887','\0',NULL,'2019-01-01 19:29:45','8888888887',0,0,NULL,NULL),(82,'swati_','swati','gour',NULL,NULL,'8871016454','\0',NULL,'2019-01-01 19:31:53','887101645',0,0,NULL,NULL),(83,'sanjeet','Sanjeet','Anand',NULL,NULL,'8319395305','\0',NULL,'2019-01-09 13:40:59','8319395305',0,0,NULL,NULL),(84,'anand','anand','sajeet',NULL,NULL,'8987045110','\0',NULL,'2019-01-09 13:44:13','8987045110',0,0,NULL,NULL),(85,'riyabg','riya','george',NULL,NULL,'8989160267','\0',NULL,'2019-02-12 16:36:07','riya123456',0,0,NULL,NULL),(86,'roopal','roopal','buwade',NULL,NULL,'8517099913','\0',NULL,'2019-02-15 12:57:57','roopal123',0,0,NULL,NULL),(87,'rashmi','rashmi','dubey',NULL,NULL,'9584035516','\0',NULL,'2019-02-15 14:54:19','rashmi1234',0,0,NULL,NULL),(88,'ozas','ozas','sahu',NULL,NULL,'8989238560','\0',NULL,'2019-03-04 14:03:19','12345678',0,0,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_message`
--

DROP TABLE IF EXISTS `user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_message` (
  `user_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) unsigned NOT NULL,
  `reciever_id` int(10) unsigned NOT NULL,
  `message` varchar(45) NOT NULL,
  `created_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` char(2) NOT NULL,
  PRIMARY KEY (`user_message_id`),
  UNIQUE KEY `idactivity_message_id_UNIQUE` (`user_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_message`
--

LOCK TABLES `user_message` WRITE;
/*!40000 ALTER TABLE `user_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_message` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-06 19:34:54
