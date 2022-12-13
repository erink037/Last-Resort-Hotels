/*
(64 bit)
MySQL - 5.5.5-10.4.6-LR-Hotels-DB : Database - hotel_db
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hotel_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `hotel_db`;

/*Table structure for table `bed` */

DROP TABLE IF EXISTS `bed`;

CREATE TABLE `bed` (
  `bedtypeId` int(11) NOT NULL,
  `bedtype` varchar(50) DEFAULT NULL,
  `bedcount` int(11) DEFAULT NULL,
  PRIMARY KEY (`bedtypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `bed` */

/*Table structure for table `billing` */

DROP TABLE IF EXISTS `billing`;

CREATE TABLE `billing` (
  `billingId` int(11) NOT NULL,
  `discountTypeId` int(11) DEFAULT NULL,
  `guestId` int(11) DEFAULT NULL,
  `partyOf` varchar(20) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `billingDescription` varchar(255) DEFAULT NULL,
  `billStatusId` int(11) DEFAULT NULL,
  PRIMARY KEY (`billingId`),
  KEY `billStatusId` (`billStatusId`),
  KEY `discountTypeId` (`discountTypeId`),
  KEY `guestId` (`guestId`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`billStatusId`) REFERENCES `billing_process` (`billStatusId`),
  CONSTRAINT `billing_ibfk_2` FOREIGN KEY (`discountTypeId`) REFERENCES `discount` (`discountTypeId`),
  CONSTRAINT `billing_ibfk_3` FOREIGN KEY (`guestId`) REFERENCES `guest_information` (`guestId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `billing` */

/*Table structure for table `billing_process` */

DROP TABLE IF EXISTS `billing_process`;

CREATE TABLE `billing_process` (
  `billStatusId` int(11) NOT NULL,
  `billStatus` varchar(20) DEFAULT NULL,
  `billingPaymentType` varchar(20) DEFAULT NULL,
  `deposit` double(12,4) DEFAULT NULL,
  `paymentMilestone` varchar(50) DEFAULT NULL,
  `paymentStartDate` date DEFAULT NULL,
  `paymentDueDate` date DEFAULT NULL,
  `paymentdueDescription` varchar(255) DEFAULT NULL,
  `amountRequired` double(12,4) DEFAULT NULL,
  PRIMARY KEY (`billStatusId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `billing_process` */

/*Table structure for table `building` */

DROP TABLE IF EXISTS `building`;

CREATE TABLE `building` (
  `buildingId` int(11) NOT NULL,
  `buildingname` varchar(20) DEFAULT NULL,
  `floorCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`buildingId`),
  CONSTRAINT `building_ibfk_1` FOREIGN KEY (`buildingId`) REFERENCES `hotel` (`hotelId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `building` */

/*Table structure for table `cardpin` */

DROP TABLE IF EXISTS `cardpin`;

CREATE TABLE `cardpin` (
  `pinNumber` varchar(20) NOT NULL,
  `activityStatus` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pinNumber`),
  CONSTRAINT `cardpin_ibfk_1` FOREIGN KEY (`pinNumber`) REFERENCES `guest_access` (`Pin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cardpin` */

/*Table structure for table `discount` */

DROP TABLE IF EXISTS `discount`;

CREATE TABLE `discount` (
  `discountTypeId` int(11) NOT NULL,
  `discountType` varchar(20) DEFAULT NULL,
  `discountAmount` double(12,4) DEFAULT NULL,
  PRIMARY KEY (`discountTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `discount` */

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `employeeId` int(11) NOT NULL,
  `employeeName` varchar(20) DEFAULT NULL,
  `employeeRole` varchar(20) DEFAULT NULL,
  `staffId` int(11) DEFAULT NULL,
  `shift` varchar(20) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  PRIMARY KEY (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `employee` */

/*Table structure for table `event` */

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `eventId` int(11) NOT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `reservationId` int(11) DEFAULT NULL,
  `hostId` int(11) DEFAULT NULL,
  PRIMARY KEY (`eventId`),
  KEY `hostId` (`hostId`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`hostId`) REFERENCES `host` (`hostId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `event` */

/*Table structure for table `facility` */

DROP TABLE IF EXISTS `facility`;

CREATE TABLE `facility` (
  `facilityId` int(11) NOT NULL,
  `facilityName` varchar(50) DEFAULT NULL,
  `facilityStatus` varchar(20) DEFAULT NULL,
  `facilityDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`facilityId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `facility` */

/*Table structure for table `floor` */

DROP TABLE IF EXISTS `floor`;

CREATE TABLE `floor` (
  `floorId` int(11) NOT NULL,
  `wingid` int(11) DEFAULT NULL,
  `buildingId` int(11) DEFAULT NULL,
  PRIMARY KEY (`floorId`),
  KEY `buildingId` (`buildingId`),
  CONSTRAINT `floor_ibfk_1` FOREIGN KEY (`buildingId`) REFERENCES `building` (`buildingId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `floor` */

/*Table structure for table `guest` */

DROP TABLE IF EXISTS `guest`;

CREATE TABLE `guest` (
  `guestId` int(11) DEFAULT NULL,
  `guestName` varchar(20) DEFAULT NULL,
  `guestServices` varchar(50) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  `pin` varchar(20) DEFAULT NULL,
  `guestTypeId` int(11) DEFAULT NULL,
  KEY `roomId` (`roomId`),
  KEY `guestTypeId` (`guestTypeId`),
  KEY `guestId` (`guestId`),
  KEY `pin` (`pin`),
  CONSTRAINT `guest_ibfk_1` FOREIGN KEY (`roomId`) REFERENCES `room` (`roomId`),
  CONSTRAINT `guest_ibfk_2` FOREIGN KEY (`guestTypeId`) REFERENCES `guest_type` (`guestTypeId`),
  CONSTRAINT `guest_ibfk_3` FOREIGN KEY (`guestId`) REFERENCES `guest_information` (`guestId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `guest` */

/*Table structure for table `guest_access` */

DROP TABLE IF EXISTS `guest_access`;

CREATE TABLE `guest_access` (
  `accessGranted` varchar(50) DEFAULT NULL,
  `accessInvalid` varchar(20) DEFAULT NULL,
  `Pin` varchar(20) NOT NULL,
  PRIMARY KEY (`Pin`),
  CONSTRAINT `guest_access_ibfk_1` FOREIGN KEY (`Pin`) REFERENCES `guest` (`pin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `guest_access` */

/*Table structure for table `guest_information` */

DROP TABLE IF EXISTS `guest_information`;

CREATE TABLE `guest_information` (
  `guestId` int(11) NOT NULL,
  `guestName` varchar(20) DEFAULT NULL,
  `telephone` varchar(13) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `guestRating` char(5) DEFAULT NULL,
  `guestRewardsPoints` varchar(50) DEFAULT NULL,
  `lastContactDateToGuest` date DEFAULT NULL,
  `lastContactTimeToGuest` time DEFAULT NULL,
  `guestContactAvailabilityHours` varchar(20) DEFAULT NULL,
  `guestContactRequest` varchar(20) DEFAULT NULL,
  `hostId` int(11) DEFAULT NULL,
  PRIMARY KEY (`guestId`),
  KEY `hostId` (`hostId`),
  CONSTRAINT `guest_information_ibfk_1` FOREIGN KEY (`hostId`) REFERENCES `host` (`hostId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `guest_information` */

/*Table structure for table `guest_type` */

DROP TABLE IF EXISTS `guest_type`;

CREATE TABLE `guest_type` (
  `guestTypeId` int(11) NOT NULL,
  `guestTypeDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`guestTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `guest_type` */

/*Table structure for table `host` */

DROP TABLE IF EXISTS `host`;

CREATE TABLE `host` (
  `hostId` int(11) NOT NULL,
  `hostname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`hostId`),
  KEY `guestId` (`hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `host` */

/*Table structure for table `hotel` */

DROP TABLE IF EXISTS `hotel`;

CREATE TABLE `hotel` (
  `hotelId` int(11) NOT NULL,
  `buildingId` int(11) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `buildingCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`hotelId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `hotel` */

/*Table structure for table `house_keeping` */

DROP TABLE IF EXISTS `house_keeping`;

CREATE TABLE `house_keeping` (
  `cleaningStatus` varchar(20) NOT NULL,
  `employeeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`cleaningStatus`),
  KEY `employeeId` (`employeeId`),
  CONSTRAINT `house_keeping_ibfk_1` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `house_keeping` */

/*Table structure for table `reservation` */

DROP TABLE IF EXISTS `reservation`;

CREATE TABLE `reservation` (
  `reservationId` int(11) NOT NULL,
  `reservationType` varchar(20) DEFAULT NULL,
  `reservationDescription` varchar(20) DEFAULT NULL,
  `dateReservered` varchar(50) DEFAULT NULL,
  `typeOfUsage` varchar(20) DEFAULT NULL,
  `hostId` int(11) DEFAULT NULL,
  PRIMARY KEY (`reservationId`),
  KEY `typeOfUsage` (`typeOfUsage`),
  KEY `hostId` (`hostId`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`typeOfUsage`) REFERENCES `usage_time` (`typeOfUsage`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`hostId`) REFERENCES `host` (`hostId`),
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`reservationId`) REFERENCES `event` (`eventId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reservation` */

/*Table structure for table `room` */

DROP TABLE IF EXISTS `room`;

CREATE TABLE `room` (
  `roomId` int(11) NOT NULL,
  `roomTypeId` int(11) DEFAULT NULL,
  `partyOf` varchar(20) DEFAULT NULL,
  `capacity` varchar(50) DEFAULT NULL,
  `roomDescription` varchar(255) DEFAULT NULL,
  `smokingStatus` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`roomId`),
  KEY `roomTypeId` (`roomTypeId`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`roomTypeId`) REFERENCES `room_type` (`roomTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `room` */

/*Table structure for table `room_layout` */

DROP TABLE IF EXISTS `room_layout`;

CREATE TABLE `room_layout` (
  `roomFlexibilityId` int(11) NOT NULL,
  `roomFlexibilityName` varchar(50) DEFAULT NULL,
  `facilityId` int(11) DEFAULT NULL,
  `currentRoomUse` varchar(50) DEFAULT NULL,
  `connection` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`roomFlexibilityId`),
  KEY `facilityId` (`facilityId`),
  CONSTRAINT `room_layout_ibfk_1` FOREIGN KEY (`facilityId`) REFERENCES `facility` (`facilityId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `room_layout` */

/*Table structure for table `room_status` */

DROP TABLE IF EXISTS `room_status`;

CREATE TABLE `room_status` (
  `roomAvailability` int(11) NOT NULL,
  `StatusType` int(11) DEFAULT NULL,
  `cleaningStatus` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`roomAvailability`),
  KEY `cleaningStatus` (`cleaningStatus`),
  CONSTRAINT `room_status_ibfk_1` FOREIGN KEY (`cleaningStatus`) REFERENCES `house_keeping` (`cleaningStatus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `room_status` */

/*Table structure for table `room_type` */

DROP TABLE IF EXISTS `room_type`;

CREATE TABLE `room_type` (
  `roomTypeId` int(11) NOT NULL,
  `roomTypeName` varchar(50) DEFAULT NULL,
  `appliances` varchar(20) DEFAULT NULL,
  `roomFunctionId` int(11) DEFAULT NULL,
  `appliancesStatus` varchar(20) DEFAULT NULL,
  `numberOfguest` int(11) DEFAULT NULL,
  `roomSize` varchar(20) DEFAULT NULL,
  `proximities` varchar(50) DEFAULT NULL,
  `roomAvailability` int(11) DEFAULT NULL,
  `bedTypeId` int(11) DEFAULT NULL,
  `floorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`roomTypeId`),
  KEY `roomAvailability` (`roomAvailability`),
  KEY `bedTypeId` (`bedTypeId`),
  KEY `floorId` (`floorId`),
  CONSTRAINT `room_type_ibfk_1` FOREIGN KEY (`roomAvailability`) REFERENCES `room_status` (`roomAvailability`),
  CONSTRAINT `room_type_ibfk_2` FOREIGN KEY (`bedTypeId`) REFERENCES `bed` (`bedtypeId`),
  CONSTRAINT `room_type_ibfk_3` FOREIGN KEY (`floorId`) REFERENCES `floor` (`floorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `room_type` */

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `staffId` int(11) NOT NULL,
  `staffRole` varchar(20) DEFAULT NULL,
  `floorId` int(11) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `value` varchar(20) DEFAULT NULL,
  `roomsAssigned` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`staffId`),
  KEY `floorId` (`floorId`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`staffId`) REFERENCES `employee` (`employeeId`),
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`floorId`) REFERENCES `floor` (`floorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `staff` */

/*Table structure for table `usage_time` */

DROP TABLE IF EXISTS `usage_time`;

CREATE TABLE `usage_time` (
  `typeOfUsage` varchar(20) NOT NULL,
  `timeOfDay` time DEFAULT NULL,
  `NumberOfUsage` int(11) DEFAULT NULL,
  PRIMARY KEY (`typeOfUsage`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `usage_time` */

/*Table structure for table `wing` */

DROP TABLE IF EXISTS `wing`;

CREATE TABLE `wing` (
  `wingId` int(11) NOT NULL,
  `parkingfloor` varchar(20) DEFAULT NULL,
  `poolStatus` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`wingId`),
  CONSTRAINT `wing_ibfk_1` FOREIGN KEY (`wingId`) REFERENCES `floor` (`floorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wing` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
