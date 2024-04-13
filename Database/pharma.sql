-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 22, 2019 at 07:40 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pharma`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllEmployees`()
BEGIN
    SELECT 
        `empID` AS ID,
        `UserName`,
        `empName` AS Name,
        `empRole` AS Role,
        `empContactNo` AS Contact_Number,
        `empCNIC` AS CNIC,
        `empSex` AS Gender,
        `empBirthDate` AS Birth_Date,
        `empSalary` AS Salary
    FROM 
        `employee`;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `employeeID` INT(11) NOT NULL,
  `status` ENUM('Absent','Present','Leave') NOT NULL,
  `attendDate` DATE NOT NULL,
  `timeIN` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timeOut` TIMESTAMP NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `empID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(20) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `empName` VARCHAR(50) NOT NULL,
  `empCNIC` BIGINT(15) NOT NULL,
  `empContactNo` BIGINT(15) UNSIGNED NOT NULL,
  `empSex` VARCHAR(7) NOT NULL,
  `empSalary` DECIMAL(10,2) NOT NULL,
  `empBirthDate` DATE NOT NULL,
  `empRole` VARCHAR(20) NOT NULL,
  `pharmacyID` INT(11) DEFAULT 1,
  PRIMARY KEY (`empID`),
  UNIQUE KEY `empContactNo` (`empContactNo`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`pharmacyID`) REFERENCES `pharmacy` (`pharmacyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`UserName`, `password`, `empName`, `empCNIC`, `empContactNo`, `empSex`, `empSalary`, `empBirthDate`, `empRole`, `pharmacyID`) 
VALUES ('abc', '$2y$10$qVQzDxpZyUJyWmZodGZoZOv8ZfKNj4zXQ4V4zh4zh4zh4zh4zh4zX', 'Asim', 25823, 2453256436, 'Male', 34353.00, '2019-05-01', 'Admin', 1);

-- --------------------------------------------------------

--
-- Table structure for table `medcompany`
--

CREATE TABLE `medcompany` (
  `compID` INT(11) NOT NULL AUTO_INCREMENT,
  `compName` VARCHAR(50) NOT NULL,
  `compContact` BIGINT(15) DEFAULT NULL,
  PRIMARY KEY (`compID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medcompany`
--

INSERT INTO `medcompany` (`compName`, `compContact`) 
VALUES ('hello', 3320443303);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` INT(10) NOT NULL AUTO_INCREMENT,
  `InVoiceDate` DATE NOT NULL,
  `order_type` VARCHAR(20) NOT NULL,
  `creditReturnDate` DATE DEFAULT NULL,
  `order_total_amount` DECIMAL(10,2) NOT NULL,
  `batch` VARCHAR(20) DEFAULT NULL,
  `supID` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`supID`) REFERENCES `supplier` (`supplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy`
--

CREATE TABLE `pharmacy` (
  `pharmacyID` INT(11) NOT NULL AUTO_INCREMENT,
  `pharmacyName` VARCHAR(50) NOT NULL,
  `pharmaAddress` VARCHAR(100) NOT NULL,
  `pharmaContactNo` BIGINT(15) NOT NULL,
  PRIMARY KEY (`pharmacyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`pharmacyName`, `pharmaAddress`, `pharmaContactNo`) 
VALUES ('Itthad Medical Store', 'cwec3rf3', 243234);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productID` INT(11) NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(100) NOT NULL,
  `productType` INT(11) DEFAULT NULL,
  `batch_id` VARCHAR(20) DEFAULT NULL,
  `productExpiryDate` DATE DEFAULT NULL,
  `quantityPerPack` INT(11) NOT NULL,
  `minLevel` INT(6) UNSIGNED DEFAULT NULL,
  `compID` INT(11) NOT NULL,
  `supplierID` INT(11) NOT NULL,
  `buyingPrice` DECIMAL(10,2) NOT NULL,
  `sellingPrice` DECIMAL(10,2) NOT NULL,
  `oldPrice` DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (`productID`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`compID`) REFERENCES `medcompany` (`compID`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productName`, `productType`, `batch_id`, `productExpiryDate`, `quantityPerPack`, `minLevel`, `compID`, `supplierID`, `buyingPrice`, `sellingPrice`) 
VALUES ('panadol', NULL, 'e34', NULL, 12, 3, 1, 1, 10.00, 11.50);

-- --------------------------------------------------------

--
-- Table structure for table `purchaseinvoice`
--

CREATE TABLE `purchaseinvoice` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(100) NOT NULL,
  `batchNo` VARCHAR(20) DEFAULT NULL,
  `expiryDate` DATE DEFAULT NULL,
  `buyingPrice` DECIMAL(10,2) NOT NULL,
  `retailPrice` DECIMAL(10,2) NOT NULL,
  `totalQty` INT(11) NOT NULL,
  `minLevel` INT(11) DEFAULT NULL,
  `netAmount` DECIMAL(10,2) NOT NULL,
  `margin` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchaseinvoice`
--

INSERT INTO `purchaseinvoice` (`productName`, `batchNo`, `expiryDate`, `buyingPrice`, `retailPrice`, `totalQty`, `minLevel`, `netAmount`, `margin`) 
VALUES
('panadol', '123e', '2019-05-16', 34.00, 38.08, 7, 6, 102.00, 12.00),
('panerrtr', '3456', '2019-05-31', 3.00, 36.80, 7, 2, 96.00, 12.30),
('wuefh', '42', '2019-06-05', 34.35, 52.55, 38, 20, 1202.08, 53.00);

-- --------------------------------------------------------

--
-- Table structure for table `saleinvoice`
--

CREATE TABLE `saleinvoice` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `totalProducts` INT(11) NOT NULL,
  `reference` VARCHAR(50) NOT NULL,
  `totalPrice` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplierID` INT(11) NOT NULL AUTO_INCREMENT,
  `supplierName` VARCHAR(50) NOT NULL,
  `supplierContactNo` BIGINT(15) NOT NULL,
  `expiryDayPolicy` INT(10) UNSIGNED NOT NULL,
  `supplierCompID` INT(11) NOT NULL,
  PRIMARY KEY (`supplierID`),
  CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`supplierCompID`) REFERENCES `suppliercompany` (`compID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplierName`, `supplierContactNo`, `expiryDayPolicy`, `supplierCompID`) 
VALUES
('ere', 24, 2, 1),
('ffew', 535, 60, 1);

-- --------------------------------------------------------

--
-- Table structure for table `suppliercompany`
--

CREATE TABLE `suppliercompany` (
  `compID` INT(11) NOT NULL AUTO_INCREMENT,
  `compName` VARCHAR(50) NOT NULL,
  `compContact` BIGINT(15) DEFAULT NULL,
  `compAddress` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`compID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suppliercompany`
--

INSERT INTO `suppliercompany` (`compName`, `compContact`, `compAddress`) 
VALUES
('gsk', 1434243, 'fshdtew34'),
('echo', 253, 'fdffl;6');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
