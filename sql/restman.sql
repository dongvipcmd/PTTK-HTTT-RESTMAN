-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: restman
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbldish`
--

DROP TABLE IF EXISTS `tbldish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldish` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldish`
--

LOCK TABLES `tbldish` WRITE;
/*!40000 ALTER TABLE `tbldish` DISABLE KEYS */;
INSERT INTO `tbldish` VALUES (1,'Phở bò',50000,'Món ăn truyền thống chế biến từ các nguyên liệu tươi ngon gồm 200g bánh phở, 100g thịt bò, 300g xương bò, 30g hành tây, 10g hành lá, 15g rau thơm, 10g gừng, quế, hồi, thảo quả cùng các gia vị như muối, nước mắm và đường phèn. Xương bò được hầm trong 4–6 giờ để tạo nước dùng ngọt thanh.','pho-bo.jpg'),(2,'Bún chả',45000,'Bún chả Hà Nội, thịt nướng than hoa','bun-cha2.jpg'),(3,'Gỏi cuốn',30000,'Gỏi cuốn tôm thịt, chấm tương đặc biệt','goi-cuon.jpg'),(4,'Cơm rang dưa bò',55000,'Cơm rang dưa cải với thịt bò xào','com-rang.jpg'),(5,'Steak',150000,'Steak (thịt bò bít tết) là một món ăn cao cấp, tinh tế và đầy quyến rũ trong ẩm thực phương Tây, được làm từ một miếng thịt cắt lát dày, chủ yếu là thịt bò, sau đó được nướng hoặc áp chảo dưới nhiệt độ cao.','steak.jpg'),(6,'Bún chả',55000,'Bún chả Hà Nội','bun-cha.jpg'),(7,'Bún bò Huế',55000,'Bún bò thơm ngon ...','bun-bo.jpg');
/*!40000 ALTER TABLE `tbldish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblimportreceipt`
--

DROP TABLE IF EXISTS `tblimportreceipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblimportreceipt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `importDate` date DEFAULT NULL,
  `totalPrice` double DEFAULT NULL,
  `tblWareHouseStafftblStafftblMemberid` int NOT NULL,
  `Supplierid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tblWareHouseStafftblStafftblMemberid` (`tblWareHouseStafftblStafftblMemberid`),
  KEY `Supplierid` (`Supplierid`),
  CONSTRAINT `tblimportreceipt_ibfk_1` FOREIGN KEY (`tblWareHouseStafftblStafftblMemberid`) REFERENCES `tblwarehousestaff` (`tblStafftblMemberid`),
  CONSTRAINT `tblimportreceipt_ibfk_2` FOREIGN KEY (`Supplierid`) REFERENCES `tblsupplier` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblimportreceipt`
--

LOCK TABLES `tblimportreceipt` WRITE;
/*!40000 ALTER TABLE `tblimportreceipt` DISABLE KEYS */;
INSERT INTO `tblimportreceipt` VALUES (6,'2026-10-01',1500000,1,4),(7,'2026-10-05',2300000,1,4),(8,'2026-10-10',1800000,1,4),(9,'2026-10-15',3200000,1,4),(10,'2026-10-20',2750000,1,4),(11,'2026-11-07',6100000,1,4),(12,'2026-11-07',1600000,1,4),(13,'2026-11-07',150000,1,4),(14,'2026-11-07',3600000,1,4),(15,'2026-11-07',2100000,1,4),(16,'2026-11-07',250000,1,4),(17,'2026-11-07',12000000,1,4),(18,'2026-11-10',9300000,1,4),(19,'2026-11-10',3700000,1,4),(20,'2026-11-10',150000,1,4),(21,'2026-11-10',1200000,1,4),(22,'2026-11-10',50000,1,4),(23,'2026-11-10',1200000,1,4),(24,'2026-11-10',1200000,1,4),(25,'2026-11-10',1400000,1,8),(26,'2026-11-10',13000000,1,9),(27,'2026-11-11',8000000,1,10),(28,'2026-11-11',1200000,1,4),(29,'2026-11-11',800000,1,8),(30,'2026-11-12',10500000,1,9);
/*!40000 ALTER TABLE `tblimportreceipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblimportreceiptdetail`
--

DROP TABLE IF EXISTS `tblimportreceiptdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblimportreceiptdetail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `tblImportReceiptid` int NOT NULL,
  `tblIngredientid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tblImportReceiptid` (`tblImportReceiptid`),
  KEY `tblIngredientid` (`tblIngredientid`),
  CONSTRAINT `tblimportreceiptdetail_ibfk_1` FOREIGN KEY (`tblImportReceiptid`) REFERENCES `tblimportreceipt` (`id`),
  CONSTRAINT `tblimportreceiptdetail_ibfk_2` FOREIGN KEY (`tblIngredientid`) REFERENCES `tblingredient` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblimportreceiptdetail`
--

LOCK TABLES `tblimportreceiptdetail` WRITE;
/*!40000 ALTER TABLE `tblimportreceiptdetail` DISABLE KEYS */;
INSERT INTO `tblimportreceiptdetail` VALUES (1,10,50000,6,1),(2,20,30000,6,2),(3,15,45000,6,3),(4,8,60000,6,4),(5,12,25000,6,8),(6,10,250000,11,1),(7,20,180000,11,4),(8,12.5,120000,12,8),(9,20,5000,12,3),(10,10,15000,13,2),(11,20,180000,14,4),(12,15,120000,15,8),(13,20,15000,15,2),(14,20,5000,16,3),(15,10,15000,16,2),(16,100,120000,17,8),(17,20,250000,18,1),(18,10,120000,18,8),(19,15,180000,18,4),(20,20,15000,18,2),(21,20,5000,18,3),(22,10,250000,19,1),(23,10,120000,19,8),(24,10,15000,20,2),(25,10,120000,21,8),(26,10,5000,22,3),(27,10,120000,23,8),(28,10,120000,24,8),(29,20,40000,25,9),(30,20,30000,25,10),(31,20,300000,26,11),(32,20,350000,26,12),(33,15,200000,27,13),(34,20,250000,27,14),(35,10,120000,28,15),(36,20,40000,29,9),(37,30,350000,30,12);
/*!40000 ALTER TABLE `tblimportreceiptdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblingredient`
--

DROP TABLE IF EXISTS `tblingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblingredient` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `massUnits` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double NOT NULL DEFAULT '0',
  `quantity` double DEFAULT '0',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblingredient`
--

LOCK TABLES `tblingredient` WRITE;
/*!40000 ALTER TABLE `tblingredient` DISABLE KEYS */;
INSERT INTO `tblingredient` VALUES (1,'Thịt bò','kg',250000,40,NULL),(2,'Bún tươi','kg',15000,70,NULL),(3,'Hành lá','bó',5000,70,NULL),(4,'Tôm','kg',180000,55,NULL),(5,'Thịt bò','kg',0,0,'Thịt bò tươi mới, không được để lâu'),(6,'Thịt bò','kg',0,0,'Thịt bò tươi mới, không được để lâu'),(7,'Thịt bò','kg',0,0,'Thịt bò tươi mới, không được để lâu'),(8,'Thịt lợn','kg',120000,177.5,'note'),(9,'Sữa bò','lít',40000,40,'sữa tươi nguyên chất chưa tiệt trùng'),(10,'Sữa dê','lít',30000,20,'Sữa dê tươi mới sản xuất trong ngày, đã tiệt trùng'),(11,'Lon Bia Hà Nội','Thùng',300000,20,'1 lớn thùng 24 lon bia'),(12,'Chai Bia Hà Nội','Két',350000,50,'1 két 24 chia thủy tinh'),(13,'Pepsi Lon','Thùng',200000,15,'1 thùng có 20 lon'),(14,'Cocacola vị chanh không calo','Thùng',250000,20,'1 thùng 20 lon'),(15,'Thịt ba chỉ lợn','kg',120000,10,'Thịt lợn ba chỉ ít mỡ nhiều thịt');
/*!40000 ALTER TABLE `tblingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmember`
--

DROP TABLE IF EXISTS `tblmember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmember` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` int DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phoneNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmember`
--

LOCK TABLES `tblmember` WRITE;
/*!40000 ALTER TABLE `tblmember` DISABLE KEYS */;
INSERT INTO `tblmember` VALUES (1,'kho1','123','Nguyễn Văn Kho',20040115,'Hà Đông, Hà nội','khonv@gmail.com','0987654321');
/*!40000 ALTER TABLE `tblmember` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblstaff`
--

DROP TABLE IF EXISTS `tblstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblstaff` (
  `tblMemberid` int NOT NULL,
  `staffId` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`tblMemberid`),
  UNIQUE KEY `staffId` (`staffId`),
  CONSTRAINT `tblstaff_ibfk_1` FOREIGN KEY (`tblMemberid`) REFERENCES `tblmember` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblstaff`
--

LOCK TABLES `tblstaff` WRITE;
/*!40000 ALTER TABLE `tblstaff` DISABLE KEYS */;
INSERT INTO `tblstaff` VALUES (1,'NV01','WAREHOUSE');
/*!40000 ALTER TABLE `tblstaff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsupplier`
--

DROP TABLE IF EXISTS `tblsupplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsupplier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phoneNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsupplier`
--

LOCK TABLES `tblsupplier` WRITE;
/*!40000 ALTER TABLE `tblsupplier` DISABLE KEYS */;
INSERT INTO `tblsupplier` VALUES (1,'Công ty Thực phẩm A','Hà Nội','0901234567',''),(2,'Nông trại Xanh','Hưng Yên','0907654321',''),(3,'Công ty Thực phẩm Sạch Hà Nội','12 Nguyễn Trãi, Thanh Xuân, Hà Nội','0912345678','Cung cấp rau củ quả'),(4,'Công ty TNHH Thịt Việt','45 Giải Phóng, Hai Bà Trưng, Hà Nội','0923456789','Cung cấp thịt bò, thịt lợn, thịt gà'),(5,'Hải sản Biển Đông','88 Lê Lợi, Hải Phòng','0934567890','Cung cấp tôm, cá, mực tươi'),(6,'Cơ sở Gia vị Hương Việt','23 Hàng Buồm, Hoàn Kiếm, Hà Nội','0945678901','Cung cấp gia vị, nước mắm, dầu ăn'),(7,'Nhà máy Bún Phở Tân Mai','9 Tân Mai, Hoàng Mai, Hà Nội','0956789012','Cung cấp bún, phở, bánh đa'),(8,'Công ty Sữa nhập khẩu','123 Cầu Giấy, Hà Nội','0982222765','Cung cấp sữa, bơ tươi từ động vật (dê, bò)'),(9,'Công ty Bia Hà Nội','123 Khu Công nghiệp, Ninh Bình','0936363636','Chuyên bia Hà Nội'),(10,'Đại Lý đồ uống có ga','22 Thanh Xuân, Nguyễn Trãi, Hà Nội','0111111111','Chuyên cung cấp nước ngọt');
/*!40000 ALTER TABLE `tblsupplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblwarehousestaff`
--

DROP TABLE IF EXISTS `tblwarehousestaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblwarehousestaff` (
  `tblStafftblMemberid` int NOT NULL,
  PRIMARY KEY (`tblStafftblMemberid`),
  CONSTRAINT `tblwarehousestaff_ibfk_1` FOREIGN KEY (`tblStafftblMemberid`) REFERENCES `tblstaff` (`tblMemberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblwarehousestaff`
--

LOCK TABLES `tblwarehousestaff` WRITE;
/*!40000 ALTER TABLE `tblwarehousestaff` DISABLE KEYS */;
INSERT INTO `tblwarehousestaff` VALUES (1);
/*!40000 ALTER TABLE `tblwarehousestaff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-12  9:59:42
