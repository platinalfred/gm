-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2017 at 11:10 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.5.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gmt`
--

-- --------------------------------------------------------

--
-- Table structure for table `accesslevel`
--

CREATE TABLE `accesslevel` (
  `id` int(11) NOT NULL,
  `name` varchar(156) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accesslevel`
--

INSERT INTO `accesslevel` (`id`, `name`, `description`) VALUES
(1, 'Administrator', 'Will have over all rights usage of the system'),
(2, 'Field Officer', 'Collects data from the field'),
(3, 'Management Staff', 'Management staff');

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` int(11) NOT NULL,
  `expenseType` tinyint(4) NOT NULL,
  `amountUsed` decimal(15,2) NOT NULL,
  `amountDescription` text NOT NULL,
  `createdBy` int(11) NOT NULL COMMENT 'ID of staff who added the record',
  `expenseDate` int(11) NOT NULL COMMENT 'Timestamp for when this record was added',
  `dateModified` int(11) NOT NULL COMMENT 'Timestamp for when this record was added',
  `modifiedBy` int(11) NOT NULL COMMENT 'Staff who modified the record'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `expensetypes`
--

CREATE TABLE `expensetypes` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `expensetypes`
--

INSERT INTO `expensetypes` (`id`, `name`, `description`, `active`) VALUES
(1, 'Air Time', 'Air time description', 1);

-- --------------------------------------------------------

--
-- Table structure for table `land_access`
--

CREATE TABLE `land_access` (
  `pap_id` int(11) NOT NULL,
  `plot_ref` varchar(100) NOT NULL,
  `land_tenure` int(11) NOT NULL,
  `right_of_way` decimal(10,0) NOT NULL,
  `wayleave` decimal(10,0) NOT NULL,
  `chainage` decimal(10,0) NOT NULL,
  `land_rate_per_acre` double(10,2) NOT NULL,
  `land_interest` int(10) NOT NULL,
  `dimution_level` int(10) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `land_access_project`
--

CREATE TABLE `land_access_project` (
  `id` int(11) NOT NULL,
  `project_title` varchar(300) NOT NULL,
  `project_category` int(11) DEFAULT NULL,
  `project_category_unit` int(11) NOT NULL,
  `project_reference` varchar(100) NOT NULL,
  `client_id` int(11) NOT NULL,
  `disturbance_allowance` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_modified` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `land_access_project`
--

INSERT INTO `land_access_project` (`id`, `project_title`, `project_category`, `project_category_unit`, `project_reference`, `client_id`, `disturbance_allowance`, `date_added`, `created_by`, `date_modified`, `modified_by`, `active`) VALUES
(7, 'CONSULTANCY SERVICES FOR THE DEVELOPMENT OF A RESETTLEMENT ACTION PLAN (RAP) FOR THE IGANGA â€“ KALIRO WATER SUPPLY SYSTEM ', NULL, 5, 'IK', 5, 15, '2017-11-29 08:19:48', 0, '0000-00-00 00:00:00', 1, 1),
(8, 'CONSULTANCY SERVICES FOR CADASTRAL SURVEY AND VALUATION OF MUBUKU IRRIGATION SCHEME - KASESE DISTRICT', NULL, 5, 'MUM', 5, 30, '2017-12-14 01:54:30', 0, '0000-00-00 00:00:00', 1, 1),
(9, 'CONSULTANCY SERVICES FOR CADASTRAL SURVEY AND VALUATION OF DOHO IRRIGATION SCHEME - BUTALEJJA DISTRICT', NULL, 5, 'DOH', 5, 30, '2017-12-14 01:55:51', 0, '0000-00-00 00:00:00', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `land_access_project_category`
--

CREATE TABLE `land_access_project_category` (
  `id` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `description` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `date_added` datetime NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `land_access_project_category_unit`
--

CREATE TABLE `land_access_project_category_unit` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `category` int(11) NOT NULL COMMENT 'Category 3 is a combination of both wayleaves and right of way',
  `description` text NOT NULL,
  `date_added` datetime NOT NULL,
  `added_by` int(11) NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `land_access_project_category_unit`
--

INSERT INTO `land_access_project_category_unit` (`id`, `title`, `category`, `description`, `date_added`, `added_by`, `date_modified`, `active`) VALUES
(1, 'Right of way', 1, 'This involves full utilization of the entire piece of land. In other words, land ownership is totally transferred from the primary owner, to the body in charge.\r\nExamples of activities that require this type of acquisition are road construction, Laying water pipelines, and etc. This type majorly falls under the Permanent land acquisition Category.\r\nAnd the agencies involved here are UNRA & NWSC', '2017-11-09 06:08:58', 0, '2017-11-09 04:18:43', 1),
(2, 'Way Leaves', 2, 'In this type of acquisition, land is used limitedly depending on the activity at hand.  In other words, the primary land owner is allowed to use this particular piece of land to some extent. A good example on this is say, assuming electricity power lines are passed through some oneâ€™s land, it would not imply that he would no longer be using that land completely, he could still  use it for activities like farming but limited to only growing short crops like beans, maize, and etc. but not for crops like Bananas, trees and etc. REA is the only agency involved', '2017-11-09 06:12:16', 0, '2017-11-09 04:18:48', 1),
(4, 'Right of way and Way leaves', 3, 'Combines both right of way and wayleaves', '2017-11-09 06:20:31', 0, '2017-11-09 04:20:40', 1),
(5, 'Total Size', 1, 'Applicable incase of Roads, Agriculture, Oil and Gas, and Water Sector Projects', '2017-11-15 05:05:09', 0, '2017-11-15 15:05:09', 1);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `id` int(11) NOT NULL,
  `title` varchar(8) NOT NULL,
  `person_type` int(11) NOT NULL,
  `person_number` varchar(45) NOT NULL COMMENT 'Based on person Type -- Client/Staff',
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `othername` varchar(156) DEFAULT NULL,
  `id_type` tinyint(2) NOT NULL COMMENT 'Type of id',
  `id_number` varchar(80) NOT NULL,
  `id_specimen` text NOT NULL,
  `gender` varchar(3) NOT NULL,
  `marital_status` varchar(50) NOT NULL,
  `dateofbirth` date NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(156) DEFAULT NULL,
  `postal_address` varchar(156) DEFAULT NULL,
  `physical_address` varchar(156) DEFAULT NULL,
  `occupation` varchar(150) NOT NULL,
  `children_no` tinyint(4) DEFAULT '0',
  `dependants_no` tinyint(4) DEFAULT '0',
  `CRB_card_no` varchar(30) DEFAULT NULL,
  `photograph` text,
  `comment` text,
  `date_registered` datetime NOT NULL,
  `registered_by` int(11) NOT NULL,
  `district` varchar(100) NOT NULL,
  `county` varchar(100) NOT NULL,
  `subcounty` varchar(100) NOT NULL,
  `parish` varchar(100) NOT NULL,
  `village` varchar(100) NOT NULL,
  `modifiedBy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `position`
--

CREATE TABLE `position` (
  `id` int(11) NOT NULL,
  `title` varchar(156) NOT NULL,
  `access_level` int(11) NOT NULL,
  `description` text,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `position`
--

INSERT INTO `position` (`id`, `title`, `access_level`, `description`, `active`) VALUES
(1, 'Administrator', 1, 'Admin', 1),
(2, 'Field Staff', 2, 'Field operators/ data collectors', 1),
(3, 'Management Staff', 3, 'Management Staff', 1);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `othername` varchar(50) NOT NULL,
  `position` int(11) NOT NULL,
  `username` varchar(120) NOT NULL,
  `password` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(30) NOT NULL,
  `phone_contact` varchar(24) NOT NULL,
  `phone_contact2` varchar(24) NOT NULL,
  `address` text NOT NULL,
  `staff_type` tinyint(1) NOT NULL DEFAULT '1',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `date_added` int(11) NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added_by` varchar(45) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `firstname`, `lastname`, `othername`, `position`, `username`, `password`, `status`, `email`, `phone_contact`, `phone_contact2`, `address`, `staff_type`, `start_date`, `end_date`, `date_added`, `date_modified`, `added_by`, `active`) VALUES
(1, 'Alfred', 'Platin', 'Mugasa', 1, '', '9e11830101b6b723ae3fb11e660a2123', 1, 'mplat84@gmail.com', '0702771124', '', '', 1, '0000-00-00', NULL, 1510582406, '2017-11-14 09:51:41', '', 1),
(4, 'Allan ', 'Jesse ', 'Odekke', 2, '', '9e11830101b6b723ae3fb11e660a2123', 1, 'allan@gmail.com', '0702771124', '0774355568', 'Kampala', 0, '0000-00-00', NULL, 1510660039, '2017-11-14 10:47:19', '', 1),
(6, 'Brayan', 'Wamani', '', 1, '', 'bfe6edcba6f120ba55e0a46ee7815102', 1, 'brwamani@gmail.com', '0701108262', '', 'Wakiso', 1, '0000-00-00', NULL, 0, '2017-12-13 17:20:15', '', 1),
(7, 'Gonza', 'Alozius', '', 1, '', 'bfe6edcba6f120ba55e0a46ee7815102', 1, 'gonzaalozius@gmail.com', '0701478636', '0794661494', 'KASENGEJJE, WAKISO', 1, '0000-00-00', NULL, 1511960439, '2017-11-29 13:00:39', '', 1),
(8, 'Gonza', 'Alozius', '', 1, '', 'bfe6edcba6f120ba55e0a46ee7815102', 1, 'gonzaalozius@gmail.com', '0701478636', '0794661494', 'KASENGEJJE, WAKISO', 1, '0000-00-00', NULL, 1511960439, '2017-11-29 13:01:43', '', 0),
(9, 'Jockim', 'Mbale', '', 2, '', 'f20ebe0591005f418f269a115406d650', 1, 'jockimmbale@gmail.com', '0781584222', '0755479830', 'KAMULI ROAD, KIREKA', 0, '0000-00-00', NULL, 1512054977, '2017-12-14 06:52:12', '', 0),
(10, 'Joseph', 'Balikuddembe', '', 2, '', 'c7bbbec6d86d9c64bdf97b83ae653597', 1, 'balikuddembejb@gmail.com', '0701859666', '', 'KKONA, WAKISO', 1, '0000-00-00', NULL, 1512060083, '2017-11-30 16:41:23', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_client`
--

CREATE TABLE `tbl_client` (
  `id` int(11) NOT NULL,
  `client_names` varchar(150) NOT NULL,
  `physical_address` varchar(150) NOT NULL,
  `postal_address` varchar(100) NOT NULL,
  `phone_contact1` varchar(15) NOT NULL,
  `phone_contact2` varchar(15) NOT NULL,
  `email_contact1` varchar(60) NOT NULL,
  `email_contact2` varchar(60) NOT NULL,
  `website` varchar(100) NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_created` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Records of all the clients worked with';

--
-- Dumping data for table `tbl_client`
--

INSERT INTO `tbl_client` (`id`, `client_names`, `physical_address`, `postal_address`, `phone_contact1`, `phone_contact2`, `email_contact1`, `email_contact2`, `website`, `created_by`, `date_created`, `modified_by`, `date_modified`) VALUES
(5, 'MINISTRY OF WATER AND ENVIRONMENT, DIRECTORATE OF WATER DEVELOPMENT, WATER AND SANITATION DEVELOPMENT FACILITY - EAST, ', 'LUZIRA, KAMPALA, UGANDA', '1324 Mbale, Uganda', '0776444233', '0752444233', 'mwe@mwe.go.ug', '', '', 0, 1511942921, 1, '2017-11-29 08:08:41');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_comment`
--

CREATE TABLE `tbl_comment` (
  `id` int(11) NOT NULL,
  `details` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_comment`
--

INSERT INTO `tbl_comment` (`id`, `details`) VALUES
(1, 'TRANSMISSION LINE'),
(2, 'DISTRIBUTION LINE'),
(3, 'PUBLIC TOILET SITE'),
(4, 'RESERVOIR SITE'),
(5, 'TAPPING POINT');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_county`
--

CREATE TABLE `tbl_county` (
  `id` int(10) UNSIGNED NOT NULL,
  `county_name` varchar(50) NOT NULL,
  `district` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Districts in Uganda';

-- --------------------------------------------------------

--
-- Table structure for table `tbl_crop_description`
--

CREATE TABLE `tbl_crop_description` (
  `id` int(11) NOT NULL,
  `tree_type_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_crop_description`
--

INSERT INTO `tbl_crop_description` (`id`, `tree_type_id`, `title`, `description`, `active`) VALUES
(13, 0, 'SEEDLING', '', 1),
(14, 0, 'MATURE GOOD', '', 1),
(15, 0, 'MATURE AVERAGE', '', 1),
(16, 0, 'MATURE POOR', '', 1),
(17, 0, 'MATURE POOR', '', 1),
(18, 0, 'YOUNG GOOD', '', 1),
(19, 0, 'AVERAGE', '', 1),
(20, 0, 'YOUNG POOR', '', 1),
(21, 0, 'MATURE YIELDING', '', 1),
(22, 0, 'AVERAGE YIELDING', '', 1),
(23, 0, 'YOUNG', '', 1),
(24, 0, '60cm DIAMETER', '', 1),
(25, 0, 'BELOW 60cm DIAMETER', '', 1),
(26, 0, 'ELECTRIC POLE', '', 1),
(27, 0, 'TELEPHONE POLE', '', 1),
(28, 0, 'BUILDING POLE', '', 1),
(29, 0, 'BIG SIZE', '', 1),
(30, 0, 'MEDIUM', '', 1),
(31, 0, 'SMALL', '', 1),
(33, 0, 'TIMBER SIZE', '', 1),
(34, 0, 'SMALL YOUNG', '', 1),
(35, 0, 'POOR YIELDING', '', 1),
(36, 0, 'BIG  MATURE', '', 1),
(37, 0, 'MATURE', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district`
--

CREATE TABLE `tbl_district` (
  `id` int(10) UNSIGNED NOT NULL,
  `district_name` varchar(50) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Districts in Uganda';

--
-- Dumping data for table `tbl_district`
--

INSERT INTO `tbl_district` (`id`, `district_name`, `active`) VALUES
(1, 'ABIM', 1),
(2, 'ADJUMANI', 1),
(3, 'AGAGO', 1),
(4, 'ALEBTONG', 1),
(5, 'AMOLATAR', 1),
(6, 'AMUDAT', 1),
(7, 'AMURIA', 1),
(8, 'AMURU', 1),
(9, 'APAC', 1),
(10, 'ARUA', 1),
(11, 'BUDAKA', 1),
(12, 'BUDUDA', 1),
(13, 'BUGIRI', 1),
(14, 'BUHWEJU', 1),
(15, 'BUIKWE', 1),
(16, 'BUKEDEA', 1),
(17, 'BUKOMANSIMBI', 1),
(18, 'BUKWO', 1),
(19, 'BULAMBULI', 1),
(20, 'BULIISA', 1),
(21, 'BUNDIBUGYO', 1),
(22, 'BUSHENYI', 1),
(23, 'BUSIA', 1),
(24, 'BUTALEJA', 1),
(25, 'BUTAMBALA', 1),
(26, 'BUVUMA', 1),
(27, 'BUYENDE', 1),
(28, 'DOKOLO', 1),
(29, 'GOMBA', 1),
(30, 'GULU', 1),
(31, 'HOIMA', 1),
(32, 'IBANDA', 1),
(33, 'IGANGA', 1),
(34, 'ISINGIRO', 1),
(35, 'JINJA', 1),
(36, 'KAABONG', 1),
(37, 'KABALE', 1),
(38, 'KABAROLE', 1),
(39, 'KABERAMAIDO', 1),
(40, 'KALANGALA', 1),
(41, 'KALIRO', 1),
(42, 'KALUNGU', 1),
(43, 'KAMPALA', 1),
(44, 'KAMULI', 1),
(45, 'KAMWENGE', 1),
(46, 'KANUNGU', 1),
(47, 'KAPCHORWA', 1),
(48, 'KASESE', 1),
(49, 'KATAKWI', 1),
(50, 'KAYUNGA', 1),
(51, 'KIBAALE', 1),
(52, 'KIBOGA', 1),
(53, 'KIBUKU', 1),
(54, 'KIRUHURA', 1),
(55, 'KIRYANDONGO', 1),
(56, 'KISORO', 1),
(57, 'KITGUM', 1),
(58, 'KOBOKO', 1),
(59, 'KOLE', 1),
(60, 'KOTIDO', 1),
(61, 'KUMI', 1),
(62, 'KWEEN', 1),
(63, 'KYANKWANZI', 1),
(64, 'KYEGEGWA', 1),
(65, 'KYENJOJO', 1),
(66, 'LAMWO', 1),
(67, 'LIRA', 1),
(68, 'LUUKA', 1),
(69, 'LUWEERO', 1),
(70, 'LWENGO', 1),
(71, 'LYANTONDE', 1),
(72, 'MANAFWA', 1),
(73, 'MARACHA', 1),
(74, 'MASAKA', 1),
(75, 'MASINDI', 1),
(76, 'MAYUGE', 1),
(77, 'MBALE', 1),
(78, 'MBARARA', 1),
(79, 'MITOOMA', 1),
(80, 'MITYANA', 1),
(81, 'MOROTO', 1),
(82, 'MOYO', 1),
(83, 'MPIGI', 1),
(84, 'MUBENDE', 1),
(85, 'MUKONO', 1),
(86, 'NAKAPIRIPIRIT', 1),
(87, 'NAKASEKE', 1),
(88, 'NAKASONGOLA', 1),
(89, 'NAMAYINGO', 1),
(90, 'NAMUTUMBA', 1),
(91, 'NAPAK', 1),
(92, 'NEBBI', 1),
(93, 'NGORA', 1),
(94, 'NTOROKO', 1),
(95, 'NTUNGAMO', 1),
(96, 'NWOYA', 1),
(97, 'OTUKE', 1),
(98, 'OYAM', 1),
(99, 'PADER', 1),
(100, 'PALLISA', 1),
(101, 'RAKAI', 1),
(102, 'RUBIRIZI', 1),
(103, 'RUKUNGIRI', 1),
(104, 'SERERE', 1),
(105, 'SHEEMA', 1),
(106, 'SIRONKO', 1),
(107, 'SOROTI', 1),
(108, 'SSEMBABULE', 1),
(109, 'TORORO', 1),
(110, 'WAKISO', 1),
(111, 'YUMBE', 1),
(112, 'ZOMBO', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district_croptree_rate`
--

CREATE TABLE `tbl_district_croptree_rate` (
  `id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `croptree_id` int(11) NOT NULL,
  `rate` double(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_district_croptree_rate`
--

INSERT INTO `tbl_district_croptree_rate` (`id`, `district_id`, `croptree_id`, `rate`) VALUES
(2, 33, 24, 25000.00),
(3, 33, 25, 15000.00),
(4, 33, 23, 3000.00),
(5, 33, 26, 1000.00),
(6, 33, 8, 10000.00),
(7, 33, 9, 5000.00),
(8, 33, 10, 3000.00),
(9, 33, 11, 2000.00),
(11, 33, 28, 200000.00),
(12, 33, 29, 100000.00),
(13, 33, 30, 30000.00),
(14, 33, 27, 2000.00),
(19, 33, 19, 10000.00),
(21, 33, 20, 3000.00),
(22, 33, 21, 2500.00),
(23, 33, 18, 1000.00),
(24, 33, 35, 360000.00),
(25, 33, 32, 120000.00),
(26, 33, 33, 15000.00),
(27, 33, 34, 10000.00),
(28, 33, 31, 1000.00),
(29, 33, 37, 20000.00),
(30, 33, 36, 10000.00),
(31, 33, 38, 5000.00),
(32, 33, 41, 300000.00),
(33, 33, 40, 150000.00),
(34, 33, 42, 80000.00),
(35, 33, 39, 50000.00),
(36, 33, 44, 350000.00),
(37, 33, 45, 150000.00),
(38, 33, 46, 100000.00),
(39, 33, 47, 80000.00),
(40, 33, 48, 70000.00),
(41, 33, 43, 2000.00),
(45, 33, 50, 150000.00),
(46, 33, 51, 100000.00),
(48, 33, 54, 150000.00),
(49, 33, 55, 100000.00),
(50, 33, 57, 80000.00),
(51, 33, 56, 20000.00),
(52, 33, 53, 5000.00),
(53, 33, 59, 200000.00),
(54, 33, 60, 150000.00),
(55, 33, 61, 20000.00),
(56, 33, 62, 15000.00),
(57, 33, 63, 10000.00),
(58, 33, 58, 1000.00),
(59, 33, 97, 5000.00),
(71, 33, 71, 150000.00),
(72, 33, 72, 100000.00),
(73, 33, 73, 70000.00),
(74, 33, 74, 30000.00),
(75, 33, 65, 350000.00),
(76, 33, 66, 150000.00),
(77, 33, 67, 100000.00),
(78, 33, 68, 80000.00),
(79, 33, 69, 70000.00),
(80, 33, 64, 2000.00),
(81, 33, 77, 80000.00),
(82, 33, 78, 70000.00),
(83, 33, 79, 60000.00),
(84, 33, 80, 15000.00),
(85, 33, 81, 10000.00),
(86, 33, 76, 2000.00),
(87, 33, 82, 100000.00),
(88, 33, 83, 10000.00),
(89, 33, 98, 50000.00),
(90, 33, 85, 35000.00),
(91, 33, 87, 20000.00),
(92, 33, 86, 15000.00),
(93, 33, 88, 10000.00),
(94, 33, 84, 2000.00),
(95, 33, 92, 300000.00),
(96, 33, 91, 100000.00),
(97, 33, 90, 30000.00),
(98, 33, 89, 2000.00),
(105, 33, 95, 5000.00),
(107, 33, 13, 5000.00),
(108, 33, 16, 3000.00),
(109, 33, 15, 1000.00),
(110, 33, 14, 2000.00),
(111, 33, 103, 100000.00),
(112, 33, 101, 50000.00),
(113, 33, 102, 30000.00),
(114, 33, 99, 2000.00),
(115, 33, 112, 50000.00),
(116, 33, 113, 20000.00),
(117, 33, 114, 2000.00),
(118, 33, 115, 4000.00),
(119, 33, 116, 30000.00),
(120, 33, 117, 20000.00),
(121, 33, 118, 10000.00),
(122, 33, 119, 5000.00),
(123, 33, 120, 5000.00),
(124, 33, 121, 20000.00),
(125, 33, 100, 150000.00),
(126, 33, 106, 200000.00),
(127, 33, 107, 150000.00),
(128, 33, 108, 20000.00),
(129, 33, 110, 15000.00),
(130, 33, 105, 10000.00),
(131, 33, 104, 1000.00),
(132, 33, 123, 150000.00),
(133, 33, 124, 100000.00),
(134, 33, 126, 80000.00),
(135, 33, 125, 20000.00),
(136, 33, 122, 5000.00),
(137, 41, 24, 25000.00),
(138, 41, 25, 15000.00),
(139, 41, 23, 3000.00),
(140, 41, 26, 1000.00),
(141, 41, 8, 10000.00),
(142, 41, 9, 5000.00),
(143, 41, 10, 3000.00),
(144, 41, 11, 2000.00),
(145, 41, 28, 200000.00),
(146, 41, 29, 100000.00),
(147, 41, 30, 30000.00),
(148, 41, 27, 2000.00),
(149, 41, 19, 10000.00),
(150, 41, 20, 3000.00),
(151, 41, 21, 2500.00),
(152, 41, 18, 1000.00),
(153, 41, 35, 360000.00),
(154, 41, 32, 120000.00),
(155, 41, 33, 15000.00),
(156, 41, 34, 10000.00),
(157, 41, 31, 1000.00),
(158, 41, 37, 20000.00),
(159, 41, 36, 10000.00),
(160, 41, 38, 5000.00),
(161, 41, 41, 300000.00),
(162, 41, 40, 150000.00),
(163, 41, 42, 80000.00),
(164, 41, 39, 50000.00),
(165, 41, 44, 350000.00),
(166, 41, 45, 150000.00),
(167, 41, 46, 100000.00),
(168, 41, 47, 80000.00),
(169, 41, 48, 70000.00),
(170, 41, 43, 2000.00),
(171, 41, 50, 150000.00),
(172, 41, 51, 100000.00),
(173, 41, 54, 150000.00),
(174, 41, 55, 100000.00),
(175, 41, 57, 80000.00),
(176, 41, 56, 20000.00),
(177, 41, 53, 5000.00),
(178, 41, 59, 200000.00),
(179, 41, 60, 150000.00),
(180, 41, 61, 20000.00),
(181, 41, 62, 15000.00),
(182, 41, 63, 10000.00),
(183, 41, 58, 1000.00),
(184, 41, 97, 5000.00),
(185, 41, 71, 150000.00),
(186, 41, 72, 100000.00),
(187, 41, 73, 70000.00),
(188, 41, 74, 30000.00),
(189, 41, 65, 350000.00),
(190, 41, 66, 150000.00),
(191, 41, 67, 100000.00),
(192, 41, 68, 80000.00),
(193, 41, 69, 70000.00),
(194, 41, 64, 2000.00),
(195, 41, 77, 80000.00),
(196, 41, 78, 70000.00),
(197, 41, 79, 60000.00),
(198, 41, 80, 15000.00),
(199, 41, 81, 10000.00),
(200, 41, 76, 2000.00),
(201, 41, 82, 100000.00),
(202, 41, 83, 10000.00),
(203, 41, 98, 50000.00),
(204, 41, 85, 35000.00),
(205, 41, 87, 20000.00),
(206, 41, 86, 15000.00),
(207, 41, 88, 10000.00),
(208, 41, 84, 2000.00),
(209, 41, 92, 300000.00),
(210, 41, 91, 100000.00),
(211, 41, 90, 30000.00),
(212, 41, 89, 2000.00),
(213, 41, 95, 5000.00),
(214, 41, 13, 5000.00),
(215, 41, 16, 3000.00),
(216, 41, 15, 1000.00),
(217, 41, 14, 2000.00),
(218, 41, 103, 100000.00),
(219, 41, 101, 50000.00),
(220, 41, 102, 30000.00),
(221, 41, 99, 2000.00),
(222, 41, 112, 50000.00),
(223, 41, 113, 20000.00),
(224, 41, 114, 2000.00),
(225, 41, 115, 4000.00),
(226, 41, 116, 30000.00),
(227, 41, 117, 20000.00),
(228, 41, 118, 10000.00),
(229, 41, 119, 5000.00),
(230, 41, 120, 5000.00),
(231, 41, 121, 20000.00),
(232, 41, 100, 150000.00),
(233, 41, 106, 200000.00),
(234, 41, 107, 150000.00),
(235, 41, 108, 20000.00),
(236, 41, 110, 15000.00),
(237, 41, 105, 10000.00),
(238, 41, 104, 1000.00),
(239, 41, 123, 150000.00),
(240, 41, 124, 100000.00),
(241, 41, 126, 80000.00),
(242, 41, 125, 20000.00),
(243, 41, 122, 5000.00),
(244, 33, 129, 150000.00),
(245, 33, 130, 100000.00),
(246, 33, 131, 80000.00),
(247, 33, 132, 70000.00),
(248, 33, 128, 30000.00),
(249, 33, 127, 20000.00),
(250, 41, 127, 20000.00),
(251, 41, 128, 30000.00),
(252, 41, 132, 70000.00),
(253, 41, 131, 80000.00),
(254, 41, 130, 100000.00),
(255, 41, 129, 150000.00),
(256, 33, 26, 5000.00),
(257, 33, 133, 5000.00),
(258, 33, 136, 100000.00),
(259, 33, 137, 50000.00),
(260, 33, 138, 30000.00),
(261, 33, 139, 15000.00),
(262, 33, 140, 10000.00),
(263, 33, 135, 5000.00),
(264, 33, 134, 2000.00),
(265, 41, 134, 2000.00),
(266, 41, 135, 5000.00),
(267, 41, 140, 10000.00),
(268, 41, 139, 15000.00),
(269, 41, 138, 30000.00),
(270, 41, 137, 50000.00),
(271, 41, 136, 100000.00),
(272, 41, 133, 5000.00),
(273, 33, 143, 150000.00),
(274, 33, 144, 100000.00),
(275, 33, 146, 30000.00),
(276, 33, 142, 30000.00),
(277, 33, 141, 20000.00),
(278, 41, 141, 20000.00),
(279, 41, 142, 30000.00),
(280, 41, 146, 30000.00),
(281, 41, 144, 100000.00),
(282, 41, 143, 150000.00),
(283, 41, 150, 150000.00),
(284, 41, 150, 100000.00),
(285, 41, 153, 30000.00),
(286, 41, 148, 30000.00),
(287, 41, 147, 20000.00),
(288, 33, 147, 20000.00),
(289, 33, 148, 30000.00),
(290, 33, 153, 30000.00),
(291, 33, 150, 100000.00),
(292, 33, 150, 100000.00),
(293, 33, 157, 80000.00),
(294, 41, 157, 80000.00),
(295, 41, 156, 50000.00),
(296, 33, 156, 50000.00),
(297, 33, 155, 10000.00),
(298, 41, 155, 10000.00),
(299, 41, 154, 1000.00),
(300, 33, 154, 1000.00),
(301, 33, 161, 80000.00),
(302, 41, 161, 80000.00),
(303, 41, 160, 50000.00),
(304, 33, 160, 50000.00),
(305, 33, 159, 10000.00),
(306, 41, 159, 10000.00),
(309, 33, 158, 1000.00),
(310, 41, 158, 1000.00),
(311, 33, 162, 50000.00),
(312, 41, 162, 50000.00);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district_property_rate`
--

CREATE TABLE `tbl_district_property_rate` (
  `id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `propertytypedescription_id` int(11) NOT NULL,
  `rate` double(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_district_property_rate`
--

INSERT INTO `tbl_district_property_rate` (`id`, `district_id`, `propertytypedescription_id`, `rate`) VALUES
(15, 33, 7, 6000.00),
(16, 33, 6, 1500.00),
(17, 33, 8, 15000.00),
(18, 33, 10, 200000.00),
(19, 33, 9, 30000.00),
(20, 33, 11, 150000.00),
(21, 33, 13, 100000.00),
(22, 41, 7, 6000.00),
(23, 41, 6, 1500.00),
(24, 41, 8, 15000.00),
(25, 41, 10, 200000.00),
(26, 41, 9, 30000.00),
(27, 41, 11, 150000.00),
(28, 41, 13, 100000.00),
(29, 33, 14, 50000.00),
(30, 41, 14, 50000.00),
(31, 33, 15, 150000.00),
(32, 41, 15, 150000.00);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_paps`
--

CREATE TABLE `tbl_paps` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `pap_ref` varchar(50) NOT NULL,
  `firstname` varchar(70) NOT NULL,
  `lastname` varchar(70) NOT NULL,
  `othername` varchar(70) NOT NULL,
  `phone_contact` varchar(15) NOT NULL,
  `district_id` tinyint(3) NOT NULL,
  `county_id` int(11) DEFAULT NULL,
  `subcounty_id` int(5) NOT NULL,
  `parish_id` int(11) NOT NULL,
  `village_id` int(11) NOT NULL,
  `photo_url` varchar(100) DEFAULT NULL,
  `way_leave` decimal(8,4) DEFAULT NULL,
  `rightofway` decimal(8,4) DEFAULT NULL,
  `total_take` decimal(8,4) DEFAULT NULL,
  `diminution_rate` int(11) DEFAULT NULL,
  `rate_per_acre` decimal(12,2) DEFAULT NULL,
  `land_interest` int(11) DEFAULT NULL,
  `chainage` varchar(30) NOT NULL,
  `tenure` int(11) NOT NULL,
  `date_created` int(11) NOT NULL COMMENT 'Timestamp of the moment the member was added',
  `created_by` int(11) NOT NULL COMMENT 'Reference to staff who created this record',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp of the moment the member was modified',
  `modified_by` int(11) NOT NULL COMMENT 'Reference to staff who modified the record',
  `comment` text,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_paps`
--

INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, `chainage`, `tenure`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`, `active`) VALUES
(14, 7, 'IK0001', 'JAFARI', 'MUGENDI', '', '', 33, 0, 1, 9, 6, '1', '0.0000', '0.0000', '0.0008', 0, '800000000.00', 100, '', 8, 1512209505, 1, '2017-12-15 09:55:34', 1, 'TAPPING POINT', 1),
(15, 7, 'IK0002', 'RUTH', 'BABIRYE', '', '0700753621', 33, 0, 1, 9, 6, '1', '0.0000', '0.0000', '0.0090', 0, '800000000.00', 100, '', 8, 1512211836, 1, '2017-12-15 09:55:34', 1, 'TAPPING POINT', 1),
(16, 7, 'IK0003', 'HAMIDU ', 'BIDUSU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0035', 0, '40000000.00', 100, '', 8, 1512212220, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(17, 7, 'IK0047', 'MAGOGO ', 'ST. PETERS CHURCH OF UGANDA ', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0527', 0, '24000000.00', 100, '', 0, 1512212265, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(18, 7, 'IK0048', 'ROSE', 'MAGUMBA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0626', 0, '24000000.00', 100, '', 8, 1512212545, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(19, 7, 'IK0004', 'KUBWINA', 'SWAIBU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0013', 0, '40000000.00', 100, '', 8, 1512212695, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(20, 7, 'IK0005', 'LWABAGA ', 'RASHID', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0024', 0, '40000000.00', 100, '', 8, 1512212752, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(21, 7, 'IK0049', 'PERUS', 'NABIRYE', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0369', 0, '24000000.00', 100, '', 8, 1512212763, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(22, 7, 'IK0050', 'GODFREY', 'KATEGE', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0263', 0, '24000000.00', 100, '', 8, 1512212890, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(23, 7, 'IK0006', 'MALORE', 'FRED', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0280', 0, '40000000.00', 100, '', 8, 1512212973, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(24, 7, 'IK0007', 'SWAIBU', 'HAJJI', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0073', 0, '40000000.00', 100, '', 8, 1512213043, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(25, 7, 'IK0051', 'DAVID', 'KISUKU', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0080', 0, '24000000.00', 100, '', 8, 1512213110, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(27, 7, 'IK0008', 'NAIGAGA', 'JANE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0272', 0, '40000000.00', 100, '', 8, 1512213243, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(28, 7, 'IK0009', 'BAKASH', 'BADRU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0039', 0, '40000000.00', 100, '', 8, 1512213306, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(29, 7, 'IK0010', 'TAPENENSI', 'NANKWANGA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0071', 0, '40000000.00', 100, '', 8, 1512213385, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(30, 7, 'IK0011', 'REBECCA', 'NABIRYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0080', 0, '40000000.00', 100, '', 8, 1512213483, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(31, 7, 'IK0012', 'EDWARD ', 'TENYWA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512213558, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(32, 7, 'IK0013', 'DAUDA', 'BATEGANYA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512213892, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(33, 7, 'IK0014', 'WAKOLI', 'CHARLES', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0188', 0, '40000000.00', 100, '', 8, 1512214002, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(34, 7, 'IK0277', 'IBRAHIM', 'KIREVU', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0182', 0, '24000000.00', 100, '', 8, 1512214154, 1, '2017-12-15 09:55:48', 1, 'TRANSMISSION LINE', 1),
(35, 7, 'IK0015', 'DR. ', 'MAGUMBA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0446', 0, '40000000.00', 100, '', 8, 1512214540, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(36, 7, 'IK0275', 'SARAH', ' ', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0380', 0, '24000000.00', 100, '', 0, 1512214744, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(37, 7, 'IK0276', 'MUHAMMAD', 'BAABI', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.1047', 0, '24000000.00', 100, '', 0, 1512214862, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(38, 7, 'IK0016', 'PAUL', 'IGODOBE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0087', 0, '40000000.00', 100, '', 8, 1512214909, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(39, 7, 'IK0278', 'ANAS', 'BUYINZA', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0216', 0, '24000000.00', 100, '', 0, 1512215029, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(40, 7, 'IK0017', 'MUGOGO', 'ALICE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0134', 0, '40000000.00', 100, '', 8, 1512215114, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(42, 7, 'IK0018', 'NASSER ', 'IGURU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0123', 0, '40000000.00', 100, '', 8, 1512215515, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(43, 7, 'IK0019', 'UNKNOWN', '   ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512215693, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(44, 7, 'IK0020', 'NABWIRE', '  ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512215795, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(46, 7, 'IK0021', 'GODFREY', 'BALYEJUSA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0055', 0, '40000000.00', 100, '', 8, 1512215949, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(47, 7, 'IK0034', 'ASUMAN', 'KABIRA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0033', 0, '40000000.00', 100, '', 8, 1512216097, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(48, 7, 'IK0022', 'FAHAD', 'WAKATE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0000', 0, '40000000.00', 0, '', 9, 1512216167, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(49, 7, 'IK0024', 'ISMA', 'NKUTU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0031', 0, '40000000.00', 100, '', 8, 1512216435, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(50, 7, 'IK0025', 'MASJID', 'TAQWA BUKAYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512216510, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(51, 7, 'IK0026', 'SWAMADU', 'ABDU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0030', 0, '40000000.00', 100, '', 8, 1512216540, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(52, 7, 'IK0027', 'SHAKI', 'MOHAMMAD', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512217358, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(53, 7, 'IK0028', 'JESSICA', 'MUSAWO', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0049', 0, '40000000.00', 100, '', 8, 1512217415, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(54, 7, 'IK0282', 'MIRIAM', 'NABULUMBA', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0312', 0, '24000000.00', 100, '', 0, 1512217452, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(55, 7, 'IK0029', 'MBOBU', 'ABDALLAH', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0181', 0, '40000000.00', 100, '', 8, 1512217500, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(56, 7, 'IK0030', 'KYADIDI', 'ISABIRYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0105', 0, '40000000.00', 100, '', 8, 1512217719, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(57, 7, 'IK0052', 'PAUL', 'ISABIRIYE', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0092', 0, '24000000.00', 100, '', 8, 1512217727, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(58, 7, 'IK0031', 'GUMULA', 'HENRY', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0086', 0, '40000000.00', 100, '', 8, 1512217870, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(59, 7, 'IK0053', 'BASADA', 'NABIRYE', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0151', 0, '24000000.00', 100, '', 8, 1512217886, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(60, 7, 'IK0280', 'SIRAJE', 'KAPERE', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0102', 0, '24000000.00', 100, '', 0, 1512217898, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(61, 7, 'IK0279', 'HADIJJA', 'KAWALA', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0131', 0, '24000000.00', 100, '', 0, 1512218030, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(62, 7, 'IK0054', 'MUSA', 'OBODA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0051', 0, '24000000.00', 100, '', 8, 1512218240, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(63, 7, 'IK0283', 'YUSUF', 'BATEGANYA', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0138', 0, '24000000.00', 100, '', 0, 1512218288, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(64, 7, 'IK0055', 'SULAIMAN', 'BALINAINE', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0100', 0, '24000000.00', 100, '', 8, 1512218389, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(65, 7, 'IK0032', 'SALLY', 'MAGANDA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512218391, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(66, 7, 'IK0056', 'JOHN', 'MAGOLA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0153', 0, '24000000.00', 100, '', 8, 1512218470, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(67, 7, 'IK0284', 'IRENE', 'NAKAYIMA', 'NAKASANGO', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0046', 0, '24000000.00', 100, '', 0, 1512218472, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(68, 7, 'IK0033', 'BALIKUKI', 'STEVEN', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512218482, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(69, 7, 'IK0035', 'SAUDI', '   ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512218549, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(70, 7, 'IK0285', 'DEFENSE', 'KATO', 'C/O', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0040', 0, '24000000.00', 100, '', 0, 1512218578, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(71, 7, 'IK0036', 'KALULU', 'CHARLES', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512218585, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(72, 7, 'IK0037', 'LUKOYA', 'SAMANYA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0045', 0, '40000000.00', 100, '', 8, 1512218689, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(73, 7, 'IK0057', 'BOSCO', 'WADYATA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0095', 0, '24000000.00', 100, '', 8, 1512218711, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(76, 7, 'IK0058', 'PAUL', 'TENYWA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0827', 0, '24000000.00', 100, '', 8, 1512218967, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(79, 7, 'IK0287', 'FAIZAL ', 'TENYWA', 'MUGANDA', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0025', 0, '24000000.00', 100, '', 0, 1512219205, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(80, 7, 'IK0038', 'IBRAHIM', 'KINTU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0035', 0, '40000000.00', 100, '', 8, 1512219241, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(81, 7, 'IK0288', 'PETER', 'GAAVA', '', '0757847011', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0162', 0, '24000000.00', 100, '', 0, 1512219328, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(82, 7, 'IK0039', 'PROSSY', 'NABIRYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0039', 0, '40000000.00', 100, '', 8, 1512219330, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(83, 7, 'IK0040', 'ISABIRYE', 'ABDU KARIM', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0024', 0, '40000000.00', 100, '', 8, 1512219398, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(84, 7, 'IK0289', 'SIIDA', 'MALINA', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0063', 0, '24000000.00', 100, '', 0, 1512219411, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(85, 7, 'IK0041', 'LUGANDA', '  ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0059', 0, '40000000.00', 100, '', 8, 1512219439, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(86, 7, 'IK0042', 'MAGANDA', 'JUMA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0081', 0, '40000000.00', 100, '', 8, 1512219500, 1, '2017-12-15 09:55:35', 1, 'DISTRIBUTION LINE', 1),
(87, 7, 'IK0043', 'KAANA', 'BWAKYA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0035', 0, '40000000.00', 100, '', 8, 1512219627, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(88, 7, 'IK0044', 'ISMAIL', 'MUGOBA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0029', 0, '40000000.00', 100, '', 8, 1512219717, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(89, 7, 'IK0290', 'ROBINAH', 'MUTESI', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0066', 0, '24000000.00', 100, '', 0, 1512219767, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(90, 7, 'IK0045', 'LUBANGA', 'ERISA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0094', 0, '40000000.00', 100, '', 8, 1512219820, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(91, 7, 'IK0291', 'FAITH', 'KIKUBILA', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0056', 0, '24000000.00', 100, '', 0, 1512219823, 1, '2017-12-15 09:55:48', 1, 'Select comment ...', 1),
(92, 7, 'IK0292', 'ROBINAH', 'KYAKULAGA', '', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0067', 0, '24000000.00', 100, '', 0, 1512219890, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(93, 7, 'IK0059', 'ABDU', 'MABANDA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0244', 0, '24000000.00', 100, '', 8, 1512219925, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(94, 7, 'IK0293', 'FAIZAL', 'TENYWA', 'MAGANDA', '', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0061', 0, '24000000.00', 100, '', 0, 1512219968, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(95, 7, 'IK0046', 'TEZIKOMA ', 'SEBBI SAIDI', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0151', 0, '40000000.00', 100, '', 8, 1512219971, 1, '2017-12-15 09:55:36', 1, 'DISTRIBUTION LINE', 1),
(96, 7, 'IK0293', 'IBRAHIM', 'KIREVU', '', '0753240434', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.0061', 0, '24000000.00', 100, '', 0, 1512220030, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(97, 7, 'IK0295', 'NAMUNSALA', 'C.O.U PRIMARY SCHOOL', '', '0774683514', 33, 0, 3, 18, 26, '1', '0.0000', '0.0000', '0.1652', 0, '24000000.00', 100, '', 0, 1512220116, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(98, 7, 'IK0083', 'GASTA', 'BENDESE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0105', 0, '40000000.00', 100, '', 8, 1512220143, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(99, 7, 'IK0060', 'KIBEDI', '  ', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0021', 0, '24000000.00', 100, '', 8, 1512220200, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(100, 7, 'IK0296', 'GEOFFREY', 'ISABIRYE', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 0, 1512220201, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(101, 7, 'IK0084', 'MRS. MAGUMBA', '  ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0125', 0, '40000000.00', 100, '', 8, 1512220318, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(102, 7, 'IK0297', 'HASSAN', 'IKOBA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0102', 0, '24000000.00', 100, '', 0, 1512220323, 1, '2017-12-15 09:55:49', 1, 'DISTRIBUTION LINE', 1),
(104, 7, 'IK0298', 'UNIVERSAL', 'APPOSTLES', 'CHURCH', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0061', 0, '24000000.00', 100, '', 0, 1512220423, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(105, 7, 'IK0086', 'TEZIKOMA', 'SEBBI SAIDI', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0053', 0, '40000000.00', 100, '', 0, 1512220463, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(106, 7, 'IK0299', 'FESTO', 'WAISWA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0057', 0, '24000000.00', 100, '', 0, 1512220478, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(107, 7, 'IK0062', 'BILALI', 'BASALIRWA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0052', 0, '24000000.00', 100, '', 8, 1512220496, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(108, 7, 'IK0300', 'YOSIA', 'TENYWA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0070', 0, '24000000.00', 100, '', 0, 1512220525, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(109, 7, 'IK0061', 'JOYCE', 'NAKALANDA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0052', 0, '24000000.00', 100, '', 8, 1512220544, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(110, 7, 'IK0301', 'JUMA', 'ISABIRYE', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0126', 0, '24000000.00', 100, '', 0, 1512220593, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(111, 7, 'IK0088', 'AZEDI', 'MBONYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0083', 0, '40000000.00', 100, '', 8, 1512220599, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(112, 7, 'IK0089', 'KYADID', 'ISABIRYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0125', 0, '40000000.00', 100, '', 8, 1512220729, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(113, 7, 'IK0090', 'WAISWA', '   ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512220762, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(114, 7, 'IK0063', 'ST PETER''S CHURCH OF UGANDA-MAGOGO', ' ', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0933', 0, '24000000.00', 100, '', 8, 1512220795, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(115, 7, 'IK0302', 'STEVEN', 'WAMBUZI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0070', 0, '24000000.00', 100, '', 0, 1512220802, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(116, 7, 'IK0091', 'IDDI', 'ZAUM', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0102', 0, '40000000.00', 100, '', 8, 1512220807, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(117, 7, 'IK0092', 'MOHAMMAD', 'KYEDUMIRA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0028', 0, '40000000.00', 100, '', 8, 1512220861, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(118, 7, 'IK0093', 'UNKNOWN', '   ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0062', 0, '40000000.00', 100, '', 8, 1512220895, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(119, 7, 'IK0064', 'FRED', 'WAMBI', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0606', 0, '24000000.00', 100, '', 8, 1512220914, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(120, 7, 'IK0094', 'ELIZABETH', 'NABIRYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0089', 0, '40000000.00', 100, '', 8, 1512220958, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(121, 7, 'IK0065', 'BINAISALI', 'MAGUMBA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0294', 0, '24000000.00', 100, '', 8, 1512221013, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(122, 7, 'IK0096', 'AMELI', 'ISABIRYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0088', 0, '40000000.00', 100, '', 8, 1512221032, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(123, 7, 'IK0303', 'ELIZABETH', 'NAIGAGA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0183', 0, '24000000.00', 100, '', 0, 1512221035, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(124, 7, 'IK0066', 'SAMUEL', 'MWANJA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0268', 0, '24000000.00', 100, '', 0, 1512221107, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(125, 7, 'IK0097', 'KIGENYI', 'ISABIRYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0107', 0, '40000000.00', 100, '', 8, 1512221166, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(126, 7, 'IK0098', 'YOSAM', 'WAISWA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0068', 0, '40000000.00', 100, '', 8, 1512221257, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(128, 7, 'IK0304', 'GRACE', 'WAMBUZI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0117', 0, '24000000.00', 100, '', 0, 1512221312, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(129, 7, 'IK0067', 'LASTON', 'NAMPALA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0066', 0, '24000000.00', 100, '', 8, 1512221344, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(130, 7, 'IK0305', 'FELIX', 'MAGALA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0171', 0, '24000000.00', 100, '', 0, 1512221426, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(131, 7, 'IK0102', 'ELISA', 'KASADA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0341', 0, '40000000.00', 100, '', 8, 1512221482, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(132, 7, 'IK0306', 'BEATRICE', 'KAYIRIGI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0322', 0, '24000000.00', 100, '', 0, 1512221513, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(133, 7, 'IK0068', 'GEORGE', 'BABI', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0124', 0, '24000000.00', 100, '', 8, 1512221555, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(134, 7, 'IK0307', 'FAITH', 'NAMUKOBE', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0138', 0, '24000000.00', 100, '', 0, 1512221573, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(135, 7, 'IK0103', 'KINTU', 'NASIBU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 0, 1512221646, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(136, 7, 'IK0308', 'GRACE', 'WAMBUZI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0183', 0, '24000000.00', 100, '', 0, 1512221649, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(137, 7, 'IK0104', 'JAFARI', 'BALILAINE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0053', 0, '40000000.00', 100, '', 8, 1512221713, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(138, 7, 'IK0105', 'MUTESI', '  ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0041', 0, '40000000.00', 100, '', 8, 1512221754, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(139, 7, 'IK0106', 'ZULAIKA', 'NAIGAGA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0067', 0, '40000000.00', 100, '', 8, 1512221814, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(140, 7, 'IK0107', 'ZULA', '   ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512221855, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(141, 7, 'IK0309', 'FAITH', 'NAMUKOBE', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0099', 0, '24000000.00', 100, '', 0, 1512221884, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(142, 7, 'IK0108', 'MUTESI', '   ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0076', 0, '40000000.00', 100, '', 8, 1512221904, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(143, 7, 'IK0310', 'JOSEPHINE', 'NANDAWULA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0246', 0, '24000000.00', 100, '', 0, 1512221965, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(144, 7, 'IK0109', 'SALEY', 'MAGANDA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512221974, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(145, 7, 'IK0110', 'UKNOWN', '  ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0043', 0, '40000000.00', 100, '', 8, 1512222031, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(146, 7, 'IK0311', 'ESTHER', 'NAKIYEMBA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0201', 0, '24000000.00', 100, '', 0, 1512222032, 1, '2017-12-15 09:55:49', 1, 'Select comment ...', 1),
(147, 7, 'IK0111', 'UKNOWN', ' ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 0, 1512222102, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(148, 7, 'IK0312', 'MSRIKO', 'KIBUKA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0142', 0, '24000000.00', 100, '', 0, 1512222106, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(149, 7, 'IK0313', 'STEVEN', 'ISABIRYE', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0190', 0, '24000000.00', 100, '', 0, 1512222171, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(150, 7, 'IK0112', 'BWAKYA', 'DAN', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0073', 0, '40000000.00', 100, '', 8, 1512222191, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(151, 7, 'IK0113', 'DAN', 'LUBANGA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0068', 0, '40000000.00', 100, '', 8, 1512222246, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(152, 7, 'IK0114', 'KYOZILA', '     ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0081', 0, '40000000.00', 100, '', 8, 1512222279, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(153, 7, 'IK0314', 'JAMES', 'KAYIRIGI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0221', 0, '24000000.00', 100, '', 0, 1512222287, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(154, 7, 'IK0115', 'UNKNOWN', '   ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0074', 0, '40000000.00', 100, '', 8, 1512222339, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(155, 7, 'IK0315', 'JANET', 'MUTESI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0152', 0, '24000000.00', 100, '', 0, 1512222369, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(156, 7, 'IK0116', 'ABASI', 'MUSANA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0070', 0, '40000000.00', 100, '', 8, 1512222372, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(157, 7, 'IK0316', 'SAM', 'KASABALI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0134', 0, '24000000.00', 100, '', 0, 1512222432, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(158, 7, 'IK0117', 'AGURA', 'BURUKANI', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0419', 0, '40000000.00', 100, '', 0, 1512222434, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(159, 7, 'IK0317', 'PASTOR', 'MUSISI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0057', 0, '24000000.00', 100, '', 0, 1512222496, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(160, 7, 'IK0317', 'MOSES', 'BASALIRWA', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0057', 0, '24000000.00', 100, '', 0, 1512222574, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(161, 7, 'IK0069', 'FRED', 'MUWANGA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0067', 0, '24000000.00', 100, '', 8, 1512222680, 1, '2017-12-15 09:55:37', 1, 'DISTRIBUTION LINE', 1),
(162, 7, 'IK0118', 'ABDALLAH', 'KADUYU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0126', 0, '40000000.00', 100, '', 8, 1512222722, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(163, 7, 'IK0319', 'PASTOR', 'MUSISI', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0064', 0, '24000000.00', 100, '', 0, 1512222744, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(164, 7, 'IK0070', 'DUNCAN', 'WAISWA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0110', 0, '24000000.00', 100, '', 8, 1512222780, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(165, 7, 'IK0120', 'KASIMU', 'MUWANIKA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0072', 0, '40000000.00', 100, '', 8, 1512222808, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(166, 7, 'IK0071', 'DAVID', 'SAMANYA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0046', 0, '24000000.00', 100, '', 8, 1512222898, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(167, 7, 'IK0121', 'CHRISTOPHER', 'BANDESE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0326', 0, '40000000.00', 100, '', 8, 1512222980, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(168, 7, 'IK0122', 'JOET', 'MAGUMBA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0169', 0, '40000000.00', 100, '', 8, 1512223226, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(169, 7, 'IK0320', 'KEKULINA', 'GASANSULE', '', '', 33, 0, 3, 14, 24, '1', '0.0000', '0.0000', '0.0133', 0, '24000000.00', 100, '', 0, 1512223251, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(170, 7, 'IK0123', 'MUHAMMAD', 'ISABIRYE', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0120', 0, '40000000.00', 100, '', 8, 1512223280, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(171, 7, 'IK0124', 'UKNOWN', '  ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0167', 0, '40000000.00', 100, '', 8, 1512223320, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(172, 7, 'IK0321', 'SIRAJE', 'WAKABI', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0664', 0, '24000000.00', 100, '', 0, 1512223375, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(173, 7, 'IK0125', 'ELIWALA', 'ALEX', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0094', 0, '40000000.00', 100, '', 8, 1512223384, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(174, 7, 'IK0072', 'IDDI', 'ZAWUMA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0103', 0, '24000000.00', 100, '', 0, 1512223413, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(175, 7, 'IK0127', 'UNKNOWN', '  ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0072', 0, '40000000.00', 100, '', 8, 1512223461, 1, '2017-12-15 09:55:41', 1, 'DISTRIBUTION LINE', 1),
(176, 7, 'IK0128', 'UNKNOWN', '   ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0084', 0, '40000000.00', 100, '', 8, 1512223485, 1, '2017-12-15 09:55:41', 1, 'DISTRIBUTION LINE', 1),
(177, 7, 'IK0073', 'GRACE', 'MUSASIZI ', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512223491, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(178, 7, 'IK0074', 'ANDREW', 'MUGIMBA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0316', 0, '24000000.00', 100, '', 8, 1512223557, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(179, 7, 'IK0129', 'SWAIBU', 'KUBWINA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0792', 0, '40000000.00', 100, '', 8, 1512223599, 1, '2017-12-15 09:55:41', 1, 'DISTRIBUTION LINE', 1),
(180, 7, 'IK0322', 'RUTH', 'BABIRYE', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0098', 0, '24000000.00', 100, '', 0, 1512223647, 1, '2017-12-15 09:55:50', 1, 'Select comment ...', 1),
(181, 7, 'IK0075', 'LUWAGA', 'SALONGO', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0261', 0, '24000000.00', 100, '', 0, 1512223649, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(182, 7, 'IK0130', 'KUBWINA', '  ', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0000', 0, '40000000.00', 100, '', 8, 1512223669, 1, '2017-12-15 09:55:41', 1, 'DISTRIBUTION LINE', 1),
(183, 7, 'IK0076', 'JOHN STEVEN', 'KAKUMA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0143', 0, '24000000.00', 100, '', 8, 1512223721, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(184, 7, 'IK0131', 'ISABIRYE', 'AMIRU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0060', 0, '40000000.00', 100, '', 8, 1512223752, 1, '2017-12-15 09:55:41', 1, 'DISTRIBUTION LINE', 1),
(185, 7, 'IK0132', 'BURUHAIN', 'KADULI', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0194', 0, '40000000.00', 100, '', 8, 1512223844, 1, '2017-12-15 09:55:41', 1, 'DISTRIBUTION LINE', 1),
(186, 7, 'IK0365', 'JANET ', 'KAGOYA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0225', 0, '24000000.00', 100, '', 8, 1512224166, 1, '2017-12-15 09:55:52', 1, 'DISTRIBUTION LINE', 1),
(187, 7, 'IK0366', 'JOHN', 'TENYWA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0028', 0, '24000000.00', 100, '', 8, 1512224223, 1, '2017-12-15 09:55:52', 1, 'DISTRIBUTION LINE', 1),
(188, 7, 'IK0323', 'SAMUEL', 'BAGANYIGIRA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0050', 0, '24000000.00', 100, '', 8, 1512224254, 1, '2017-12-15 09:55:51', 1, 'DISTRIBUTION LINE', 1),
(190, 7, 'IK0367', 'MUGOYA', 'JAMES', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.2478', 0, '24000000.00', 100, '', 8, 1512224273, 1, '2017-12-15 09:55:52', 1, 'TRANSMISSION LINE', 1),
(191, 7, 'IK0368', 'ABDU', 'MUYINDA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0058', 0, '24000000.00', 100, '', 8, 1512224359, 1, '2017-12-15 09:55:52', 1, 'DISTRIBUTION LINE', 1),
(192, 7, 'IK0369', 'FATINA', 'NAMULINDA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0043', 0, '24000000.00', 100, '', 8, 1512224412, 1, '2017-12-15 09:55:52', 1, 'DISTRIBUTION LINE', 1),
(193, 7, 'IK0370', 'PATRICK', 'WAISWA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0034', 0, '24000000.00', 100, '', 8, 1512224469, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(194, 7, 'IK0371', 'ABDALLAH', 'BAKITWALA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0043', 0, '24000000.00', 100, '', 8, 1512224524, 1, '2017-12-15 09:55:52', 1, 'DISTRIBUTION LINE', 1),
(195, 7, 'IK0372', 'FAZIR', 'KALUBA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0038', 0, '24000000.00', 100, '', 8, 1512224584, 1, '2017-12-15 09:55:52', 1, 'DISTRIBUTION LINE', 1),
(196, 7, 'IK0373', 'UNKNOWN', '  ', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0052', 0, '24000000.00', 100, '', 8, 1512224625, 1, '2017-12-15 09:55:52', 1, 'DISTRIBUTION LINE', 1),
(197, 7, 'IK0374', 'NURU', 'KITALE', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0151', 0, '24000000.00', 100, '', 8, 1512224769, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(198, 7, 'IK0375', 'SAMUEL', 'BAMUWAIRE', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0098', 0, '24000000.00', 100, '', 8, 1512224915, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(199, 7, 'IK0376', 'KAGOYA', 'MAURINCIA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0161', 0, '24000000.00', 100, '', 8, 1512224986, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(200, 7, 'IK0377', 'JUMA', 'WALUBIRI', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0049', 0, '24000000.00', 100, '', 8, 1512225026, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(201, 7, 'IK0378', 'ABDALLAH', 'BITWALE', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0122', 0, '24000000.00', 100, '', 8, 1512225067, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(202, 7, 'IK0379', 'AHAMAD', 'NGOBI', 'OBODAH', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0092', 0, '24000000.00', 100, '', 8, 1512225201, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(203, 7, 'IK0380', 'ISMAIL', 'TADUBA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0076', 0, '24000000.00', 100, '', 8, 1512225256, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(204, 7, 'IK0381', 'UNKNOWN', '   ', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0066', 0, '24000000.00', 100, '', 8, 1512225302, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(205, 7, 'IK0382', 'MIKEL', 'ADEYA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0132', 0, '24000000.00', 100, '', 8, 1512225347, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(206, 7, 'IK0383', 'MASIJID TAQWA NAMUNKESU', ' ', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0375', 0, '24000000.00', 100, '', 8, 1512225405, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(207, 7, 'IK0384', 'ABASI', 'BAGALAINE', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0137', 0, '40000000.00', 100, '', 8, 1512225618, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(208, 7, 'IK0385', 'NABIKOBA', 'AISHA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512225685, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(209, 7, 'IK0386', 'YEKKO', '  ', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0045', 0, '40000000.00', 100, '', 8, 1512225712, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(210, 7, 'IK0077', 'ROBINAH', 'NKOLEKI', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0027', 0, '24000000.00', 100, '', 8, 1512225714, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(211, 7, 'IK0387', 'SWABIRI', 'KISIMYA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512225757, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(212, 7, 'IK0078', 'STEVEN', 'WELUKWAGANA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0306', 0, '24000000.00', 100, '', 8, 1512225783, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(213, 7, 'IK0388', 'NURU', 'NAMPIMA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0088', 0, '40000000.00', 100, '', 8, 1512225792, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(214, 7, 'IK0389', 'SOLD TO UNKNOWN', '  ', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0070', 0, '40000000.00', 100, '', 8, 1512225843, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(215, 7, 'IK0079', 'WAKKO', ' ', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0261', 0, '24000000.00', 100, '', 8, 1512225845, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(216, 7, 'IK0390', 'PAUL', 'NAMIVULE', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0061', 0, '40000000.00', 100, '', 0, 1512225901, 1, '2017-12-15 09:55:53', 1, 'DISTRIBUTION LINE', 1),
(217, 7, 'IK0080', 'DANIEL', 'MUKISA', '', '', 33, 0, 5, 15, 13, '1', '0.0000', '0.0000', '0.0135', 0, '24000000.00', 100, '', 8, 1512225904, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(218, 7, 'IK0081', 'WILSON', 'LUKUNGU', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0259', 0, '40000000.00', 100, '', 8, 1512225999, 1, '2017-12-15 09:55:38', 1, 'DISTRIBUTION LINE', 1),
(219, 7, 'IK0391', 'JAMIL', 'BAZIGU', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0061', 0, '40000000.00', 100, '', 8, 1512226015, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(220, 7, 'IK0082', 'THOMAS', 'TILIBUUZA', '', '', 33, 0, 5, 6, 3, '1', '0.0000', '0.0000', '0.0325', 0, '40000000.00', 100, '', 0, 1512226066, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(221, 7, 'IK0134', 'AYUB', 'MUYERE', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0397', 0, '32000000.00', 100, '', 8, 1512226163, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(222, 7, 'IK0392', 'ZAAKE', 'BUTEGU', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512226191, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(223, 7, 'IK0393', 'NURU', 'NABIRYE', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0065', 0, '40000000.00', 100, '', 8, 1512226224, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(224, 7, 'IK0394', 'NAKAZIBA', 'ZAMU', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0085', 0, '40000000.00', 100, '', 8, 1512226273, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(225, 7, 'IK0395', 'JAMAWA', 'NAMUWAYA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512226318, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(226, 7, 'IK0396', 'YAKUT', 'MAGENDA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0045', 0, '40000000.00', 100, '', 8, 1512226370, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(227, 7, 'IK0324', 'MOSES', 'BAGANIGIRE ', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0078', 0, '24000000.00', 100, '', 8, 1512226663, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(228, 7, 'IK0400', 'KISIKI FAMILY', '  ', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512226727, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(229, 7, 'IK0325', 'MONICA', 'NABIRYE', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0076', 0, '24000000.00', 100, '', 8, 1512226729, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(230, 7, 'IK0401', 'SULAYI', 'MWIKO', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0124', 0, '40000000.00', 100, '', 0, 1512226824, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(231, 7, 'IK0327', 'NAOME', 'TIBITONDWA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0110', 0, '24000000.00', 100, '', 8, 1512226916, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(232, 7, 'IK0402', 'MAJID', 'BUKUMUNE', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0041', 0, '40000000.00', 100, '', 8, 1512226950, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(233, 7, 'IK0328', 'FRED', 'NAYITA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0118', 0, '24000000.00', 100, '', 8, 1512226976, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(234, 7, 'IK0403', 'EZIRA', 'NASURU', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0067', 0, '40000000.00', 100, '', 8, 1512226996, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(235, 7, 'IK0404', 'ROBERT', '  ', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512227026, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(236, 7, 'IK0405', 'ASHRAF', 'WAISWA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0034', 0, '40000000.00', 100, '', 8, 1512227084, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(237, 7, 'IK0329', ' ', 'MUSOKE', 'MRS', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0295', 0, '24000000.00', 100, '', 8, 1512227108, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(238, 7, 'IK0406', 'KAWAYA', 'MAWAZI', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0025', 0, '40000000.00', 100, '', 8, 1512227243, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(239, 7, 'IK0407', 'JOHN', '  ', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512227272, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(240, 7, 'IK0330', 'PATRICK', 'MUKOSE', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0845', 0, '24000000.00', 100, '', 0, 1512227298, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(241, 7, 'IK0408', 'JUSTIN', 'NAMUSUSWA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512227319, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(242, 7, 'IK0410', 'RUTH', 'NABIRYE', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 0, 1512227372, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(243, 7, 'IK0411', 'KAWUDA', '  ', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0069', 0, '40000000.00', 100, '', 8, 1512227567, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(244, 7, 'IK0331', ' ', 'MEDI', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.1052', 0, '24000000.00', 100, '', 8, 1512227921, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(245, 7, 'IK0412', 'HANIFAH', 'NABIRYE', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0084', 0, '40000000.00', 100, '', 8, 1512227971, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(246, 7, 'IK0413', 'JOWALI', 'GAVAMUKULYA', '', '', 33, 0, 3, 14, 25, '1', '0.0000', '0.0000', '0.0083', 0, '40000000.00', 100, '', 8, 1512228025, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(247, 7, 'IK0414', 'TEDIYA', 'MALIKUBU', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0089', 0, '40000000.00', 100, '', 8, 1512228075, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(248, 7, 'IK0415', 'KADIJA', 'MUGENDI', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0073', 0, '40000000.00', 100, '', 8, 1512228139, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(249, 7, 'IK0416', 'KYEFUSE', '  ', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0075', 0, '40000000.00', 100, '', 8, 1512228177, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(250, 7, 'IK0417', 'DAFARI', 'MUGENDI', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0094', 0, '40000000.00', 100, '', 8, 1512228239, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(251, 7, 'IK0418', 'JESCA', 'NAMAGANDA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0079', 0, '40000000.00', 100, '', 8, 1512228284, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(252, 7, 'IK0419', 'MUGENDI', 'BWANIKA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0058', 0, '40000000.00', 100, '', 8, 1512228329, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(253, 7, 'IK0420', 'UKNOWN', '  ', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0016', 0, '40000000.00', 100, '', 8, 1512228362, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(254, 7, 'IK0421', 'EZRA', 'KIBUMBA', '', '', 33, 0, 3, 13, 21, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512228401, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(255, 7, 'IK0332', 'STEVEN', 'BIRUMA', '', '0770805876', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0622', 0, '24000000.00', 100, '', 8, 1512228430, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(256, 7, 'IK0422', 'MUHAMMAD', 'KASIGALA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0429', 0, '40000000.00', 100, '', 8, 1512228584, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(257, 7, 'IK0135', 'ISSA', 'MPATA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0175', 0, '32000000.00', 100, '', 8, 1512228640, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(258, 7, 'IK0423', 'KAYERA', 'NAMIVULE', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0092', 0, '40000000.00', 100, '', 8, 1512228677, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(259, 7, 'IK0424', 'UNKNOWN', '  ', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512228713, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(260, 7, 'IK0136', 'HAMISI', 'MUSIGIRE', '', '0776128564', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0068', 0, '32000000.00', 100, '', 8, 1512228713, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(261, 7, 'IK0425', 'RUKUMI', 'MAJIDU', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0093', 0, '40000000.00', 100, '', 8, 1512228778, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(262, 7, 'IK0137', 'SAM', 'IBANDA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0077', 0, '32000000.00', 100, '', 8, 1512228790, 1, '2017-12-15 09:55:41', 1, 'DISTRIBUTION LINE', 1),
(263, 7, 'IK0426', 'SINGO', 'MOHAMMAD', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0044', 0, '40000000.00', 100, '', 8, 1512228879, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(264, 7, 'IK0427', 'AYINA', ' ', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0041', 0, '40000000.00', 100, '', 8, 1512228908, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(265, 7, 'IK0428', 'AUSI', 'HILALI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0063', 0, '40000000.00', 100, '', 8, 1512228965, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(266, 7, 'IK0138', 'UNKNOWN', ' ', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0046', 0, '32000000.00', 100, '', 8, 1512228982, 1, '2017-12-15 09:55:41', 1, 'DISTRIBUTION LINE', 1),
(267, 7, 'IK0429', 'BASOGA', 'BABUNDU', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0151', 0, '40000000.00', 100, '', 0, 1512229008, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(268, 7, 'IK0430', 'FRED', 'NABUGUZI FRED', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0092', 0, '40000000.00', 100, '', 0, 1512229120, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(269, 7, 'IK0431', 'SINGO', 'MOHAMMAD', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0071', 0, '40000000.00', 100, '', 0, 1512229163, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(270, 7, 'IK0432', 'ABASI', 'MUSOBYA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0043', 0, '40000000.00', 100, '', 0, 1512229225, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(271, 7, 'IK0434', 'SHEIK', 'MAKA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 0, 1512229290, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(272, 7, 'IK0435', 'TWAKA', 'IVULABI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0025', 0, '40000000.00', 100, '', 0, 1512229335, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(273, 7, 'IK0436', 'WILBER', 'KAGOYA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0041', 0, '40000000.00', 100, '', 0, 1512229387, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(274, 7, 'IK0437', 'KISIMIZI', 'MOHAMMAD', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0040', 0, '40000000.00', 100, '', 8, 1512229443, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(275, 7, 'IK0139', 'CHARLES', 'MAGUMBA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0047', 0, '32000000.00', 100, '', 8, 1512229661, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(276, 7, 'IK0438', 'MUSA', 'KILINDONI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0094', 0, '40000000.00', 100, '', 8, 1512229686, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(277, 7, 'IK0439', 'KAGOYE', 'WILBER', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0148', 0, '40000000.00', 100, '', 8, 1512229724, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(278, 7, 'IK0440', 'SIRAJE', ' ', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0121', 0, '40000000.00', 100, '', 8, 1512229811, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1);
INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, `chainage`, `tenure`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`, `active`) VALUES
(279, 7, 'IK0140', 'JANE', 'BABIGUMIRA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0103', 0, '32000000.00', 100, '', 8, 1512229857, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(280, 7, 'IK0441', 'ZAITUN', 'NABIRYE', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0092', 0, '40000000.00', 100, '', 8, 1512229892, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(281, 7, 'IK0442', 'NANTABA', 'NASANDA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0061', 0, '40000000.00', 100, '', 8, 1512229967, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(282, 7, 'IK0141', 'HASSAN', 'LAZIA HAJATI', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0179', 0, '32000000.00', 100, '', 8, 1512230004, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(283, 7, 'IK0443', 'SAAD', 'WAGOINA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0458', 0, '40000000.00', 100, '', 8, 1512230043, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(284, 7, 'IK0444', 'ANTHONY', 'SILINGI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0360', 0, '40000000.00', 100, '', 8, 1512230100, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(286, 7, 'IK0445', 'HAMZA', 'KIMPO', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0205', 0, '40000000.00', 100, '', 8, 1512230147, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(287, 7, 'IK0446', 'SAADI', 'WAGOINA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0248', 0, '40000000.00', 100, '', 8, 1512230189, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(288, 7, 'IK0447', 'BRUHAN', 'VUNIKA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0068', 0, '40000000.00', 100, '', 8, 1512230226, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(289, 7, 'IK0448', 'SIRAJE', 'KAGOYE', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0069', 0, '40000000.00', 100, '', 8, 1512230270, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(290, 7, 'IK0142', 'STEPHEN', 'BALIDAWA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0117', 0, '32000000.00', 100, '', 8, 1512230344, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(291, 7, 'IK0449', 'KAPATA', 'MUSA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0067', 0, '40000000.00', 100, '', 0, 1512230357, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(292, 7, 'IK0450', 'JANET', ' ', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0080', 0, '40000000.00', 100, '', 0, 1512230412, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(293, 7, 'IK0451', 'AAMANZANI', ' ', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0071', 0, '40000000.00', 100, '', 0, 1512230451, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(294, 7, 'IK0452', 'NGOBI', 'ZUBAIRI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 0, 1512230489, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(295, 7, 'IK0143', 'AKANYE', ' ', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0123', 0, '32000000.00', 100, '', 8, 1512230528, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(296, 7, 'IK0453', 'ISA', 'NAMPALA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0041', 0, '40000000.00', 100, '', 8, 1512230539, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(297, 7, 'IK0144', 'JABERI', 'GOBEYANGA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0034', 0, '32000000.00', 100, '', 8, 1512230613, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(298, 7, 'IK0454', 'KILINDOLI', 'SWAMITI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0027', 0, '40000000.00', 100, '', 8, 1512230752, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(299, 7, 'IK0455', 'MUSA', 'KIKULUBIRI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0040', 0, '40000000.00', 100, '', 8, 1512230801, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(300, 7, 'IK0456', 'IBRAHIM', 'NABIGUZI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0044', 0, '40000000.00', 100, '', 8, 1512230858, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(301, 7, 'IK0457', 'BADRU', 'KIRAMU', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0079', 0, '40000000.00', 100, '', 8, 1512230895, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(302, 7, 'IK0458', 'MOSES', 'ZIKUSOKA', 'KAMOME', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0500', 0, '40000000.00', 100, '', 8, 1512230988, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(303, 7, 'IK0459', 'LUKANDWA', 'MUSIMAMI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0100', 0, '40000000.00', 100, '', 8, 1512231039, 1, '2017-12-15 09:55:57', 1, 'DISTRIBUTION LINE', 1),
(304, 7, 'IK0460', 'AWALI', 'TIBWITA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0249', 0, '40000000.00', 100, '', 8, 1512231157, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(305, 7, 'IK0462', 'BAWA ', 'ROBINAH', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0911', 0, '40000000.00', 100, '', 8, 1512231300, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(306, 7, 'IK0463', 'UNKNOWN', '  ', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0071', 0, '40000000.00', 100, '', 8, 1512231384, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(307, 7, 'IK0464', 'PATRICK', 'NYONYINTONO', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0132', 0, '40000000.00', 100, '', 8, 1512231429, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(308, 7, 'IK0465', 'WAKO', 'BYASALI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0027', 0, '40000000.00', 100, '', 8, 1512231472, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(309, 7, 'IK0466', 'UNKNOWN', '  ', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0040', 0, '40000000.00', 100, '', 8, 1512231499, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(310, 7, 'IK0467', 'MUGABI', 'WALUNSANSA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0097', 0, '40000000.00', 100, '', 8, 1512231548, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(311, 7, 'IK0145', 'NASSER ABDU', 'WANDIRA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0099', 0, '32000000.00', 100, '', 8, 1512231549, 1, '2017-12-15 09:55:41', 1, 'Select comment ...', 1),
(312, 7, 'IK0468', 'AKAMADA', 'WALUNSANSA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0102', 0, '40000000.00', 100, '', 8, 1512231596, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(313, 7, 'IK0146', 'PETER', 'BAMUTAZE', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0092', 0, '32000000.00', 100, '', 8, 1512231786, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(314, 7, 'IK0469', 'BYAKIKA', 'BAKAFUTE', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0291', 0, '40000000.00', 100, '', 0, 1512231786, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(315, 7, 'IK0147', 'ASUMAN', 'MUSULO', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0054', 0, '32000000.00', 100, '', 8, 1512231827, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(316, 7, 'IK0148', 'PETER', 'KITI', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0063', 0, '32000000.00', 100, '', 8, 1512231863, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(317, 7, 'IK0149', 'EDISA', 'NABIRYE MUTESI', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0034', 0, '32000000.00', 100, '', 8, 1512231909, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(318, 7, 'IK0470', 'SABASI', 'AKAMADA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0069', 0, '40000000.00', 100, '', 8, 1512231931, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(319, 7, 'IK0150', 'JAMES', 'DYOGO', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0098', 0, '32000000.00', 100, '', 8, 1512231947, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(320, 7, 'IK0471', 'BASOGA', 'TIBWITA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0036', 0, '40000000.00', 100, '', 8, 1512231977, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(321, 7, 'IK0151', 'GRACE', 'ALIBAWO', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0116', 0, '32000000.00', 100, '', 8, 1512231995, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(322, 7, 'IK0472', 'BADU', 'KAYIMBWA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0033', 0, '40000000.00', 100, '', 8, 1512232057, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(323, 7, 'IK0473', 'NASAN', 'NGOLOYA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0089', 0, '40000000.00', 100, '', 8, 1512232093, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(324, 7, 'IK0474', 'ABDU', 'BAZALE', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0109', 0, '40000000.00', 100, '', 8, 1512232125, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(325, 7, 'IK0152', 'SYLIVESTER', 'OGAYA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0077', 0, '32000000.00', 100, '', 8, 1512232185, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(326, 7, 'IK0475', 'WAISWA', 'NDIMULODI', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0361', 0, '40000000.00', 100, '', 8, 1512232189, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(327, 7, 'IK0476', 'MAKA', 'TALENGA', '', '', 33, 0, 3, 13, 22, '1', '0.0000', '0.0000', '0.0317', 0, '40000000.00', 100, '', 8, 1512232250, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(328, 7, 'IK0153', 'JAMES', 'DYOGO', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0201', 0, '32000000.00', 100, '', 8, 1512232456, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(329, 7, 'IK0154', 'PETER', 'GAAVA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0078', 0, '32000000.00', 100, '', 8, 1512232798, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(330, 7, 'IK0155', 'ROBERT', 'MAGANDA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0036', 0, '32000000.00', 100, '', 8, 1512233196, 1, '2017-12-15 09:55:42', 1, 'Select comment ...', 1),
(331, 7, 'IK0156', 'BAKALI', 'MAGOLA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0365', 0, '32000000.00', 100, '', 8, 1512233276, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(332, 7, 'IK0157', 'AHAMADA', 'SINANI', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0075', 0, '32000000.00', 100, '', 8, 1512233330, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(333, 7, 'IK0158', 'ZAWUMA', 'DALAWUSI', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0046', 0, '32000000.00', 100, '', 8, 1512233416, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(334, 7, 'IK0159', 'KISULE', 'MAGOOLA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0035', 0, '32000000.00', 100, '', 8, 1512233683, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(335, 7, 'IK0160', 'UNKNOWN', ' ', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0053', 0, '32000000.00', 100, '', 8, 1512234032, 1, '2017-12-15 09:55:42', 1, 'Select comment ...', 1),
(336, 7, 'IK0161', 'FAHAD', 'KASOLO', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0076', 0, '32000000.00', 100, '', 8, 1512234188, 1, '2017-12-15 09:55:42', 1, 'Select comment ...', 1),
(337, 7, 'IK0162', 'MEDI', 'ABUBAKARI WAKINYANKARI', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0063', 0, '32000000.00', 100, '', 8, 1512234357, 1, '2017-12-15 09:55:42', 1, 'Select comment ...', 1),
(338, 7, 'IK0163', 'SONIWA', 'KAFULU', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0042', 0, '32000000.00', 100, '', 8, 1512234415, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(339, 7, 'IK0164', 'ISMA', 'MALINZI', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0048', 0, '32000000.00', 100, '', 8, 1512234489, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(340, 7, 'IK0165', 'EVA', ' ', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0066', 0, '32000000.00', 100, '', 8, 1512234566, 1, '2017-12-15 09:55:42', 1, 'Select comment ...', 1),
(341, 7, 'IK0166', 'JESSICA', ' ', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0043', 0, '32000000.00', 100, '', 8, 1512234629, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(342, 7, 'IK0167', 'MOHAMMED ', 'KASENSE', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0060', 0, '32000000.00', 100, '', 8, 1512234880, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(343, 7, 'IK0168', 'SULAI', 'MPATA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0051', 0, '32000000.00', 100, '', 8, 1512234954, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(344, 7, 'IK0169', 'UNKNOWN', ' ', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0060', 0, '32000000.00', 100, '', 8, 1512235033, 1, '2017-12-15 09:55:42', 1, 'DISTRIBUTION LINE', 1),
(345, 7, 'IK0333', 'VICENT', 'WAIDAH', '', '0787654198', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.1498', 0, '24000000.00', 100, '', 8, 1512235088, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(346, 7, 'IK0170', 'SADAT', 'MPANSO', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0061', 0, '32000000.00', 100, '', 8, 1512235129, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(347, 7, 'IK0334', 'FESTO', 'FALIJALA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.1257', 0, '24000000.00', 100, '', 8, 1512235171, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(348, 7, 'IK0335', ' ', 'NABIRYE', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0613', 0, '24000000.00', 100, '', 8, 1512235239, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(349, 7, 'IK0336', ' ', 'UNKNOWN', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0077', 0, '24000000.00', 100, '', 8, 1512235318, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(350, 7, 'IK0337', 'JOHN', 'KISOWE', 'ALEX', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0000', 0, '24000000.00', 0, '', 9, 1512235414, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(351, 7, 'IK0338', 'LUKOWE', 'BUWONGO', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0719', 0, '24000000.00', 100, '', 8, 1512235491, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(352, 7, 'IK0171', 'MANUEL', 'MUKAMA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0205', 0, '32000000.00', 100, '', 8, 1512235571, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(353, 7, 'IK0340', 'STEVEN', 'BARUMA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0196', 0, '24000000.00', 100, '', 8, 1512235638, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(354, 7, 'IK0341', 'RICHARD', 'MAKA', 'BULANTI', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0000', 0, '0.00', 0, '', 8, 1512235800, 1, '2017-12-02 17:30:00', 1, 'Select comment ...', 1),
(355, 7, 'IK0172', 'STEVEN', 'MULYOWA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0059', 0, '32000000.00', 100, '', 8, 1512235882, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(356, 7, 'IK0343', 'SAMUEL', 'ISABIRYE', '', '0773866681', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0085', 0, '24000000.00', 100, '', 8, 1512235885, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(357, 7, 'IK0344', 'MOHAMMAD', 'KASULE', '', '0774634563', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0081', 0, '24000000.00', 100, '', 8, 1512235960, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(358, 7, 'IK0173', 'ABDALLAH AZIZ', 'TEFFE', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0123', 0, '32000000.00', 100, '', 8, 1512236003, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(359, 7, 'IK0345', 'NASANAILI', 'WALUBE', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0232', 0, '24000000.00', 100, '', 8, 1512236016, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(360, 7, 'IK0346', 'MUWADA', 'BAKITWALE', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0190', 0, '24000000.00', 100, '', 8, 1512236071, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(362, 7, 'IK0347', ' ', 'TENYWA', 'MRS', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0133', 0, '24000000.00', 100, '', 8, 1512236115, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(363, 7, 'IK0348', 'PETER', 'KAYONGO', 'PASTOR', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0087', 0, '24000000.00', 100, '', 8, 1512236165, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(364, 7, 'IK0349', 'PATI', 'MINJO', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0055', 0, '24000000.00', 100, '', 8, 1512236350, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(365, 7, 'IK0350', 'AIDAH', 'NAKANDA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0228', 0, '24000000.00', 100, '', 0, 1512236426, 1, '2017-12-15 09:55:51', 1, 'Select comment ...', 1),
(366, 7, 'IK0352', 'ISA', 'ISABIRYE', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512236564, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(367, 7, 'IK0353', 'PATRICK', 'GAIGULO', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0099', 0, '24000000.00', 100, '', 8, 1512236635, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(368, 7, 'IK0354', 'JABERI', 'NGOBI', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0080', 0, '24000000.00', 100, '', 8, 1512236674, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(369, 7, 'IK0355', 'KADIR', 'MPATA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0077', 0, '24000000.00', 100, '', 8, 1512236724, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(370, 7, 'IK0356', 'MARTIN', 'WALUBE', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0098', 0, '24000000.00', 100, '', 0, 1512236796, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(371, 7, 'IK0358', ' ', 'UNKNOWN', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0083', 0, '24000000.00', 100, '', 8, 1512236860, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(372, 7, 'IK0358', 'MUWADA', 'BAKITWALE', '', '0784539035', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0083', 0, '24000000.00', 100, '', 0, 1512236924, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(373, 7, 'IK0359', 'AMINAH', 'NAMUSOBYA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0095', 0, '24000000.00', 100, '', 8, 1512236988, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(374, 7, 'IK0360', 'PATRICK', 'WAKABI', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0061', 0, '24000000.00', 100, '', 8, 1512237035, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(375, 7, 'IK0361', 'BENEFANSIO', 'WANDERA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512237110, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(376, 7, 'IK0362', 'KADIR', 'NGOBI', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0060', 0, '24000000.00', 100, '', 8, 1512237159, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(377, 7, 'IK0363', 'ROBINAH', 'EBIFA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0312', 0, '24000000.00', 100, '', 0, 1512237223, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(378, 7, 'IK0175', 'BENADIN', 'BASADE', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0530', 0, '32000000.00', 100, '', 8, 1512237238, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(379, 7, 'IK0176', 'BRENDA', 'MAMA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0201', 0, '32000000.00', 100, '', 8, 1512237393, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(380, 7, 'IK0364', 'STEVEN', 'KEMBA', '', '', 33, 0, 3, 14, 23, '1', '0.0000', '0.0000', '0.0242', 0, '24000000.00', 100, '', 0, 1512237454, 1, '2017-12-15 09:55:52', 1, 'Select comment ...', 1),
(381, 7, 'IK0177', 'PETER', 'GAAVA', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0588', 0, '32000000.00', 100, '', 8, 1512237470, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(382, 7, 'IK0178', 'AMOS', 'KABUGUTE', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0188', 0, '32000000.00', 100, '', 8, 1512237635, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(383, 7, 'IK0179', 'BENADINI', 'BASADDE', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0190', 0, '32000000.00', 100, '', 8, 1512237735, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(384, 7, 'IK0180', 'JAMES', 'DYOGO', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0742', 0, '32000000.00', 100, '', 8, 1512237885, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(385, 7, 'IK0181', 'NIGHT', 'ZAAKE', '', '', 33, 0, 3, 14, 16, '1', '0.0000', '0.0000', '0.0381', 0, '32000000.00', 100, '', 8, 1512238008, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(386, 7, 'IK1319', 'KALIRO VOCATIONAL SECONDARY SCHOOL', ' ', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0282', 0, '56000000.00', 100, '', 8, 1512290761, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(387, 7, 'IK0494', 'NUMUNGALWE TOWN BOARD MARKET', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0220', 0, '40000000.00', 100, '', 0, 1512290937, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(388, 7, 'IK0495', 'BILALI', 'BASALIRWA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0071', 0, '40000000.00', 100, '', 0, 1512290986, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(389, 7, 'IK1320', 'SAMUEL', 'BWOYE', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0309', 0, '56000000.00', 100, '', 8, 1512291014, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(390, 7, 'IK0496', 'SARAH ', 'MAWAGOLE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0020', 0, '40000000.00', 100, '', 0, 1512291029, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(391, 7, 'IK0497', 'HAJJI', 'BIN', 'ARAJAB', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0179', 0, '40000000.00', 100, '', 0, 1512291075, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(392, 7, 'IK0498', 'FARUKU', 'KYATE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0015', 0, '40000000.00', 100, '', 0, 1512291115, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(393, 7, 'IK0499', 'DAUDI', 'KIVAINUMA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0060', 0, '40000000.00', 100, '', 0, 1512291170, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(394, 7, 'IK1321', 'FRED', 'ISOOBA', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0083', 0, '56000000.00', 100, '', 8, 1512291192, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(395, 7, 'IK0500', 'ARAMANZAN', 'ISABIRYE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 0, 1512291211, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(396, 7, 'IK0501', 'DAMUTUDA', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0071', 0, '40000000.00', 100, '', 0, 1512291264, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(397, 7, 'IK1322', 'SAMUEL', 'BWOYE', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0104', 0, '56000000.00', 100, '', 8, 1512291335, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(398, 7, 'IK0502', 'PAUL', 'TAGINGWA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0073', 0, '40000000.00', 100, '', 0, 1512291362, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(399, 7, 'IK1323', 'MOSES', 'KUNYA', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0124', 0, '56000000.00', 100, '', 8, 1512291400, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(400, 7, 'IK0503', 'BAKARI', 'MUGABO', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0026', 0, '40000000.00', 100, '', 0, 1512291402, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(401, 7, 'IK1324', 'STEVEN', 'KISIRA', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0210', 0, '56000000.00', 100, '', 8, 1512291469, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(402, 7, 'IK1325', 'MICHEAL', 'KUNYA', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0368', 0, '56000000.00', 100, '', 8, 1512291538, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(403, 7, 'IK1326', ' ', 'SSEKANDI', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0190', 0, '56000000.00', 100, '', 8, 1512291580, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(404, 7, 'IK0504', 'BAZIBU', 'ISABIRYE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0024', 0, '40000000.00', 100, '', 8, 1512291586, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(405, 7, 'IK1327', 'DAVID', 'MUGABI', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0225', 0, '56000000.00', 100, '', 8, 1512291649, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(406, 7, 'IK1328', 'GEORGE', 'KAFUKO', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0223', 0, '56000000.00', 100, '', 8, 1512291710, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(407, 7, 'IK1329', 'SATELITE NURSERY & PRIMARY SCHOOL', ' ', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0163', 0, '56000000.00', 100, '', 8, 1512291783, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(408, 7, 'IK0505', 'EZEREYA', 'MAGUMBA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0078', 0, '40000000.00', 100, '', 8, 1512291816, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(409, 7, 'IK1330', 'ASUMAN', 'BYANSI', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0090', 0, '56000000.00', 100, '', 8, 1512291844, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(410, 7, 'IK0506', 'LUSALILA', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0118', 0, '40000000.00', 100, '', 8, 1512291846, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(411, 7, 'IK0507', 'ALI', 'KABANZA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0043', 0, '40000000.00', 100, '', 8, 1512291881, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(412, 7, 'IK1331', 'FRANCIS', 'TENYWA', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0100', 0, '56000000.00', 100, '', 0, 1512291881, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(413, 7, 'IK0508', 'HAJJI', 'IBRAHIM', 'WAVAMUNO', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0034', 0, '40000000.00', 100, '', 8, 1512291927, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(414, 7, 'IK1332', 'ROBERT', 'KYOBE', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0060', 0, '56000000.00', 100, '', 8, 1512291961, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(415, 7, 'IK0509', 'HAKIM', 'TELIKYA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0025', 0, '40000000.00', 100, '', 8, 1512291973, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(416, 7, 'IK0510', 'MOSES', 'GYAGENDA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512292007, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(417, 7, 'IK0511', 'GODFREY', 'WAIBI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0071', 0, '40000000.00', 100, '', 8, 1512292047, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(418, 7, 'IK0512', 'FRED', 'TIBABONEKA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0049', 0, '40000000.00', 100, '', 8, 1512292085, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(419, 7, 'IK1333', 'KAFUKU', 'KADAMA', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0049', 0, '56000000.00', 100, '', 8, 1512292113, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(420, 7, 'IK1334', 'GEOFFREY', 'BEEYO', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0087', 0, '56000000.00', 100, '', 8, 1512292191, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(421, 7, 'IK0513', 'CHRISTOPHER', 'KAMBUZI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0054', 0, '40000000.00', 100, '', 8, 1512292256, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(422, 7, 'IK1335', 'SAMUEL', 'KAASALA', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 8, 1512292271, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(423, 7, 'IK0514', 'DAVID', 'GAKWIRA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512292295, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(424, 7, 'IK0515', 'GUKINA', 'SEMU ISABIRYE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0068', 0, '40000000.00', 100, '', 8, 1512292329, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(425, 7, 'IK0516', 'DANIEL', 'KAWEMBA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0056', 0, '40000000.00', 100, '', 8, 1512292364, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(426, 7, 'IK0517', 'PAUL', 'KAMBUZI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512292398, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(427, 7, 'IK1337', 'KALIRO FOREST RESERVE', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0916', 0, '56000000.00', 100, '', 8, 1512292414, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(428, 7, 'IK0518', 'SARAH', 'NANGOBI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512292436, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(429, 7, 'IK0519', 'FESTO', 'WAISWA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512292462, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(430, 7, 'IK1338', 'ROBERT', 'NANTAMU', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0656', 0, '56000000.00', 100, '', 8, 1512292473, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(431, 7, 'IK0520', 'ROBERT', 'MUSANA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0058', 0, '40000000.00', 100, '', 8, 1512292497, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(432, 7, 'IK1339', 'DAVID', 'MUKOOMA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0380', 0, '56000000.00', 100, '', 8, 1512292542, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(433, 7, 'IK0521', 'MOSES ', 'MUGABI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0056', 0, '40000000.00', 100, '', 8, 1512292548, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(434, 7, 'IK0522', 'YOSAM', 'BAWOLE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0114', 0, '40000000.00', 100, '', 8, 1512292580, 1, '2017-12-15 09:56:00', 1, 'DISTRIBUTION LINE', 1),
(435, 7, 'IK1340', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0076', 0, '56000000.00', 100, '', 8, 1512292621, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(436, 7, 'IK0182', 'THOMAS', 'NAAKU', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0374', 0, '32000000.00', 100, '', 8, 1512292650, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(437, 7, 'IK0524', 'HAKIM', 'ISABIRYE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0065', 0, '40000000.00', 100, '', 8, 1512292675, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(438, 7, 'IK0525', 'MUSENZE', ' ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512292706, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(439, 7, 'IK0526', 'MWANJA', 'MOSES', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0034', 0, '40000000.00', 100, '', 8, 1512292746, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(440, 7, 'IK1341', 'YAIRO', 'IDAILA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0076', 0, '56000000.00', 100, '', 8, 1512292747, 1, '2017-12-15 09:56:47', 1, 'DISTRIBUTION LINE', 1),
(441, 7, 'IK0527', 'PAUL', 'MALWA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0035', 0, '40000000.00', 100, '', 8, 1512292779, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(442, 7, 'IK0183', 'SAIDI', 'MUGOYA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0160', 0, '32000000.00', 100, '', 8, 1512292790, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(443, 7, 'IK0528', 'SEMU', 'WAISWA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512292807, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(444, 7, 'IK1342', 'MULANE', 'KASOLO', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0235', 0, '56000000.00', 100, '', 8, 1512292809, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(445, 7, 'IK0184', 'SULA', 'WAISWA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0124', 0, '32000000.00', 100, '', 8, 1512292826, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(446, 7, 'IK0529', 'CHRISTOPHER', 'NYANGA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512292857, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(447, 7, 'IK1343', 'TWAHA', 'YALABI', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0086', 0, '56000000.00', 100, '', 8, 1512292859, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(448, 7, 'IK0530', 'MUSA', 'MUGABO', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512292913, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(449, 7, 'IK1344', 'SAUYA', 'ALIYINZA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0171', 0, '56000000.00', 100, '', 8, 1512292937, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(450, 7, 'IK0185', 'TENYWA', 'AGI', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0124', 0, '32000000.00', 100, '', 8, 1512292938, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(451, 7, 'IK0531', 'HAJJI', 'NDEYAWO MUHAMMAD', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512292959, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(452, 7, 'IK0532', 'SAMUEL', 'WABI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0060', 0, '40000000.00', 100, '', 8, 1512292992, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(453, 7, 'IK1345', 'ABU', 'WAVAMUNNO', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0147', 0, '56000000.00', 100, '', 8, 1512293015, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(454, 7, 'IK1346', ' ', 'KAPERE', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0077', 0, '56000000.00', 100, '', 8, 1512293057, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(455, 7, 'IK0533', 'YOKOLAM', 'TENYWA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0074', 0, '40000000.00', 100, '', 8, 1512293068, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(456, 7, 'IK1347', 'GODFREY', 'NGOBI', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0069', 0, '56000000.00', 100, '', 8, 1512293144, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(457, 7, 'IK1348', 'DANIEL', 'TUSA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0043', 0, '56000000.00', 100, '', 8, 1512293222, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(458, 7, 'IK0534', 'FRED', 'TIBABONEKA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0053', 0, '40000000.00', 100, '', 8, 1512293262, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(459, 7, 'IK1349', 'MARGRET', 'NAPERA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0064', 0, '56000000.00', 100, '', 0, 1512293287, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(460, 7, 'IK0535', 'JOSHUA', 'KALAMAWO', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0062', 0, '40000000.00', 100, '', 8, 1512293295, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(461, 7, 'IK0536', 'MOSES', 'BAGANIGIRA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0059', 0, '40000000.00', 100, '', 8, 1512293358, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(462, 7, 'IK0537', 'MIRIA', 'KHISA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0061', 0, '40000000.00', 100, '', 8, 1512293401, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(463, 7, 'IK1350', 'CONSITANT', 'BATEGANYA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0100', 0, '56000000.00', 100, '', 8, 1512293431, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(464, 7, 'IK0538', 'DANIEL', 'KIWEMBA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0065', 0, '40000000.00', 100, '', 8, 1512293439, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(465, 7, 'IK0539', 'PATRICK', 'IGUMBA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0056', 0, '40000000.00', 100, '', 8, 1512293475, 1, '2017-12-15 09:56:01', 1, 'DISTRIBUTION LINE', 1),
(466, 7, 'IK0540', 'MOSES', 'BASOMA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0056', 0, '40000000.00', 100, '', 8, 1512293511, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(467, 7, 'IK1351', ' ', 'FUMBA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0036', 0, '56000000.00', 100, '', 8, 1512293517, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(468, 7, 'IK0541', 'NAMUNGALWE MOSQUE', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.1585', 0, '40000000.00', 100, '', 8, 1512293561, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(469, 7, 'IK0542', 'SULAI', 'MUTWALUME', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0054', 0, '40000000.00', 100, '', 8, 1512293600, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(470, 7, 'IK0543', 'FRED', 'MUTEBE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0020', 0, '40000000.00', 100, '', 8, 1512293631, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(471, 7, 'IK0544', 'PATRICK', 'KYEWE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512293667, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(472, 7, 'IK0545', 'KAMUGWAILE', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0060', 0, '40000000.00', 100, '', 8, 1512293699, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(473, 7, 'IK0546', 'JOSHUA', 'KALAMAWO', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0130', 0, '40000000.00', 100, '', 8, 1512293735, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(474, 7, 'IK0547', 'MUSA', 'SWAMITI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0131', 0, '40000000.00', 100, '', 8, 1512293766, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(475, 7, 'IK0548', 'ELIZABETH', 'BASILIKA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512293806, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(476, 7, 'IK0549', 'WILLIAM', 'MUTAKI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512293837, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(477, 7, 'IK1353', 'MALINZI', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0031', 0, '56000000.00', 100, '', 8, 1512293853, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(478, 7, 'IK0550', 'UNKNOWN', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0024', 0, '40000000.00', 100, '', 8, 1512293883, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(480, 7, 'IK0555', 'UNIVERSAL APOSTLE FELLOWSHIP CHURCH', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0031', 0, '40000000.00', 100, '', 8, 1512294092, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(481, 7, 'IK0556', 'SWAMITI', 'ZILONDOMU', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512294137, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(482, 7, 'IK0557', 'JOSHUA', 'MUSALALIRA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512294177, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(483, 7, 'IK0973', 'SINAN', 'TENYWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0215', 0, '24000000.00', 100, '', 8, 1512294224, 1, '2017-12-15 09:56:27', 1, 'DISTRIBUTION LINE', 1),
(484, 7, 'IK0558', 'MUGABO', 'BUMALI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0053', 0, '40000000.00', 100, '', 8, 1512294241, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(485, 7, 'IK0559', 'KIDUKA', 'NALUKO', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0047', 0, '40000000.00', 100, '', 8, 1512294270, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(487, 7, 'IK0974', 'STEVEN', 'BASALIRWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0178', 0, '24000000.00', 100, '', 8, 1512294396, 1, '2017-12-15 09:56:28', 1, 'Select comment ...', 1),
(488, 7, 'IK0560', 'PATRICK', 'IGUMBA', 'MPINDU', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0045', 0, '40000000.00', 100, '', 8, 1512294474, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(489, 7, 'IK0975', 'EDIRISA', 'KASIBA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0023', 0, '24000000.00', 100, '', 8, 1512294480, 1, '2017-12-15 09:56:28', 1, 'Select comment ...', 1),
(490, 7, 'IK0561', 'REV. PATRICK', 'KEMBA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0060', 0, '40000000.00', 100, '', 8, 1512294510, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(491, 7, 'IK0562', 'ROBERT', 'ISABIRYE', 'WAISWA', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512294555, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(492, 7, 'IK0563', 'AISHA', ' KAGOYA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0044', 0, '40000000.00', 100, '', 8, 1512294625, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(493, 7, 'IK0564', 'SAM', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0027', 0, '40000000.00', 100, '', 8, 1512294657, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(494, 7, 'IK0565', 'IZIMBA', '  ', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0032', 0, '40000000.00', 100, '', 8, 1512294687, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(495, 7, 'IK1352', 'DAN', 'ISOLO', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0222', 0, '56000000.00', 100, '', 8, 1512294711, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(496, 7, 'IK0566', 'IGUMBA', 'PATRICK', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0032', 0, '40000000.00', 100, '', 8, 1512294730, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(497, 7, 'IK0976', 'CHARLES', 'KAGOYO', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0019', 0, '24000000.00', 100, '', 8, 1512294796, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(498, 7, 'IK0567', 'HENRY', 'BAZALE', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0032', 0, '40000000.00', 100, '', 8, 1512294875, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(499, 7, 'IK0568', 'FRED', 'MUWAWANI', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0039', 0, '40000000.00', 100, '', 8, 1512294918, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(500, 7, 'IK0977', 'IBRAHIM', 'MUMBYA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512294942, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(501, 7, 'IK0569', 'SAMUEL', 'BEYONGERA', '', '', 33, 0, 3, 13, 20, '1', '0.0000', '0.0000', '0.0057', 0, '40000000.00', 100, '', 0, 1512294977, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(502, 7, 'IK0978', 'CHRISTOPHER', 'MUKISA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0033', 0, '24000000.00', 100, '', 8, 1512295032, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(503, 7, 'IK1048', 'RICHARD ', 'MAGALA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0234', 0, '24000000.00', 100, '', 8, 1512295084, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(504, 7, 'IK0979', 'ZABINA', 'NANDASE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0031', 0, '24000000.00', 100, '', 8, 1512295222, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(505, 7, 'IK1049', 'BYANSI', 'YOKASI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0082', 0, '24000000.00', 100, '', 0, 1512295224, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(506, 7, 'IK0477', 'PAUL', 'KYEWUTA', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0144', 0, '40000000.00', 100, '', 8, 1512295241, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(507, 7, 'IK0478', 'JANE', 'BITALI', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0097', 0, '40000000.00', 100, '', 8, 1512295284, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(508, 7, 'IK0479', 'AGNES', 'MAGEMESO', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0054', 0, '40000000.00', 100, '', 8, 1512295316, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(509, 7, 'IK0980', 'BAKARI', 'NGOBI', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0024', 0, '24000000.00', 100, '', 8, 1512295332, 1, '2017-12-15 09:56:28', 1, 'Select comment ...', 1),
(510, 7, 'IK1050', 'GWOIITA', 'YONA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0078', 0, '24000000.00', 100, '', 0, 1512295350, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(511, 7, 'IK0480', 'STEVEN', 'KILIMUNGO', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512295376, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(512, 7, 'IK1354', 'MICHEAL', 'KITAWU', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0093', 0, '56000000.00', 100, '', 8, 1512295378, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(513, 7, 'IK0481', 'MOSES', 'MADYELO', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0162', 0, '40000000.00', 100, '', 8, 1512295413, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(514, 7, 'IK1051', 'MUSIITWA', 'MUSIITWA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0045', 0, '24000000.00', 100, '', 0, 1512295435, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(515, 7, 'IK0482', 'RICHARD', 'KITUNGULU', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512295446, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(516, 7, 'IK0981', 'UGANDA POLICE NAIBIRI', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0085', 0, '24000000.00', 100, '', 8, 1512295447, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(517, 7, 'IK0483', 'HAMZA', 'KAYIGWA', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0098', 0, '40000000.00', 100, '', 8, 1512295478, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(518, 7, 'IK0484', 'BAISI', 'WALUSANSA', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0098', 0, '40000000.00', 100, '', 8, 1512295524, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(519, 7, 'IK1052', 'BABOONA', 'NAKAZIBA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0070', 0, '24000000.00', 100, '', 0, 1512295525, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(520, 7, 'IK0485', 'JOSHUA', 'MBAGO', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0062', 0, '40000000.00', 100, '', 8, 1512295562, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(521, 7, 'IK0486', 'FARUKU', 'MADIBA', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512295596, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(522, 7, 'IK1355', 'RICHARD', 'BAWALYA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0047', 0, '56000000.00', 100, '', 8, 1512295617, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(523, 7, 'IK1053', 'BIKYUPA', 'TENYWA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0057', 0, '24000000.00', 100, '', 0, 1512295642, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(524, 7, 'IK1356', 'LIVINGSTONE', 'OBAME', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0052', 0, '56000000.00', 100, '', 8, 1512295659, 1, '2017-12-15 09:56:48', 1, 'DISTRIBUTION LINE', 1),
(525, 7, 'IK0982', 'MASJID UMAR NAIBIRI', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0131', 0, '24000000.00', 100, '', 8, 1512295680, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(526, 7, 'IK1357', 'ROBERT', 'GONZA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0046', 0, '56000000.00', 100, '', 8, 1512295749, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(527, 7, 'IK1054', 'BETTY', 'NABIRYE', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0045', 0, '24000000.00', 100, '', 0, 1512295753, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(528, 7, 'IK1358', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0044', 0, '56000000.00', 100, '', 8, 1512295785, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(529, 7, 'IK0487', 'HAMZA', 'KAYIGWA', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512295805, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(530, 7, 'IK1359', 'STEVEN', 'MALAILO', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0073', 0, '56000000.00', 100, '', 8, 1512295846, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(531, 7, 'IK0488', 'AYUB', 'BABO0LE', 'BAZIGU', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0044', 0, '40000000.00', 100, '', 8, 1512295849, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(532, 7, 'IK0983', 'ADAM', 'MUMBYA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0471', 0, '24000000.00', 100, '', 8, 1512295878, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(533, 7, 'IK0489', 'ADI', 'WAISWA', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0078', 0, '40000000.00', 100, '', 8, 1512295889, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(534, 7, 'IK1055', 'MUSUBO', 'BAGAAGA', 'LIVINGSTONE', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0056', 0, '24000000.00', 100, '', 0, 1512295889, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(535, 7, 'IK0186', 'JAMES', 'KAFUKO', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0155', 0, '32000000.00', 100, '', 8, 1512295906, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(536, 7, 'IK1360', 'LAWRENCE ', 'SAWUNDA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0074', 0, '56000000.00', 100, '', 8, 1512295915, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1);
INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, `chainage`, `tenure`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`, `active`) VALUES
(537, 7, 'IK0490', 'EDISA', 'KISADHA', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0123', 0, '40000000.00', 100, '', 8, 1512295930, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(538, 7, 'IK1361', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0232', 0, '56000000.00', 100, '', 8, 1512295951, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(539, 7, 'IK0491', 'NAIGAGA', 'NUUBI', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0298', 0, '40000000.00', 100, '', 0, 1512295963, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(540, 7, 'IK1056', 'MEGA', 'BAGEYA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0021', 0, '24000000.00', 100, '', 0, 1512295966, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(541, 7, 'IK0187', 'ISMAIL', 'WAISWA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0159', 0, '32000000.00', 100, '', 8, 1512295996, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(542, 7, 'IK1362', ' ', 'MONDOLO', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0169', 0, '56000000.00', 100, '', 8, 1512296023, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(543, 7, 'IK1057', 'JUMA', 'KAMANYA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0025', 0, '24000000.00', 100, '', 0, 1512296042, 1, '2017-12-15 09:56:31', 1, 'Select comment ...', 1),
(544, 7, 'IK1058', 'RESTY', 'NAKISANDA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0065', 0, '24000000.00', 100, '', 8, 1512296131, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(545, 7, 'IK0188', 'SHANON', 'KAFUKO', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0098', 0, '32000000.00', 100, '', 8, 1512296148, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(546, 7, 'IK0492', 'UNKNOWN', '  ', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0039', 0, '40000000.00', 100, '', 8, 1512296148, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(547, 7, 'IK0493', 'ZABIA', 'KULABA', '', '', 33, 0, 3, 21, 19, '1', '0.0000', '0.0000', '0.0015', 0, '40000000.00', 100, '', 8, 1512296193, 1, '2017-12-15 09:55:59', 1, 'DISTRIBUTION LINE', 1),
(548, 7, 'IK1059', 'TEZIKOMA', 'SULAYI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0027', 0, '24000000.00', 100, '', 8, 1512296216, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(549, 7, 'IK0984', 'EFULANSI ', 'NABIRYE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0077', 0, '24000000.00', 100, '', 8, 1512296266, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(550, 7, 'IK1060', 'RONALD', 'MUKISA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0078', 0, '24000000.00', 100, '', 8, 1512296274, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(551, 7, 'IK0189', 'RASHID', 'KYANGADA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0134', 0, '32000000.00', 100, '', 0, 1512296343, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(552, 7, 'IK1061', 'NANYUMBA', 'DAVID', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0036', 0, '24000000.00', 100, '', 8, 1512296349, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(553, 7, 'IK0985', 'ARAMANZAN', 'KAGWERI', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0062', 0, '24000000.00', 100, '', 8, 1512296373, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(554, 7, 'IK1378', 'MIRIO', 'NAMUGERE', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0051', 0, '56000000.00', 100, '', 8, 1512296410, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(555, 7, 'IK1062', 'AMUZA', 'KILOOBE', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512296439, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(556, 7, 'IK0986', 'KALUBA', 'LUGANDA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0142', 0, '24000000.00', 100, '', 8, 1512296455, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(557, 7, 'IK0190', 'BOSCO', 'BAGANZI', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0071', 0, '32000000.00', 100, '', 0, 1512296467, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(558, 7, 'IK1379', 'EDWARD', 'BAMUKYAYE', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0054', 0, '56000000.00', 100, '', 8, 1512296507, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(559, 7, 'IK1063', 'FARUKU', 'NGOBI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0040', 0, '24000000.00', 100, '', 8, 1512296515, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(560, 7, 'IK0987', 'BENHAN ', 'AYUB', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0062', 0, '24000000.00', 100, '', 8, 1512296553, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(561, 7, 'IK0570', 'PAUL', 'IGULO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0262', 0, '40000000.00', 100, '', 8, 1512296561, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(562, 7, 'IK1380', 'ASADI', 'BAGAHWILO', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0048', 0, '56000000.00', 100, '', 8, 1512296578, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(563, 7, 'IK1064', 'MAGALA', 'DHEYONGERA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0083', 0, '24000000.00', 100, '', 8, 1512296593, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(564, 7, 'IK0571', 'MAWA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512296595, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(565, 7, 'IK0572', 'KALIMU', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512296626, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(566, 7, 'IK1381', 'WILLY', 'SAMANYA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0065', 0, '56000000.00', 100, '', 8, 1512296632, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(567, 7, 'IK0573', 'YOSAM ', 'BALINA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0035', 0, '40000000.00', 100, '', 8, 1512296668, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(568, 7, 'IK1065', 'STONE', 'MAGUMBA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0124', 0, '24000000.00', 100, '', 8, 1512296671, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(569, 7, 'IK0988', 'ARAMANZAN', 'MUHAMMAD', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512296698, 1, '2017-12-15 09:56:28', 1, 'DISTRIBUTION LINE', 1),
(570, 7, 'IK1382', 'TOPISTA', 'BASILIKA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0073', 0, '56000000.00', 100, '', 8, 1512296706, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(571, 7, 'IK0574', 'TOM', 'SEMBERA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512296707, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(572, 7, 'IK0191', 'ANDREW', 'NSADA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0059', 0, '32000000.00', 100, '', 8, 1512296710, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(573, 7, 'IK1383', 'MULANE', 'KASOLO', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0386', 0, '56000000.00', 100, '', 8, 1512296750, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(574, 7, 'IK1066', 'WAIBALE ', 'TIGA', 'JACKSON', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0047', 0, '24000000.00', 100, '', 8, 1512296752, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(575, 7, 'IK0575', 'GEOFREY', 'MUGAYA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0035', 0, '40000000.00', 100, '', 8, 1512296759, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(576, 7, 'IK1384', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0144', 0, '56000000.00', 100, '', 8, 1512296785, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(577, 7, 'IK0989', 'YAKUB ', 'MUSANA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0352', 0, '24000000.00', 100, '', 8, 1512296801, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(579, 7, 'IK0576', 'BAKER', 'NGOBI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512296813, 1, '2017-12-15 09:56:03', 1, 'DISTRIBUTION LINE', 1),
(580, 7, 'IK1385', 'KALIRO COUNTRYSIDE RESORT', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0087', 0, '56000000.00', 100, '', 8, 1512296840, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(581, 7, 'IK0577', 'BAKARI', 'MUGAYA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0022', 0, '40000000.00', 100, '', 8, 1512296842, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(582, 7, 'IK0578', 'FRED', 'IGULO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0064', 0, '40000000.00', 100, '', 8, 1512296868, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(583, 7, 'IK1067', 'WILSON', 'NTUYO', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0065', 0, '24000000.00', 100, '', 8, 1512296880, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(584, 7, 'IK1386', 'UNKNOWN', '  ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0082', 0, '56000000.00', 100, '', 8, 1512296882, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(585, 7, 'IK0990', 'ROGERS', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512296892, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(586, 7, 'IK0579', 'EDIRISA', 'NDEYAWO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0031', 0, '40000000.00', 100, '', 8, 1512296906, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(587, 7, 'IK1068', 'GASIYA', 'IDUMA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0029', 0, '24000000.00', 100, '', 8, 1512296929, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(588, 7, 'IK0580', 'FALISKO', 'BAISEMUBAKA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512296958, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(589, 7, 'IK0581', 'TIBITA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0019', 0, '40000000.00', 100, '', 8, 1512296988, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(590, 7, 'IK1387', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0085', 0, '56000000.00', 100, '', 8, 1512297001, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(591, 7, 'IK1069', 'CHARLES', 'KWESI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0065', 0, '24000000.00', 100, '', 8, 1512297021, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(592, 7, 'IK0192', 'ISMA', 'WAKISOLO', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0227', 0, '32000000.00', 100, '', 0, 1512297021, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(593, 7, 'IK0582', 'MUNABI', '    ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0030', 0, '40000000.00', 100, '', 8, 1512297030, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(594, 7, 'IK1387', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0085', 0, '56000000.00', 100, '', 8, 1512297050, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(595, 7, 'IK0583', 'IMBODITE', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0219', 0, '40000000.00', 100, '', 8, 1512297072, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(596, 7, 'IK1070', 'TAAGULE', 'STONE', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0237', 0, '24000000.00', 100, '', 8, 1512297104, 1, '2017-12-15 09:56:32', 1, 'DISTRIBUTION LINE', 1),
(597, 7, 'IK1388', 'MUBARAK', 'BAGOMA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0095', 0, '56000000.00', 100, '', 8, 1512297150, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(598, 7, 'IK0584', 'BALIKOWA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0054', 0, '40000000.00', 100, '', 8, 1512297169, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(599, 7, 'IK1071', 'BABU', 'SANNI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0037', 0, '24000000.00', 100, '', 8, 1512297190, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(600, 7, 'IK0585', 'ANTHONY', 'KILIBAKI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0070', 0, '40000000.00', 100, '', 8, 1512297216, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(601, 7, 'IK1389', 'AUGUSTINE', 'TALENGA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0579', 0, '56000000.00', 100, '', 8, 1512297222, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(602, 7, 'IK0586', 'MUGABI', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0047', 0, '40000000.00', 100, '', 0, 1512297257, 1, '2017-12-15 09:56:04', 1, 'DISTRIBUTION LINE', 1),
(603, 7, 'IK1072', 'HUSSEIN', 'NAMUDALI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0036', 0, '24000000.00', 100, '', 8, 1512297270, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(604, 7, 'IK1073', 'BABU', 'SANNI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0041', 0, '24000000.00', 100, '', 8, 1512297328, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(605, 7, 'IK0193', 'ISA', 'KAYIDUMBI NGOBI', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0455', 0, '32000000.00', 100, '', 0, 1512297375, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(607, 7, 'IK1074', 'RICHARD ', 'MAGALA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0118', 0, '24000000.00', 100, '', 8, 1512297415, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(608, 7, 'IK1390', 'BUMANKOOLA MUSLIM PRIMARY SCHOOL', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.1061', 0, '56000000.00', 100, '', 8, 1512297461, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(609, 7, 'IK0991', 'SIRAJI', 'WAISWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0029', 0, '24000000.00', 100, '', 8, 1512297469, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(610, 7, 'IK1075', 'SUZAN', 'NAIGAGA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0056', 0, '24000000.00', 100, '', 8, 1512297481, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(611, 7, 'IK0194', 'MARTIN', 'KYITEMBO', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0153', 0, '32000000.00', 100, '', 0, 1512297511, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(612, 7, 'IK1391', 'SARAH', 'NAISAZA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0149', 0, '56000000.00', 100, '', 8, 1512297523, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(613, 7, 'IK0992', 'BAKARI', 'MUSOBYA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0055', 0, '24000000.00', 100, '', 8, 1512297534, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(614, 7, 'IK1076', 'STANLEY', 'BAMUWANIYE', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0034', 0, '24000000.00', 100, '', 8, 1512297560, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(615, 7, 'IK0195', 'BALIKOWA', 'MUGOGO', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0090', 0, '32000000.00', 100, '', 0, 1512297569, 1, '2017-12-15 09:55:43', 1, 'DISTRIBUTION LINE', 1),
(616, 7, 'IK1392', 'CHARLES', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0087', 0, '56000000.00', 100, '', 8, 1512297571, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(617, 7, 'IK0196', 'DASAN', 'MATENDE', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0076', 0, '32000000.00', 100, '', 0, 1512297613, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(618, 7, 'IK0993', 'MUHAMMAD', 'WAISWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0184', 0, '24000000.00', 100, '', 8, 1512297631, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(619, 7, 'IK1077', 'WILSON', 'NTUYO', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0074', 0, '24000000.00', 100, '', 8, 1512297642, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(621, 7, 'IK0587', 'KINTU', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0041', 0, '40000000.00', 100, '', 8, 1512297713, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(622, 7, 'IK1078', 'PATRICK', 'KYEBA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0024', 0, '24000000.00', 100, '', 8, 1512297724, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(623, 7, 'IK1393', 'GODFREY', 'KYOTANALYA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0100', 0, '56000000.00', 100, '', 8, 1512297726, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(624, 7, 'IK0197', 'MARTIN', 'KYITEMO', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0048', 0, '32000000.00', 100, '', 0, 1512297778, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(625, 7, 'IK0588', 'IVAN', 'IGULO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0036', 0, '40000000.00', 100, '', 8, 1512297784, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(626, 7, 'IK0994', 'GEORGE', 'WALUSANSA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0185', 0, '24000000.00', 100, '', 8, 1512297818, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(627, 7, 'IK1079', 'BATOOLE', 'SIITU', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0033', 0, '24000000.00', 100, '', 8, 1512297821, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(628, 7, 'IK1394', 'PAUL', 'TUBANONE', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0101', 0, '56000000.00', 100, '', 8, 1512297822, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(629, 7, 'IK0589', 'DEO', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512297861, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(630, 7, 'IK0590', 'DEBORAH', 'NAKAZIBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0039', 0, '40000000.00', 100, '', 8, 1512297900, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(631, 7, 'IK1080', 'MUTYABA', 'DASANI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0046', 0, '24000000.00', 100, '', 8, 1512297920, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(632, 7, 'IK0198', 'DASAN', 'MATENDE', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0326', 0, '32000000.00', 100, '', 0, 1512297927, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(633, 7, 'IK0995', 'NDAYE', 'DHEYONGERA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0129', 0, '24000000.00', 100, '', 8, 1512297932, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(634, 7, 'IK0591', 'WAYO', 'JULIUS', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0045', 0, '40000000.00', 100, '', 8, 1512297937, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(635, 7, 'IK1395', 'PAUL', 'MUWEREZA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0243', 0, '56000000.00', 100, '', 8, 1512297956, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(636, 7, 'IK0592', 'EMMANUEL', 'MWESIGWA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512297979, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(637, 7, 'IK1081', 'NAMUSIISI', 'MUGIRA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0038', 0, '24000000.00', 100, '', 8, 1512298005, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(638, 7, 'IK0199', 'PATRICK', 'ISABIRYE', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0578', 0, '32000000.00', 100, '', 0, 1512298009, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(639, 7, 'IK0996', 'VISENSIO', 'WAISWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0572', 0, '24000000.00', 100, '', 8, 1512298023, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(640, 7, 'IK1396', 'MONICA', 'MAWA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0096', 0, '56000000.00', 100, '', 8, 1512298038, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(641, 7, 'IK1082', 'LASIFU', 'MOSES', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0017', 0, '24000000.00', 100, '', 8, 1512298062, 1, '2017-12-15 09:56:33', 1, 'Select comment ...', 1),
(642, 7, 'IK0200', 'NAMUKOBE', 'NAMUKASANGU', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0092', 0, '32000000.00', 100, '', 0, 1512298103, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(643, 7, 'IK1397', 'JAMES', 'WAISWA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0240', 0, '56000000.00', 100, '', 8, 1512298109, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(644, 7, 'IK1083', 'ALI', 'KAALAMA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0080', 0, '24000000.00', 100, '', 8, 1512298134, 1, '2017-12-15 09:56:33', 1, 'DISTRIBUTION LINE', 1),
(645, 7, 'IK0593', 'POSCIANO', 'MUZALE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0049', 0, '40000000.00', 100, '', 8, 1512298141, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(646, 7, 'IK0997', 'GEORGE', 'WALUSANSA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0732', 0, '24000000.00', 100, '', 8, 1512298151, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(647, 7, 'IK1398', 'CHARLES', 'MUWEREZA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0137', 0, '56000000.00', 100, '', 8, 1512298168, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(648, 7, 'IK1084', 'KASAMBIKA', 'KIKUWA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0052', 0, '24000000.00', 100, '', 8, 1512298210, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(649, 7, 'IK0594', 'WILSON', 'LUKUNGU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0049', 0, '40000000.00', 100, '', 8, 1512298212, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(650, 7, 'IK1399', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0114', 0, '56000000.00', 100, '', 8, 1512298225, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(651, 7, 'IK0201', 'JOWALI', 'TIBWAZA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0066', 0, '32000000.00', 100, '', 0, 1512298237, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(652, 7, 'IK0595', 'SIRAJI', 'NGOBI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0040', 0, '40000000.00', 100, '', 8, 1512298241, 1, '2017-12-15 09:56:05', 1, 'DISTRIBUTION LINE', 1),
(653, 7, 'IK0998', 'JAMIL', 'SUNGWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0346', 0, '24000000.00', 100, '', 8, 1512298243, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(654, 7, 'IK0596', 'COUNTY SIDE SSS', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.1134', 0, '40000000.00', 100, '', 8, 1512298274, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(655, 7, 'IK0597', 'FAIS', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0205', 0, '40000000.00', 100, '', 8, 1512298307, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(656, 7, 'IK0202', 'KYEBANDA', 'MUSTAFA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0050', 0, '32000000.00', 100, '', 0, 1512298338, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(657, 7, 'IK0598', 'ZUBEDA', 'NALUSUBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0081', 0, '40000000.00', 100, '', 8, 1512298340, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(658, 7, 'IK1400', 'SAMUEL', 'WAMBUZI', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0085', 0, '56000000.00', 100, '', 8, 1512298353, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(659, 7, 'IK1085', 'STEVEN', 'WAYOMBA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0057', 0, '24000000.00', 100, '', 8, 1512298362, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(660, 7, 'IK0599', 'CYRUS', 'KAFUTE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0261', 0, '40000000.00', 100, '', 8, 1512298381, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(661, 7, 'IK0999', 'SAMUEL', 'MANDE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0189', 0, '24000000.00', 100, '', 0, 1512298388, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(662, 7, 'IK0600', 'ISAAC', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0110', 0, '40000000.00', 100, '', 8, 1512298417, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(663, 7, 'IK0601', 'NKWANGA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512298451, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(664, 7, 'IK1085-1', 'NAIGAGA', 'IRENE', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0040', 0, '24000000.00', 100, '', 8, 1512298531, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(665, 7, 'IK0602', 'KALEVU', 'LAWRENCE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0059', 0, '40000000.00', 100, '', 8, 1512298534, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(666, 7, 'IK1000', 'MULAVU', 'BITOSI', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0149', 0, '24000000.00', 100, '', 8, 1512298546, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(667, 7, 'IK0603', 'TIBILAGA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512298567, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(668, 7, 'IK0604', 'PAUL', 'TWABALYAKI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0034', 0, '40000000.00', 100, '', 8, 1512298626, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(669, 7, 'IK1401', 'SAMUEL', 'KALEGE', 'CHRISTOPHER', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0312', 0, '56000000.00', 100, '', 8, 1512298689, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(670, 7, 'IK0605', 'STEVEN', 'NAKYENALILE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0023', 0, '40000000.00', 100, '', 8, 1512298711, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(671, 7, 'IK1363', 'KAKO PRIMARY SCHOOL', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0735', 0, '56000000.00', 100, '', 8, 1512298811, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(672, 7, 'IK0606', 'AKALYAMAWA', 'GODFREY', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0065', 0, '40000000.00', 100, '', 8, 1512298861, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(673, 7, 'IK1364', 'FRED', 'WALYOMU', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0240', 0, '56000000.00', 100, '', 8, 1512298865, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(674, 7, 'IK0607', 'NKUWA FOREST COMPANY', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0124', 0, '40000000.00', 100, '', 8, 1512298897, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(675, 7, 'IK1365', '  ', 'REV. WAKO', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0315', 0, '56000000.00', 100, '', 8, 1512298915, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(676, 7, 'IK0608', 'MWANJE', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0049', 0, '40000000.00', 100, '', 8, 1512298927, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(677, 7, 'IK1366', 'THEOPHIL', 'TABINGWA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0090', 0, '56000000.00', 100, '', 8, 1512299015, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(678, 7, 'IK1367', 'AARON', 'MUSEKWA', 'TABINGWA', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0077', 0, '56000000.00', 100, '', 8, 1512299072, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(679, 7, 'IK1368', 'BEN', 'TABINGWA', 'MUKUNYA', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0089', 0, '56000000.00', 100, '', 8, 1512299123, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(680, 7, 'IK1086', 'MAJID', 'DHEYONGERA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0058', 0, '24000000.00', 100, '', 8, 1512299157, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(681, 7, 'IK0609', 'KADUMA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0027', 0, '40000000.00', 100, '', 8, 1512299169, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(682, 7, 'IK1369', 'ODEKE & FAMILY', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0171', 0, '56000000.00', 100, '', 8, 1512299175, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(683, 7, 'IK0610', 'NABIRYE', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0027', 0, '40000000.00', 100, '', 8, 1512299215, 1, '2017-12-15 09:56:06', 1, 'DISTRIBUTION LINE', 1),
(684, 7, 'IK0611', 'BUMALI', 'WAISWA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512299260, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(685, 7, 'IK0612', 'ROBERT', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0077', 0, '40000000.00', 100, '', 8, 1512299285, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(686, 7, 'IK0613', 'GRACE', 'MWESIJYE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0070', 0, '40000000.00', 100, '', 8, 1512299336, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(687, 7, 'IK0614', 'SIMON', 'KAGEMA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0105', 0, '40000000.00', 100, '', 8, 1512299365, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(688, 7, 'IK0615', 'WAISWA', 'NKWANGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0080', 0, '40000000.00', 100, '', 8, 1512299398, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(689, 7, 'IK137', 'UNKNOWN', ' ', ' ', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0000', 0, '0.00', 0, '', 8, 1512299403, 1, '2017-12-09 16:39:29', 1, 'DISTRIBUTION LINE', 1),
(690, 7, 'IK0616', 'FRED', 'MWANDA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0085', 0, '40000000.00', 100, '', 8, 1512299432, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(691, 7, 'IK0617', 'NKOLO', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0063', 0, '40000000.00', 100, '', 8, 1512299471, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(692, 7, 'IK1373', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0072', 0, '56000000.00', 100, '', 8, 1512299490, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(693, 7, 'IK0618', 'YAHAYA', 'IBANDA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0067', 0, '40000000.00', 100, '', 8, 1512299500, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(694, 7, 'IK0619', 'TILUTYA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512299542, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(695, 7, 'IK1374', 'MUHAMMED', 'CAROL', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0081', 0, '56000000.00', 100, '', 8, 1512299552, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(696, 7, 'IK0620', 'SALIM', 'MUTEGO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0073', 0, '40000000.00', 100, '', 8, 1512299632, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(697, 7, 'IK1001', 'JOSEPH', 'MPALA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0509', 0, '24000000.00', 100, '', 8, 1512299640, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(698, 7, 'IK1087', 'DASANI', 'MUTYABA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0039', 0, '24000000.00', 100, '', 8, 1512299648, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(699, 7, 'IK0621', 'MESACH', 'BYEKWASO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0088', 0, '40000000.00', 100, '', 0, 1512299664, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(700, 7, 'IK1371', 'MUHAMMAD', 'KAALWA', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512299671, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(701, 7, 'IK0622', 'MILTON', 'LUBEGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0058', 0, '40000000.00', 100, '', 8, 1512299694, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(702, 7, 'IK1088', 'STONE', 'WAYOMBA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0140', 0, '24000000.00', 100, '', 8, 1512299724, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(703, 7, 'IK1375', 'COLONEL', 'MUTABAZI', '', '', 41, 0, 6, 8, 5, '1', '0.0000', '0.0000', '0.0151', 0, '56000000.00', 100, '', 8, 1512299725, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(704, 7, 'IK1002', 'AIDAH', 'NAMUGABO', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0141', 0, '24000000.00', 100, '', 8, 1512299741, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(705, 7, 'IK0203', 'GEOFFREY', 'KYEDUMIRA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0049', 0, '32000000.00', 100, '', 0, 1512299767, 1, '2017-12-15 09:55:44', 1, 'Select comment ...', 1),
(706, 7, 'IK0623', 'WILBER', 'LUBALA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0022', 0, '40000000.00', 100, '', 8, 1512299821, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(707, 7, 'IK0624', 'KABUGUTA', 'MUZAFARU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0039', 0, '40000000.00', 100, '', 8, 1512299860, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(708, 7, 'IK1003', 'WILBER', 'BASEMBEZA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0248', 0, '24000000.00', 100, '', 8, 1512299882, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(709, 7, 'IK0625', 'MICHEAL', 'KASADA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0034', 0, '40000000.00', 100, '', 8, 1512299898, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(710, 7, 'IK1089', 'GRACE', 'MUKUNGU', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0053', 0, '24000000.00', 100, '', 8, 1512299928, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(711, 7, 'IK0626', 'JOHN', 'TENTE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0058', 0, '40000000.00', 100, '', 8, 1512299932, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(712, 7, 'IK0627', 'SARAH', 'NAMUNGALWE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0091', 0, '40000000.00', 100, '', 8, 1512299965, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(713, 7, 'IK1090', 'JULIUS', 'KALULU', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0074', 0, '24000000.00', 100, '', 8, 1512299996, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(714, 7, 'IK0628', 'UNKNOWN', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0060', 0, '40000000.00', 100, '', 8, 1512299998, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(715, 7, 'IK1004', 'SHABAN', 'WAISWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0784', 0, '24000000.00', 100, '', 8, 1512300000, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(716, 7, 'IK0204', 'SILIMANI', 'GUMA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0058', 0, '32000000.00', 100, '', 0, 1512300026, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(717, 7, 'IK0629', 'MAURINE', 'MUSAWO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0049', 0, '40000000.00', 100, '', 8, 1512300033, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(718, 7, 'IK0630', 'BEN', 'KISAMBIRA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0149', 0, '40000000.00', 100, '', 8, 1512300068, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(719, 7, 'IK0205', 'UNKNOWN', ' ', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0068', 0, '32000000.00', 100, '', 0, 1512300080, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(720, 7, 'IK0631', 'AWALI', 'KABANJA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512300105, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(721, 7, 'IK1091', 'ALPA', 'KIPALA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0072', 0, '24000000.00', 100, '', 8, 1512300115, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(722, 7, 'IK0206', 'DAVID', 'KAKUSU', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0113', 0, '32000000.00', 100, '', 0, 1512300124, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(723, 7, 'IK0632', 'FRED', 'SANDE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0024', 0, '40000000.00', 100, '', 8, 1512300135, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(724, 7, 'IK1005', 'ASADI', 'KAYAYA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0645', 0, '24000000.00', 100, '', 8, 1512300182, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(725, 7, 'IK0633', 'JOYCE', 'NANGOBI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0028', 0, '40000000.00', 100, '', 8, 1512300189, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(726, 7, 'IK0634', 'DENIS', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512300216, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(727, 7, 'IK0635', 'ZIYADI', 'NGOBI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0019', 0, '40000000.00', 100, '', 8, 1512300244, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(728, 7, 'IK1092', 'JOHN', 'KIKUMI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0072', 0, '24000000.00', 100, '', 8, 1512300276, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(729, 7, 'IK0636', 'KIBAIRE', 'NAWANSEGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0036', 0, '40000000.00', 100, '', 8, 1512300294, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(730, 7, 'IK0637', 'BAKOZE', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0036', 0, '40000000.00', 100, '', 8, 1512300346, 1, '2017-12-15 09:56:07', 1, 'DISTRIBUTION LINE', 1),
(731, 7, 'IK0638', 'HAJJI', 'ADI', 'MADAGALA', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0049', 0, '40000000.00', 100, '', 8, 1512300393, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(732, 7, 'IK1007', 'PETER', 'BATABAIRE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0229', 0, '24000000.00', 100, '', 8, 1512300399, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(733, 7, 'IK0639', 'JOWALI', 'BUTEGO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0063', 0, '40000000.00', 100, '', 8, 1512300439, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(734, 7, 'IK1093', 'UMAR', 'DIDI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0115', 0, '24000000.00', 100, '', 8, 1512300468, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(735, 7, 'IK0640', 'LUGENDA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0068', 0, '40000000.00', 100, '', 8, 1512300483, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(736, 7, 'IK1007', 'WILBER', 'BUTABAIRE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0229', 0, '24000000.00', 100, '', 8, 1512300509, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(737, 7, 'IK0641', 'MALEVU', 'WALEKAKI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0035', 0, '40000000.00', 100, '', 8, 1512300567, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(738, 7, 'IK0642', 'MUTASA', 'WILSON', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512300603, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(739, 7, 'IK1094', 'DAVID', 'NANYUMBA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0157', 0, '24000000.00', 100, '', 8, 1512300630, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(740, 7, 'IK0643', 'ELIOT', 'DIKUSOKA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0032', 0, '40000000.00', 100, '', 8, 1512300631, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(741, 7, 'IK1008', 'JOEL', 'BUYINZA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0075', 0, '24000000.00', 100, '', 8, 1512300637, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(742, 7, 'IK0644', 'JOWALI', 'TIBITA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0044', 0, '40000000.00', 100, '', 8, 1512300665, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(743, 7, 'IK0207', 'HAMZA', 'KINTU', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0124', 0, '32000000.00', 100, '', 8, 1512300709, 1, '2017-12-15 09:55:44', 1, 'Select comment ...', 1),
(744, 7, 'IK0645', 'CHARLES', 'BIDANDALI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0045', 0, '40000000.00', 100, '', 8, 1512300709, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(745, 7, 'IK1009', 'SARAH', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0046', 0, '24000000.00', 100, '', 8, 1512300734, 1, '2017-12-15 09:56:29', 1, 'DISTRIBUTION LINE', 1),
(746, 7, 'IK0646', 'LUBEGA', 'MUYAMBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0088', 0, '40000000.00', 100, '', 8, 1512300746, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(748, 7, 'IK0647', 'ALI', 'GYAGENDA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512300777, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(749, 7, 'IK0648', 'MIRABU', 'TEPENENSI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0058', 0, '40000000.00', 100, '', 8, 1512300817, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(750, 7, 'IK0209', 'WILBER', 'MAWERERE', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0129', 0, '32000000.00', 100, '', 8, 1512300828, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(751, 7, 'IK1010', 'REHEMAH', 'NAKASANGO', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0056', 0, '24000000.00', 100, '', 8, 1512300853, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(752, 7, 'IK1096', 'GODFREY', 'KIBIYE', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0081', 0, '24000000.00', 100, '', 8, 1512300855, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(753, 7, 'IK0210', 'ISIFU', 'MWAWULA', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0093', 0, '32000000.00', 100, '', 8, 1512300907, 1, '2017-12-15 09:55:44', 1, 'Select comment ...', 1),
(754, 7, 'IK1011', 'MUSOMESA', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512300924, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(755, 7, 'IK1097', 'KNIGHT', 'KABAALA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0101', 0, '24000000.00', 100, '', 8, 1512300951, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(756, 7, 'IK0211', 'BOSCO', ' ', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0076', 0, '32000000.00', 100, '', 8, 1512300955, 1, '2017-12-15 09:55:44', 1, 'Select comment ...', 1),
(757, 7, 'IK0649', 'AWALI', 'BAGUWENDHA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0021', 0, '40000000.00', 100, '', 8, 1512300994, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(758, 7, 'IK0650', 'KIWULE', 'KAMUSAALO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0021', 0, '40000000.00', 100, '', 8, 1512301055, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(759, 7, 'IK1012', 'UNKNOWN', '   ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0044', 0, '24000000.00', 100, '', 8, 1512301097, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(760, 7, 'IK1098', 'BAGAYA', 'MUSA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0242', 0, '24000000.00', 100, '', 8, 1512301137, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(761, 7, 'IK0651', 'BYEKWASO', 'LIVING', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0023', 0, '40000000.00', 100, '', 0, 1512301146, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(762, 7, 'IK0652', 'BAKER', 'KYEWE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0040', 0, '40000000.00', 100, '', 8, 1512301191, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(763, 7, 'IK0653', 'SAM', 'WILBER', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0073', 0, '40000000.00', 100, '', 8, 1512301243, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(764, 7, 'IK1099', 'NKWESI', 'PAUL', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0074', 0, '24000000.00', 100, '', 8, 1512301283, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(765, 7, 'IK0654', 'MALEVU', 'WALEKAKI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512301337, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(766, 7, 'IK0655', 'ROSE', 'NABIRYE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0047', 0, '40000000.00', 100, '', 8, 1512301361, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(767, 7, 'IK1013', 'KADONGANYA', 'MBILIRE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0838', 0, '24000000.00', 100, '', 8, 1512301362, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(768, 7, 'IK1100', 'MOSES', 'WAAKO', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0205', 0, '24000000.00', 100, '', 8, 1512301399, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(769, 7, 'IK1014', 'BOSCO FAMILY', 'WAIGALA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0205', 0, '24000000.00', 100, '', 8, 1512301510, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(770, 7, 'IK1101', 'GEORGE', 'MAGANDA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0055', 0, '24000000.00', 100, '', 8, 1512301523, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(771, 7, 'IK0656', 'NABUKENYA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0021', 0, '40000000.00', 100, '', 8, 1512301550, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(772, 7, 'IK0657', 'GODFREY', 'MWANDA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0019', 0, '40000000.00', 100, '', 8, 1512301580, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(773, 7, 'IK1102', 'AUGUSTINE', 'KIFAMBI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0141', 0, '24000000.00', 100, '', 8, 1512301623, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(774, 7, 'IK1103', 'UNKNOWN', ' ', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0036', 0, '24000000.00', 100, '', 8, 1512301698, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(775, 7, 'IK0658', 'ANTHONY', 'KISIWA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0015', 0, '40000000.00', 100, '', 8, 1512301710, 1, '2017-12-15 09:56:08', 1, 'DISTRIBUTION LINE', 1),
(776, 7, 'IK1015', 'MUHAMMAD', 'BATULI', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0361', 0, '24000000.00', 100, '', 8, 1512301711, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(777, 7, 'IK0659', 'MUSA', 'BUKUMUNE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512301743, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(778, 7, 'IK1104', 'TUNA', 'KYAKULUGA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0047', 0, '24000000.00', 100, '', 8, 1512301766, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(779, 7, 'IK0660', 'BETTY', 'KISUBI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0033', 0, '40000000.00', 100, '', 8, 1512301804, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(780, 7, 'IK0661', 'MONICA', 'NANKWANGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0056', 0, '40000000.00', 100, '', 8, 1512301849, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(781, 7, 'IK1105', 'ROBINAH', 'KISILA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512301862, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(782, 7, 'IK1016', 'BUMALI', 'MUTUBA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0118', 0, '24000000.00', 100, '', 8, 1512301864, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(783, 7, 'IK0662', 'SIMON', 'KYABALANGO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0027', 0, '40000000.00', 100, '', 8, 1512301897, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(784, 7, 'IK1106', 'YEKO', '..', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0051', 0, '24000000.00', 100, '', 8, 1512301928, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(785, 7, 'IK0663', 'UMAR', 'TENYWA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0018', 0, '40000000.00', 100, '', 8, 1512301931, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(786, 7, 'IK1017', 'UNKNOWN', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0045', 0, '24000000.00', 100, '', 8, 1512301983, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(787, 7, 'IK0664', 'WAKASANGA', 'MOSES', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0020', 0, '40000000.00', 100, '', 8, 1512301989, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(788, 7, 'IK0665', 'BRIAN', 'MAGOOLA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0021', 0, '40000000.00', 100, '', 8, 1512302019, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(789, 7, 'IK0666', 'STEVEN', 'BUTAMU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0035', 0, '40000000.00', 100, '', 8, 1512302070, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(790, 7, 'IK0667', 'GERALD', 'BUTAMU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0079', 0, '40000000.00', 100, '', 8, 1512302111, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(791, 7, 'IK1018', 'MUSA', 'ZAITUNA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0400', 0, '24000000.00', 100, '', 8, 1512302151, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(792, 7, 'IK0668', 'GETRUDE', 'KYAYOGEIRE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0118', 0, '40000000.00', 100, '', 8, 1512302178, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(793, 7, 'IK1107', 'ISBIRYE', 'KYOGEMA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0336', 0, '24000000.00', 100, '', 8, 1512302259, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(794, 7, 'IK1108', 'UNKNOWN', '..', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0080', 0, '24000000.00', 100, '', 8, 1512302358, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(795, 7, 'IK0212', 'ST.PETER CLAVER PRIMARY SCHOOL- BUBOGO', ' ', '', '', 33, 0, 3, 14, 17, '1', '0.0000', '0.0000', '0.0856', 0, '32000000.00', 100, '', 8, 1512302397, 1, '2017-12-15 09:55:44', 1, 'RESERVOIR SITE', 1);
INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, `chainage`, `tenure`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`, `active`) VALUES
(796, 7, 'IK1019', 'FAREED', 'TAKWANA', 'NGIYA', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.1605', 0, '24000000.00', 100, '', 8, 1512302400, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(797, 7, 'IK1109', 'CHARLES', 'SAKERI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0040', 0, '24000000.00', 100, '', 8, 1512302442, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(798, 7, 'IK0669', 'GEORGE  ', 'KYEWE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0097', 0, '40000000.00', 100, '', 0, 1512302559, 1, '2017-12-15 09:56:09', 1, 'Select comment ...', 1),
(799, 7, 'IK1110', 'KAITA', '  ', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0046', 0, '24000000.00', 100, '', 8, 1512302591, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(801, 7, 'IK1020', 'SAMUEL', 'KOOZALA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0387', 0, '24000000.00', 100, '', 8, 1512302610, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(802, 7, 'IK0670', 'KYEWE', 'GAZIBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0159', 0, '40000000.00', 100, '', 8, 1512302623, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(803, 7, 'IK1111', 'KIBIYE', 'NURU', '***', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0175', 0, '24000000.00', 100, '', 8, 1512302684, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(804, 7, 'IK0671', 'PATRICK ', 'KALENZI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512302686, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(805, 7, 'IK0213', 'BUNYIRO MUSLIM PRIMARY SCHOOL(OWNED BY BUNYIRO MASGID TAQWA)', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.1551', 0, '32000000.00', 100, '', 8, 1512302728, 1, '2017-12-15 09:55:44', 1, 'RESERVOIR SITE', 1),
(806, 7, 'IK0672', 'EFLANSI', 'KAUDHA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0054', 0, '40000000.00', 100, '', 8, 1512302755, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(807, 7, 'IK1112', 'MEMBA', 'SUUBI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0088', 0, '24000000.00', 100, '', 8, 1512302773, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(808, 7, 'IK1021', 'JAMAL', 'TIBAGULWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0278', 0, '24000000.00', 100, '', 8, 1512302798, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(809, 7, 'IK0214', 'GEORGE', 'LUNYIRO', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0090', 0, '32000000.00', 100, '', 8, 1512302800, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(810, 7, 'IK1113', 'HARRIET', 'NAKIRANDA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0134', 0, '24000000.00', 100, '', 8, 1512302852, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(811, 7, 'IK0673', 'KYEGANI', 'SEMUWEMBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0064', 0, '40000000.00', 100, '', 8, 1512302872, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(812, 7, 'IK0215', 'ESEZA', 'TIBAZALI', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0192', 0, '32000000.00', 100, '', 8, 1512302891, 1, '2017-12-15 09:55:45', 1, 'DISTRIBUTION LINE', 1),
(813, 7, 'IK1022', 'PONSIANO', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0083', 0, '24000000.00', 100, '', 8, 1512302901, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(814, 7, 'IK1114', 'ROBERT', 'WAISWA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0055', 0, '24000000.00', 100, '', 8, 1512302932, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(815, 7, 'IK0674', 'WEFULA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0042', 0, '40000000.00', 100, '', 8, 1512302932, 1, '2017-12-15 09:56:09', 1, 'DISTRIBUTION LINE', 1),
(816, 7, 'IK1023', 'GIDEON', 'BALBAWO', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0075', 0, '24000000.00', 100, '', 8, 1512302982, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(817, 7, 'IK0675', 'JOHN', 'LUDIGO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0059', 0, '40000000.00', 100, '', 8, 1512303038, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(818, 7, 'IK1115', 'DAVID', 'MUKUPYA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0260', 0, '24000000.00', 100, '', 8, 1512303074, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(819, 7, 'IK0676', 'DANIEL', 'BALIKOWA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0061', 0, '40000000.00', 100, '', 8, 1512303096, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(820, 7, 'IK0677', 'DONOZIYO', 'BALIDAWA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0060', 0, '40000000.00', 100, '', 8, 1512303134, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(821, 7, 'IK1024', 'MUHAMMAD', 'MANIGAMUNGU', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0384', 0, '24000000.00', 100, '', 8, 1512303147, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(822, 7, 'IK1116', 'TIDILYALA', 'MBOYA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0129', 0, '24000000.00', 100, '', 8, 1512303181, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(823, 7, 'IK0678', 'HAJJI', 'ADI', 'MADAGALA', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0159', 0, '40000000.00', 100, '', 8, 1512303205, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(824, 7, 'IK1025', 'CHRISTOPHER', 'BALIGEYA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0055', 0, '24000000.00', 100, '', 8, 1512303297, 1, '2017-12-15 09:56:30', 1, 'TRANSMISSION LINE', 1),
(825, 7, 'IK1117', 'JAMES', 'TIDILYALA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0289', 0, '24000000.00', 100, '', 8, 1512303306, 1, '2017-12-15 09:56:35', 1, 'DISTRIBUTION LINE', 1),
(826, 7, 'IK1118', 'YEREMIYA', 'FRIDAY', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0072', 0, '24000000.00', 100, '', 8, 1512303408, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(827, 7, 'IK1026', 'MOSES', 'KABI', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0141', 0, '24000000.00', 100, '', 8, 1512303468, 1, '2017-12-15 09:56:30', 1, 'TRANSMISSION LINE', 1),
(828, 7, 'IK1119', 'TEZIKYA', 'PATRICK', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0134', 0, '24000000.00', 100, '', 8, 1512303510, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(829, 7, 'IK1120', 'GODFREY', 'TUSUBIRA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0043', 0, '24000000.00', 100, '', 8, 1512303582, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(830, 7, 'IK1027', 'ABDUL', 'WAISWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0213', 0, '24000000.00', 100, '', 8, 1512303615, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(831, 7, 'IK0679', 'MOSES', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0029', 0, '40000000.00', 100, '', 0, 1512303636, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(832, 7, 'IK1121', 'DAVID', 'BALANGA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0037', 0, '24000000.00', 100, '', 8, 1512303668, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(833, 7, 'IK0680', 'KASOZI', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512303676, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(834, 7, 'IK0681', 'JOSEPH  ', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0023', 0, '40000000.00', 100, '', 8, 1512303702, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(835, 7, 'IK0216', 'LUGOBANGU', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0047', 0, '32000000.00', 100, '', 0, 1512303709, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(836, 7, 'IK0682', 'WAKO', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0034', 0, '40000000.00', 100, '', 8, 1512303725, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(837, 7, 'IK0683', 'NABUKENYA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512303749, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(838, 7, 'IK1028', 'SIRAJE ', 'MUTALYA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0074', 0, '24000000.00', 100, '', 8, 1512303756, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(839, 7, 'IK0217', 'JOHN', 'SANDE', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0075', 0, '32000000.00', 100, '', 0, 1512303758, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(840, 7, 'IK0684', 'ROGERS', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0059', 0, '40000000.00', 100, '', 8, 1512303772, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(841, 7, 'IK1122', 'PAUL', 'BATEGANYA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0118', 0, '24000000.00', 100, '', 8, 1512303774, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(842, 7, 'IK1029', 'MUHAMMAD', 'ISABIRYE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0087', 0, '24000000.00', 100, '', 8, 1512303840, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(843, 7, 'IK0685', 'MILINGO', 'MUTWALIBU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0031', 0, '40000000.00', 100, '', 8, 1512303846, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(844, 7, 'IK0218', 'MONDAY', 'BYAKUNO', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.1147', 0, '32000000.00', 100, '', 0, 1512303868, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(845, 7, 'IK0686', 'SILIMAN', 'WAISWA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512303874, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(846, 7, 'IK0687', 'ANDREW', 'MUSEMBYA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0057', 0, '40000000.00', 100, '', 8, 1512303916, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(847, 7, 'IK0219', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0206', 0, '32000000.00', 100, '', 0, 1512303917, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(848, 7, 'IK1123', 'CHARLES', 'KAKOOZA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0045', 0, '24000000.00', 100, '', 8, 1512303939, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(849, 7, 'IK0688', 'MOSES', 'NGOBI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0076', 0, '40000000.00', 100, '', 8, 1512303946, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(850, 7, 'IK1030', 'ELIZEFANI', 'WAISWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0039', 0, '24000000.00', 100, '', 8, 1512303952, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(851, 7, 'IK0689', 'JENIFER', 'NABUKENYA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0058', 0, '40000000.00', 100, '', 8, 1512303984, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(852, 7, 'IK0220', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0049', 0, '32000000.00', 100, '', 0, 1512303988, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(853, 7, 'IK0690', 'RONALD', 'BUKENYA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0025', 0, '40000000.00', 100, '', 8, 1512304025, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(854, 7, 'IK1124', 'ERIA', 'KAKOOZA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0054', 0, '24000000.00', 100, '', 8, 1512304026, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(855, 7, 'IK0221', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0114', 0, '32000000.00', 100, '', 0, 1512304049, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(856, 7, 'IK0692', 'ANDREW', 'MUSEMBYE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0168', 0, '40000000.00', 100, '', 8, 1512304077, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(857, 7, 'IK1125', 'WILSON', 'MUTEBI', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0037', 0, '24000000.00', 100, '', 8, 1512304088, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(858, 7, 'IK0693', 'ANTHONY', 'KISIGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512304113, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(859, 7, 'IK1126', 'UNKNOWN', '', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0034', 0, '24000000.00', 100, '', 8, 1512304142, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(860, 7, 'IK0222', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0085', 0, '32000000.00', 100, '', 8, 1512304149, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(861, 7, 'IK0694', 'EBUYAMU', 'MUWENGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512304152, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(862, 7, 'IK0695', 'BAKOZI', 'KASONE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0040', 0, '40000000.00', 100, '', 8, 1512304200, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(863, 7, 'IK1127', 'PETER', 'KAKOOZA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0051', 0, '24000000.00', 100, '', 8, 1512304204, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(864, 7, 'IK0223', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0049', 0, '32000000.00', 100, '', 8, 1512304213, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(865, 7, 'IK0696', 'KILEVU', 'MATILDA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0034', 0, '40000000.00', 100, '', 8, 1512304242, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(866, 7, 'IK1128', 'BALONDEMU', 'DAVID', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0034', 0, '24000000.00', 100, '', 8, 1512304281, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(867, 7, 'IK0697', 'MUTASA', 'MOSES', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512304283, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(868, 7, 'IK1129', 'UKNOWN', '', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0031', 0, '24000000.00', 100, '', 8, 1512304337, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(869, 7, 'IK0698', 'SARAH', 'NAKANDHA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0107', 0, '40000000.00', 100, '', 8, 1512304349, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(870, 7, 'IK1031', 'MUHAMMAD ***', 'BALUGAMBIRE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0401', 0, '24000000.00', 100, '', 8, 1512304357, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(871, 7, 'IK0699', 'KIKALU', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0043', 0, '40000000.00', 100, '', 8, 1512304387, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(872, 7, 'IK0700', 'NELSON', 'BAIDU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0015', 0, '40000000.00', 100, '', 8, 1512304435, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(873, 7, 'IK1130', 'ANTHONY', 'MUKAYA', '', '', 33, 0, 2, 10, 34, '1', '0.0000', '0.0000', '0.0074', 0, '24000000.00', 100, '', 8, 1512304441, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(874, 7, 'IK0701', 'MUTEBI', 'MUTWALIBU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0029', 0, '40000000.00', 100, '', 8, 1512304489, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(875, 7, 'IK0702', 'ISABIRYE', 'FRED', 'MULAWA', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0056', 0, '40000000.00', 100, '', 8, 1512304533, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(876, 7, 'IK1032', 'ERIAS', 'ISABIRYE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0508', 0, '24000000.00', 100, '', 8, 1512304552, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(877, 7, 'IK0706', 'FATUMA', 'NALUBEGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0020', 0, '40000000.00', 100, '', 8, 1512304625, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(878, 7, 'IK1033', 'FRIDAY', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512304648, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(879, 7, 'IK0704', 'SALIM', 'IKOBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0055', 0, '40000000.00', 100, '', 8, 1512304707, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(880, 7, 'IK0705', 'NKONDE', 'NAIGAGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0014', 0, '40000000.00', 100, '', 8, 1512304737, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(881, 7, 'IK0707', 'BIKUMBI', 'DAVID', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0034', 0, '40000000.00', 100, '', 8, 1512304796, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(882, 7, 'IK1402', 'MOSES', 'KAWANGUZI', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0349', 0, '56000000.00', 100, '', 8, 1512304875, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(883, 7, 'IK1034', 'RUTH', 'MUSU', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.1007', 0, '24000000.00', 100, '', 8, 1512304883, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(884, 7, 'IK1403', 'DAVID', 'WAYA', 'PEERA', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0346', 0, '56000000.00', 100, '', 8, 1512304932, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(885, 7, 'IK0224', 'NAMALWA', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0055', 0, '32000000.00', 100, '', 8, 1512304970, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(886, 7, 'IK1035', 'FRED', 'DHOLAGA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0057', 0, '24000000.00', 100, '', 8, 1512304994, 1, '2017-12-15 09:56:30', 1, 'DISTRIBUTION LINE', 1),
(887, 7, 'IK0715', 'GERALD', 'DAUDI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0134', 0, '40000000.00', 100, '', 8, 1512305002, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(888, 7, 'IK1211', 'MAYI', 'NALUBEGA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0357', 0, '24000000.00', 100, '', 8, 1512305011, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(889, 7, 'IK0716', 'CONSTANT', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0044', 0, '0.00', 0, '', 8, 1512305050, 1, '2017-12-15 09:44:31', 1, 'DISTRIBUTION LINE', 1),
(890, 7, 'IK1036', 'BAMU', '  ', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0044', 0, '24000000.00', 100, '', 8, 1512305097, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(891, 7, 'IK1212', 'SUZAN', 'NABIRYE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0074', 0, '24000000.00', 100, '', 8, 1512305104, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(892, 7, 'IK0717', 'KAWETE MARKET', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.1171', 0, '40000000.00', 100, '', 8, 1512305173, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(893, 7, 'IK0718', 'ISADA', 'VALENTINE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0193', 0, '40000000.00', 100, '', 8, 1512305211, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(894, 7, 'IK1213', 'ZADOKI', 'WAISWA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0042', 0, '24000000.00', 100, '', 8, 1512305227, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(895, 7, 'IK1037', 'IDUMA', 'NABANGI', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0062', 0, '24000000.00', 100, '', 8, 1512305235, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(896, 7, 'IK0719', 'JONGA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0098', 0, '40000000.00', 100, '', 8, 1512305236, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(897, 7, 'IK0720', 'KAWEESA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512305288, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(898, 7, 'IK1214', 'FRED', 'ISABIRYE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0033', 0, '24000000.00', 100, '', 8, 1512305311, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(899, 7, 'IK0721', 'MUSA', 'OLUKIKU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512305336, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(900, 7, 'IK1038', 'BAKARI', 'MUSOBYA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0078', 0, '24000000.00', 100, '', 8, 1512305354, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(901, 7, 'IK0722', 'OMULONGO', 'KIYEMBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0081', 0, '40000000.00', 100, '', 8, 1512305373, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(902, 7, 'IK1215', 'SUPANI', 'YATUWA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0228', 0, '24000000.00', 100, '', 8, 1512305388, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(903, 7, 'IK0723', 'MULAMOGI', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0058', 0, '40000000.00', 100, '', 8, 1512305404, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(904, 7, 'IK0724', 'ELWANA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512305451, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(905, 7, 'IK1039', 'MAWAAZI', 'ISABIRYE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0060', 0, '24000000.00', 100, '', 8, 1512305453, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(906, 7, 'IK1216', 'YAKUT', 'GYAGENDA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0082', 0, '24000000.00', 100, '', 8, 1512305468, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(907, 7, 'IK0725', 'VENETURA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0077', 0, '40000000.00', 100, '', 8, 1512305493, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(908, 7, 'IK0726', 'WABULUNGU', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0055', 0, '40000000.00', 100, '', 8, 1512305535, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(909, 7, 'IK0727', 'JOHN', 'KAWUMBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0048', 0, '40000000.00', 100, '', 8, 1512305566, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(910, 7, 'IK1404', 'CEMETERY', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0709', 0, '56000000.00', 100, '', 8, 1512305599, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(911, 7, 'IK0728', 'KALEMBO', 'GERALD', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0086', 0, '40000000.00', 100, '', 8, 1512305606, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(912, 7, 'IK0729', 'KIWEMBA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0075', 0, '40000000.00', 100, '', 8, 1512305649, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(913, 7, 'IK0729', 'KIWEMBA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0075', 0, '40000000.00', 100, '', 8, 1512305686, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(914, 7, 'IK1217', 'MUZUBA', '  ', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0050', 0, '24000000.00', 100, '', 8, 1512305688, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(915, 7, 'IK1040', 'ISA', 'BALISANYUKA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0021', 0, '24000000.00', 100, '', 8, 1512305704, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(916, 7, 'IK0730', 'TIBITA', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0041', 0, '40000000.00', 100, '', 8, 1512305714, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(917, 7, 'IK1405', 'GEOFREY', 'BABE', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0544', 0, '56000000.00', 100, '', 8, 1512305735, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(918, 7, 'IK0731', 'GRACE', '  ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512305750, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(919, 7, 'IK1041', 'PATRICK', 'WAISWA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0054', 0, '24000000.00', 100, '', 8, 1512305780, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(920, 7, 'IK0732', 'WILSON', 'MATENDE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0044', 0, '40000000.00', 100, '', 8, 1512305785, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(921, 7, 'IK0733', 'BALAZEWA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0079', 0, '40000000.00', 100, '', 8, 1512305814, 1, '2017-12-15 09:56:13', 1, 'DISTRIBUTION LINE', 1),
(922, 7, 'IK1218', 'PATRICK', 'BALILULWE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0063', 0, '24000000.00', 100, '', 8, 1512305814, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(923, 7, 'IK1406', 'MASANGA', 'WEDUMA', 'JIGO', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0076', 0, '56000000.00', 100, '', 8, 1512305828, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(924, 7, 'IK0734', 'KYAYIRA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0074', 0, '40000000.00', 100, '', 8, 1512305851, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(925, 7, 'IK1042', 'FRED', 'MUSOBYA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0030', 0, '24000000.00', 100, '', 8, 1512305894, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(926, 7, 'IK1407', 'GLADYS', 'BATAIRE', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0227', 0, '56000000.00', 100, '', 8, 1512305896, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(927, 7, 'IK0735', 'RACHEAL', 'MUWANGUZI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512305911, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(928, 7, 'IK1219', 'ABASI', 'WAISWA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0030', 0, '24000000.00', 100, '', 8, 1512305934, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(929, 7, 'IK0736', 'ZAITUNI', 'NANGOBI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0040', 0, '40000000.00', 100, '', 8, 1512305958, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(930, 7, 'IK0737', 'AMUZA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512305984, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(931, 7, 'IK1408', ' ', 'WABWIRE', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0080', 0, '56000000.00', 100, '', 8, 1512306015, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(932, 7, 'IK1043', 'YESWERI', 'DHISOKE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0104', 0, '24000000.00', 100, '', 8, 1512306016, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(933, 7, 'IK0738', 'MARGRET', 'NABIRYE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0050', 0, '40000000.00', 100, '', 8, 1512306033, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(934, 7, 'IK1220', 'SIRIGI', 'SENTAMU', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0022', 0, '24000000.00', 100, '', 8, 1512306035, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(935, 7, 'IK0739', 'HASSA', 'MAGUMBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0083', 0, '40000000.00', 100, '', 8, 1512306068, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(936, 7, 'IK0740', 'FUFU', 'BUDALLAH', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0068', 0, '40000000.00', 100, '', 8, 1512306110, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(937, 7, 'IK1221', 'PATRICK', 'BALIKULULWE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0066', 0, '24000000.00', 100, '', 8, 1512306116, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(938, 7, 'IK0225', 'MOHAMMAD', 'KANSENSE', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0058', 0, '32000000.00', 100, '', 8, 1512306131, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(939, 7, 'IK1044', 'DHISOKE', 'ISABIRYE', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512306135, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(940, 7, 'IK0741', 'HARUNA', 'KIREVU', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0037', 0, '40000000.00', 100, '', 8, 1512306144, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(941, 7, 'IK0742', 'NELSON', 'KYEGONZA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512306185, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(942, 7, 'IK0743', 'MUZAMIRU', 'KASOLO', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0065', 0, '40000000.00', 100, '', 8, 1512306227, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(943, 7, 'IK1222', 'SAMUEL', 'PANDE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0038', 0, '24000000.00', 100, '', 8, 1512306238, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(944, 7, 'IK1045', 'REHEMAH', 'NANYONGA', '', '', 33, 0, 2, 22, 33, '1', '0.0000', '0.0000', '0.0045', 0, '24000000.00', 100, '', 8, 1512306241, 1, '2017-12-15 09:56:31', 1, 'DISTRIBUTION LINE', 1),
(945, 7, 'IK0744', 'KAGOYA', 'MWAIDUMA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0043', 0, '40000000.00', 100, '', 8, 1512306268, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(946, 7, 'IK1409', 'MULANI', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0207', 0, '56000000.00', 100, '', 8, 1512306321, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(947, 7, 'IK1223', 'ELIZEFANI', 'MAFABI', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0042', 0, '24000000.00', 100, '', 8, 1512306373, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(948, 7, 'IK1410', 'RICHARD', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0050', 0, '56000000.00', 100, '', 8, 1512306389, 1, '2017-12-15 09:56:51', 1, 'DISTRIBUTION LINE', 1),
(949, 7, 'IK0746', 'LUTHERAN SCHOOL', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0464', 0, '40000000.00', 100, '', 8, 1512306425, 1, '2017-12-15 09:56:14', 1, 'DISTRIBUTION LINE', 1),
(950, 7, 'IK1411', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0085', 0, '56000000.00', 100, '', 8, 1512306441, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(951, 7, 'IK0747', 'BASOGA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0052', 0, '40000000.00', 100, '', 8, 1512306479, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(952, 7, 'IK1224', 'JOSEPH', 'KAYANGA', '****', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0034', 0, '24000000.00', 100, '', 8, 1512306491, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(953, 7, 'IK1412', ' ', 'AFANDE NGOBI', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0114', 0, '56000000.00', 100, '', 8, 1512306519, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(954, 7, 'IK0748', 'FLORENCE', 'NAISANGA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0036', 0, '40000000.00', 100, '', 8, 1512306525, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(955, 7, 'IK1225', 'NOAH', 'ISABIRYE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512306579, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(956, 7, 'IK1413', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0065', 0, '56000000.00', 100, '', 8, 1512306593, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(957, 7, 'IK0749', 'NAMUSOMBYA', ' FLORENCE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0053', 0, '40000000.00', 100, '', 8, 1512306597, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(958, 7, 'IK1414', 'FRED', 'MAGALA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0151', 0, '56000000.00', 100, '', 8, 1512306656, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(959, 7, 'IK0750', 'SARAH', 'KISAKYE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0069', 0, '40000000.00', 100, '', 8, 1512306670, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(960, 7, 'IK0751', 'FATUMA', 'KYOTALIMYE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0073', 0, '40000000.00', 100, '', 8, 1512306704, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(961, 7, 'IK1226', 'PATRICK', 'TAAGULE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0044', 0, '24000000.00', 100, '', 8, 1512306729, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(962, 7, 'IK0752', 'ROSE', 'NABIRYE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0057', 0, '40000000.00', 100, '', 8, 1512306746, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(963, 7, 'IK0753', 'RHODHA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0053', 0, '40000000.00', 100, '', 8, 1512306777, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(964, 7, 'IK1227', 'NABITENDE', 'UGANDA POLICE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0080', 0, '24000000.00', 100, '', 8, 1512306825, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(965, 7, 'IK0754', 'ISUFU', 'DOUTA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0204', 0, '40000000.00', 100, '', 8, 1512306830, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(966, 7, 'IK0755', 'JESCA', 'IBANDA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0074', 0, '40000000.00', 100, '', 8, 1512306874, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(967, 7, 'IK0226', 'AYUB', 'MBOGO', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0112', 0, '32000000.00', 100, '', 8, 1512306920, 1, '2017-12-15 09:55:45', 1, 'DISTRIBUTION LINE', 1),
(968, 7, 'IK1228', 'JOHN', 'BAFANA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0053', 0, '24000000.00', 100, '', 8, 1512306926, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(969, 7, 'IK0756', 'GODFREY', 'KYOMYA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512306929, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(970, 7, 'IK0757', 'KYOMA', 'JOHN', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0059', 0, '40000000.00', 100, '', 8, 1512306969, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(971, 7, 'IK1132', 'JAMIR', '  NGOBI', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0070', 0, '24000000.00', 100, '', 8, 1512307007, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(972, 7, 'IK0758', 'KILUNZE', 'MICHEAL', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0082', 0, '40000000.00', 100, '', 8, 1512307019, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(973, 7, 'IK0227', 'BAZIBA', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0043', 0, '32000000.00', 100, '', 8, 1512307024, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(974, 7, 'IK1229', 'ELIZAFANI', 'MAFABI', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0034', 0, '24000000.00', 100, '', 8, 1512307045, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(975, 7, 'IK1415', ' ', 'BWOYI', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0120', 0, '56000000.00', 100, '', 8, 1512307063, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(976, 7, 'IK0759', 'PHILIP', 'MULWANYI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0269', 0, '40000000.00', 100, '', 8, 1512307082, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(977, 7, 'IK1133', 'IVAN', 'KOMUNTALE', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0055', 0, '24000000.00', 100, '', 8, 1512307085, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(978, 7, 'IK1416', 'SDA SCHOOL & CHURCH', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0713', 0, '56000000.00', 100, '', 0, 1512307114, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(979, 7, 'IK1230', 'ENOCK', 'MAGALA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512307128, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(980, 7, 'IK0761', 'KALIBALA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0079', 0, '40000000.00', 100, '', 8, 1512307191, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(981, 7, 'IK1134', 'JUMA', '  KAMANYA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0087', 0, '24000000.00', 100, '', 8, 1512307200, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(982, 7, 'IK1231', 'TILIBUZA', 'WILSON', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0075', 0, '24000000.00', 100, '', 8, 1512307205, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(983, 7, 'IK0228', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0043', 0, '32000000.00', 100, '', 8, 1512307241, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(984, 7, 'IK1232', 'SAMANYA', '', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0077', 0, '24000000.00', 100, '', 8, 1512307276, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(985, 7, 'IK1417', 'JAMES', 'NSAKO', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0098', 0, '56000000.00', 100, '', 8, 1512307283, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(986, 7, 'IK1135', 'JUMA ', 'TEOPISTA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0062', 0, '24000000.00', 100, '', 8, 1512307303, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(987, 7, 'IK1418', 'DISCIPLESHIP CHURCH', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0152', 0, '56000000.00', 100, '', 8, 1512307333, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(988, 7, 'IK1233', 'WILLIAM', 'KAITA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0037', 0, '24000000.00', 100, '', 8, 1512307415, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(989, 7, 'IK1136', 'LEAH', 'DIDI', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0096', 0, '24000000.00', 100, '', 8, 1512307460, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(990, 7, 'IK1234', 'CHRISTOPHER', 'MAFUMU', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0090', 0, '24000000.00', 100, '', 8, 1512307536, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(991, 7, 'IK1137', 'STEVEN', 'NAMPINDO', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0109', 0, '24000000.00', 100, '', 8, 1512307593, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(992, 7, 'IK1235', 'MUTESI', 'BAWAYE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0039', 0, '24000000.00', 100, '', 8, 1512307642, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(993, 7, 'IK1236', 'DEO', '', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0042', 0, '24000000.00', 100, '', 8, 1512307707, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(994, 7, 'IK1138', 'MWENYANGO', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0049', 0, '24000000.00', 100, '', 8, 1512307712, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(995, 7, 'IK1139', 'SULAIT', 'BALIKOWA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0062', 0, '24000000.00', 100, '', 8, 1512307797, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(996, 7, 'IK1237', 'ARAMANZAN', 'KALEEBA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512307814, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(997, 7, 'IK1419', ' ', 'MUSOMERWA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0281', 0, '56000000.00', 100, '', 8, 1512307898, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(998, 7, 'IK1140', 'UNKNOWN CHURCH', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0157', 0, '24000000.00', 100, '', 8, 1512307908, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(999, 7, 'IK1238', 'BRUHAN', 'LUKALABYE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512307908, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(1000, 7, 'IK1239', 'JAMAWA', 'BABIRYE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0186', 0, '24000000.00', 100, '', 8, 1512308010, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(1001, 7, 'IK1420', 'NSEREKO', 'LUKABWE', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0330', 0, '56000000.00', 100, '', 8, 1512308013, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(1002, 7, 'IK1141', 'DAUDI', 'KALAMAWO', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0111', 0, '24000000.00', 100, '', 8, 1512308013, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1003, 7, 'IK1421', 'NELSON', 'MUGONYA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0225', 0, '56000000.00', 100, '', 8, 1512308071, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(1004, 7, 'IK1240', 'HABIB', 'MUKOSE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0051', 0, '24000000.00', 100, '', 8, 1512308082, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(1005, 7, 'IK1422', 'PETE', 'SININI', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0231', 0, '56000000.00', 100, '', 8, 1512308132, 1, '2017-12-15 09:56:52', 1, 'DISTRIBUTION LINE', 1),
(1006, 7, 'IK1241', 'FRED', 'KIGOGO', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0084', 0, '24000000.00', 100, '', 8, 1512308167, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(1007, 7, 'IK1423', ' ', 'MUNYOLO', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0173', 0, '56000000.00', 100, '', 8, 1512308176, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1008, 7, 'IK1424', 'WILLIAM', 'BALABA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0245', 0, '56000000.00', 100, '', 8, 1512308213, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1009, 7, 'IK1242', 'HARRIET', 'NABIRYE', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0096', 0, '24000000.00', 100, '', 8, 1512308231, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(1010, 7, 'IK1425', 'UNKNOWN (HEADMASTER)', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0192', 0, '56000000.00', 100, '', 8, 1512308255, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1011, 7, 'IK1143', 'GEORGE', 'NDOMBA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0082', 0, '24000000.00', 100, '', 8, 1512308276, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1012, 7, 'IK1243', 'BATWAWULA', '', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0050', 0, '24000000.00', 100, '', 8, 1512308301, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(1013, 7, 'IK1144', 'NAJIB', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512308358, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1014, 7, 'IK1244', 'MONICA', 'YOYETA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0033', 0, '24000000.00', 100, '', 8, 1512308385, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(1015, 7, 'IK1426', 'KAYONGO', 'SEVUME', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0280', 0, '56000000.00', 100, '', 8, 1512308394, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1016, 7, 'IK0714-1', 'KYEMANYA', 'JOYCE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0069', 0, '40000000.00', 100, '', 8, 1512308415, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1017, 7, 'IK0714-2', 'SAIDI', 'KIYEMBA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0021', 0, '40000000.00', 100, '', 8, 1512308447, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1018, 7, 'IK1145', 'RAJAB', 'BATWAWULA ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0063', 0, '24000000.00', 100, '', 8, 1512308453, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1019, 7, 'IK1427', 'GODFREY', 'BAIDHU', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0086', 0, '56000000.00', 100, '', 8, 1512308458, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1020, 7, 'IK1245', 'ISAMAIL', '', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0060', 0, '24000000.00', 100, '', 8, 1512308465, 1, '2017-12-15 09:56:42', 1, 'DISTRIBUTION LINE', 1),
(1021, 7, 'IK0714-3', 'KANYAALA', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0100', 0, '40000000.00', 100, '', 8, 1512308476, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1022, 7, 'IK0714-4', 'TOM', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0046', 0, '40000000.00', 100, '', 8, 1512308501, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1023, 7, 'IK1428', 'SAMUEL', 'TUBINGWA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0080', 0, '56000000.00', 100, '', 8, 1512308504, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1024, 7, 'IK1246', 'ZIYADI', '', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0050', 0, '24000000.00', 100, '', 8, 1512308541, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1025, 7, 'IK0714-5', 'BAZALE', 'KENEDY', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0056', 0, '40000000.00', 100, '', 8, 1512308547, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1026, 7, 'IK1429', 'NATIONAL WATER & SEWERAGE CORPORATION', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0165', 0, '56000000.00', 100, '', 0, 1512308549, 1, '2017-12-15 09:56:53', 1, 'Select comment ...', 1),
(1027, 7, 'IK1146', 'MUZAMIRU', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0053', 0, '24000000.00', 100, '', 8, 1512308578, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1028, 7, 'IK0714-6', 'MUTASA WILSON', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0096', 0, '40000000.00', 100, '', 8, 1512308590, 1, '2017-12-15 09:56:12', 1, 'TRANSMISSION LINE', 1),
(1029, 7, 'IK1430', 'MOGAS FUEL STATION', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0187', 0, '56000000.00', 100, '', 8, 1512308606, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1030, 7, 'IK1247', 'SHAMIM', 'NAMUTAMBA', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0045', 0, '24000000.00', 100, '', 8, 1512308615, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1031, 7, 'IK0714-7', 'MAGANDA', 'ROBERT', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0040', 0, '40000000.00', 100, '', 8, 1512308622, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1032, 7, 'IK1431', 'SAMSON', 'SANDE', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0256', 0, '56000000.00', 100, '', 8, 1512308648, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1034, 7, 'IK1147', 'ALONI', 'KIBULA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0102', 0, '24000000.00', 100, '', 8, 1512308676, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1035, 7, 'IK0714-9', 'MAGANDA', 'JAMES', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0214', 0, '40000000.00', 100, '', 8, 1512308687, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1036, 7, 'IK1432', 'ISAAC', 'KUBIGOGO', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0147', 0, '56000000.00', 100, '', 8, 1512308696, 1, '2017-12-15 09:56:53', 1, 'DISTRIBUTION LINE', 1),
(1037, 7, 'IK0714-10', 'NABIRYE', 'AIDAH', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0102', 0, '40000000.00', 100, '', 8, 1512308718, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1038, 7, 'IK0714-11', 'MAGANDA', 'GEOFREY', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0038', 0, '40000000.00', 100, '', 8, 1512308748, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1039, 7, 'IK1248', 'VICTORY PREPARATION SCHOOL', '..', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0342', 0, '24000000.00', 100, '', 8, 1512308751, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1040, 7, 'IK1148', 'UNKNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0055', 0, '24000000.00', 100, '', 8, 1512308759, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1041, 7, 'IK0714-12', 'TIBITA', 'NATHAN', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0051', 0, '40000000.00', 100, '', 8, 1512308787, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1042, 7, 'IK1149', 'BATUMULE', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0067', 0, '24000000.00', 100, '', 8, 1512308827, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1043, 7, 'IK1249', 'BALYELABIRA', 'GLADYS', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.2127', 0, '24000000.00', 100, '', 8, 1512308838, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1044, 7, 'IK0716-1', 'MAGANDA', 'JOSHUA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0030', 0, '0.00', 0, '', 8, 1512308882, 1, '2017-12-15 09:44:31', 1, 'DISTRIBUTION LINE', 1),
(1045, 7, 'IK1150', 'FAZIRI', 'LUUKA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0056', 0, '24000000.00', 100, '', 8, 1512308884, 1, '2017-12-15 09:56:37', 1, 'Select comment ...', 1),
(1046, 7, 'IK1433', 'TONGA', 'NAMBI', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0667', 0, '56000000.00', 100, '', 8, 1512308906, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1047, 7, 'IK1250', 'WILBERFORCE', 'MUTI', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0280', 0, '24000000.00', 100, '', 8, 1512308915, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1048, 7, 'IK0716-2', 'LOY', 'NAMAGANDA', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0027', 0, '0.00', 0, '', 8, 1512308932, 1, '2017-12-15 09:44:31', 1, 'DISTRIBUTION LINE', 1),
(1049, 7, 'IK1151', 'UNKNOWN TEACHER', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0068', 0, '24000000.00', 100, '', 8, 1512308942, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1050, 7, 'IK1434', ' ', 'MRS. WAISWA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0226', 0, '56000000.00', 100, '', 8, 1512308950, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1051, 7, 'IK0716-3', 'BEATRICE', 'NANGOBI', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0096', 0, '0.00', 0, '', 8, 1512308966, 1, '2017-12-15 09:44:32', 1, 'DISTRIBUTION LINE', 1),
(1052, 7, 'IK1435', 'KAMUDAN', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0087', 0, '56000000.00', 100, '', 8, 1512309003, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1);
INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, `chainage`, `tenure`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`, `active`) VALUES
(1053, 7, 'IK0716-4', 'NKUTILA', 'JOHN', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0070', 0, '0.00', 0, '', 8, 1512309004, 1, '2017-12-15 09:44:32', 1, 'DISTRIBUTION LINE', 1),
(1054, 7, 'IK1152', 'BAMU', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0053', 0, '24000000.00', 100, '', 8, 1512309018, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1055, 7, 'IK0716-5', 'SAM', 'MWANJE', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0132', 0, '0.00', 0, '', 8, 1512309036, 1, '2017-12-15 09:44:32', 1, 'DISTRIBUTION LINE', 1),
(1056, 7, 'IK1436', 'SEKITO', 'KIRUMIRA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0229', 0, '56000000.00', 100, '', 8, 1512309047, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1057, 7, 'IK0716-6', 'UGANDA POLICE, KAWETE', ' ', '', '', 33, 0, 3, 13, 12, '1', '0.0000', '0.0000', '0.0102', 0, '40000000.00', 100, '', 8, 1512309068, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1058, 7, 'IK1153', 'KARIM', 'NTOLA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0057', 0, '24000000.00', 100, '', 8, 1512309074, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1059, 7, 'IK1437', 'PETERSON', 'BASALIRWA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0428', 0, '56000000.00', 100, '', 8, 1512309086, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1060, 7, 'IK1438', 'DAVID', 'WAYA', 'PEERA', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0199', 0, '56000000.00', 100, '', 8, 1512309148, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1061, 7, 'IK1154', 'MARTIN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0049', 0, '24000000.00', 100, '', 8, 1512309180, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1062, 7, 'IK1439', 'LIVINGSTONE', 'WALIWA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512309207, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1063, 7, 'IK1155', 'YOLISIGILA', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0041', 0, '24000000.00', 100, '', 8, 1512309285, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1064, 7, 'IK0958', 'MIRABU', 'DHEYONGERA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0058', 0, '24000000.00', 100, '', 8, 1512309291, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1065, 7, 'IK1440', 'UNKNOWN CHURCH', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0074', 0, '56000000.00', 100, '', 8, 1512309301, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1066, 7, 'IK1252', 'WANUME', '', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0294', 0, '56000000.00', 100, '', 8, 1512309315, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1067, 7, 'IK1156', 'UNKNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0047', 0, '24000000.00', 100, '', 8, 1512309349, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1068, 7, 'IK1441', 'DIVINE CHURCH', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0144', 0, '56000000.00', 100, '', 8, 1512309352, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1069, 7, 'IK0957', 'JIMMY', 'LUWULIZA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0096', 0, '24000000.00', 100, '', 8, 1512309358, 1, '2017-12-15 09:56:26', 1, 'Select comment ...', 1),
(1070, 7, 'IK0959', 'EMANUEL', 'NALUWAYO', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0044', 0, '24000000.00', 100, '', 8, 1512309406, 1, '2017-12-15 09:56:26', 1, 'Select comment ...', 1),
(1071, 7, 'IK1157', 'UNKNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0073', 0, '24000000.00', 100, '', 8, 1512309443, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1072, 7, 'IK1443', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0250', 0, '56000000.00', 100, '', 8, 1512309494, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1074, 7, 'IK0960', ' ', 'NAMUGERE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0069', 0, '24000000.00', 100, '', 8, 1512309534, 1, '2017-12-15 09:56:27', 1, 'Select comment ...', 1),
(1075, 7, 'IK1158', 'WILLIAM', 'KULUNAKU', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0058', 0, '24000000.00', 100, '', 8, 1512309550, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1076, 7, 'IK1442', ' ', 'KYEYE', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0378', 0, '56000000.00', 100, '', 8, 1512309587, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1077, 7, 'IK1444', 'PETERSON', 'BASALIRWA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0000', 0, '56000000.00', 100, '', 8, 1512309634, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1078, 7, 'IK1159', 'UNKNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0028', 0, '24000000.00', 100, '', 8, 1512309661, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1079, 7, 'IK0961', 'RICHARD', 'KIBWIKA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0057', 0, '24000000.00', 100, '', 8, 1512309725, 1, '2017-12-15 09:56:27', 1, 'Select comment ...', 1),
(1080, 7, 'IK1160', 'BAKER', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0053', 0, '24000000.00', 100, '', 8, 1512309752, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1081, 7, 'IK1445', 'MISE', 'MAGANDA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0080', 0, '56000000.00', 100, '', 8, 1512309761, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1083, 7, 'IK1446', ' ', 'BAATE', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0040', 0, '56000000.00', 100, '', 8, 1512309807, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1084, 7, 'IK0962', 'FRANCIS', 'KADUMBULA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0068', 0, '24000000.00', 100, '', 8, 1512309869, 1, '2017-12-15 09:56:27', 1, 'Select comment ...', 1),
(1085, 7, 'IK1447', ' ', 'BANGI', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0036', 0, '56000000.00', 100, '', 8, 1512309871, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1086, 7, 'IK1253', 'YONA', 'MUSASIZI', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0604', 0, '56000000.00', 100, '', 8, 1512309879, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1087, 7, 'IK1160-1', 'IBULAHIM', 'MUNILWA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0025', 0, '24000000.00', 100, '', 8, 1512309918, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1088, 7, 'IK1448', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0151', 0, '56000000.00', 100, '', 8, 1512309930, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1089, 7, 'IK1161', 'ZAITUNI', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0033', 0, '24000000.00', 100, '', 8, 1512309993, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1090, 7, 'IK1449', 'FATINAH', 'NABIRYE', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0077', 0, '56000000.00', 100, '', 8, 1512310037, 1, '2017-12-15 09:56:54', 1, 'DISTRIBUTION LINE', 1),
(1091, 7, 'IK1251', 'TIBITA', '...', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0114', 0, '56000000.00', 100, '', 8, 1512310048, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1092, 7, 'IK1162', 'EDWARD', 'NYONGEZA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0077', 0, '24000000.00', 100, '', 8, 1512310103, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1093, 7, 'IK1450', ' ', 'MUSOMESA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0075', 0, '56000000.00', 100, '', 8, 1512310110, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1094, 7, 'IK1451', 'LATIF', 'KAYEMBA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0073', 0, '56000000.00', 100, '', 8, 1512310164, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1095, 7, 'IK1163', 'KIBWIIKA', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0063', 0, '24000000.00', 100, '', 8, 1512310176, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1096, 7, 'IK1164', 'ZAUMA', ' ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0122', 0, '24000000.00', 100, '', 8, 1512310232, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1097, 7, 'IK1165', 'MUSOMESA', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0038', 0, '24000000.00', 100, '', 8, 1512310291, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1098, 7, 'IK1166', 'SEKA', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0068', 0, '24000000.00', 100, '', 8, 1512310346, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1099, 7, 'IK1254', 'CHARLES', 'NKWESI', '', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0066', 0, '56000000.00', 100, '', 8, 1512310357, 1, '2017-12-15 09:56:43', 1, 'PUBLIC TOILET SITE', 1),
(1100, 7, 'IK1452', 'ABBATOIR', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0338', 0, '56000000.00', 100, '', 8, 1512310379, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1101, 7, 'IK1453', 'IDAYA', 'PEERA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0180', 0, '56000000.00', 100, '', 8, 1512310437, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1102, 7, 'IK1255', 'NTUYO', 'WILSON', 'Public Toilet Site', '', 33, 0, 2, 10, 35, '1', '0.0000', '0.0000', '0.0287', 0, '56000000.00', 100, '', 0, 1512310460, 1, '2017-12-15 09:56:43', 1, 'PUBLIC TOILET SITE', 1),
(1103, 7, 'IK1167', 'BEATU (MISSING SURVEYOR)', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0040', 0, '24000000.00', 100, '', 8, 1512310481, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1104, 7, 'IK1454', ' ', 'AFANDE MUKEMBO', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0071', 0, '56000000.00', 100, '', 8, 1512310496, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1105, 7, 'IK0963', ' ', 'MANDE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0044', 0, '24000000.00', 100, '', 8, 1512310502, 1, '2017-12-15 09:56:27', 1, 'DISTRIBUTION LINE', 1),
(1106, 7, 'IK1455', 'UNKNOWN', ' ', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0110', 0, '56000000.00', 100, '', 8, 1512310528, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1107, 7, 'IK1168', 'HAKIM', 'KIGENYI', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0073', 0, '24000000.00', 100, '', 8, 1512310545, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1108, 7, 'IK1256', 'KALIRO DIARY COPERATION', '.', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0136', 0, '56000000.00', 100, '', 8, 1512310553, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1109, 7, 'IK1456', ' ', 'MUYODHI', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0096', 0, '56000000.00', 100, '', 8, 1512310566, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1110, 7, 'IK1457', ' ', 'SOONI', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0052', 0, '56000000.00', 100, '', 8, 1512310601, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1111, 7, 'IK1169', 'UNKNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0047', 0, '24000000.00', 100, '', 8, 1512310619, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1112, 7, 'IK1257', 'HAMMED', 'SALIM', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0283', 0, '56000000.00', 100, '', 8, 1512310643, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1113, 7, 'IK0964', 'GEORGE', 'WALUKAGA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0091', 0, '24000000.00', 100, '', 8, 1512310670, 1, '2017-12-15 09:56:27', 1, 'Select comment ...', 1),
(1114, 7, 'IK1458', 'IDDI', 'NANSANA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0088', 0, '56000000.00', 100, '', 8, 1512310681, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1115, 7, 'IK1170', 'JULIET', 'NAIKOBA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0061', 0, '24000000.00', 100, '', 8, 1512310692, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1116, 7, 'IK1258', 'JAMES', 'MULYANTI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0083', 0, '56000000.00', 100, '', 8, 1512310721, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1117, 7, 'IK0965', 'LUGANDA', 'TAKWEMAZA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0211', 0, '24000000.00', 100, '', 8, 1512310721, 1, '2017-12-15 09:56:27', 1, 'Select comment ...', 1),
(1118, 7, 'IK0229', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0052', 0, '32000000.00', 100, '', 8, 1512310725, 1, '2017-12-15 09:55:45', 1, 'DISTRIBUTION LINE', 1),
(1119, 7, 'IK1459', ' ', 'WANTAGWA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0040', 0, '56000000.00', 100, '', 8, 1512310749, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1120, 7, 'IK0966', 'DAUDI', 'KASOLO', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0251', 0, '24000000.00', 100, '', 8, 1512310764, 1, '2017-12-15 09:56:27', 1, 'Select comment ...', 1),
(1121, 7, 'IK1171', 'GRACE', 'KAHUNA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0061', 0, '24000000.00', 100, '', 8, 1512310773, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1122, 7, 'IK0230', 'ALISTAI', 'NAMABANDA', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0062', 0, '32000000.00', 100, '', 8, 1512310774, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(1123, 7, 'IK1460', ' ', 'HAJJI BUMBA', '', '', 41, 0, 6, 8, 31, '1', '0.0000', '0.0000', '0.0289', 0, '56000000.00', 100, '', 8, 1512310835, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1124, 7, 'IK0231', 'BANDA', 'KIZZA', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0084', 0, '32000000.00', 100, '', 8, 1512310850, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(1125, 7, 'IK0967', 'NASSER', 'WANDERA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0119', 0, '24000000.00', 100, '', 0, 1512310852, 1, '2017-12-15 09:56:27', 1, 'Select comment ...', 1),
(1126, 7, 'IK1259', 'AMAL', 'MUHAMMED', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0423', 0, '56000000.00', 100, '', 8, 1512310873, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1127, 7, 'IK1260', 'PATRICK', 'KADAMA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0445', 0, '56000000.00', 100, '', 8, 1512310999, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1128, 7, 'IK1261', 'MPUGI', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0082', 0, '56000000.00', 100, '', 8, 1512311101, 1, '2017-12-15 09:56:43', 1, 'DISTRIBUTION LINE', 1),
(1129, 7, 'IK1172', 'PASTOR', 'KIHUNA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0043', 0, '24000000.00', 100, '', 8, 1512311159, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1130, 7, 'IK0968', ' ', 'LULEMA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0042', 0, '24000000.00', 100, '', 8, 1512311169, 1, '2017-12-15 09:56:27', 1, 'DISTRIBUTION LINE', 1),
(1131, 7, 'IK1173', 'JOSEPH', 'BAGEYE', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0073', 0, '24000000.00', 100, '', 8, 1512311221, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1132, 7, 'IK1262', 'KANSALA', 'SAM', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0049', 0, '56000000.00', 100, '', 8, 1512311233, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1133, 7, 'IK0969', 'PAUL', 'KOOWA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0081', 0, '24000000.00', 100, '', 0, 1512311283, 1, '2017-12-15 09:56:27', 1, 'Select comment ...', 1),
(1134, 7, 'IK1263', 'HENRY', 'IGOMBE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0080', 0, '56000000.00', 100, '', 8, 1512311305, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1135, 7, 'IK1174', 'MICHEAL', 'KYANA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0050', 0, '24000000.00', 100, '', 8, 1512311322, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1136, 7, 'IK1264', 'MUKUNYA', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0164', 0, '56000000.00', 100, '', 8, 1512311382, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1137, 7, 'IK1265', 'PATRICK', 'JONGA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0277', 0, '56000000.00', 100, '', 8, 1512311454, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1138, 7, 'IK1470', 'PAUL', ' ', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0176', 0, '56000000.00', 100, '', 8, 1512311534, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1139, 7, 'IK0232', 'AIDAH', 'NAKISUYI', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0308', 0, '32000000.00', 100, '', 8, 1512311597, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(1140, 7, 'IK1471', 'JULIUS', 'LUTA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0238', 0, '56000000.00', 100, '', 0, 1512311610, 1, '2017-12-15 09:56:55', 1, 'Select comment ...', 1),
(1141, 7, 'IK1175', 'ARAMANZANI', 'KUUNYA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0036', 0, '24000000.00', 100, '', 8, 1512311659, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1142, 7, 'IK1266', 'SUZAN', 'KAWALA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0052', 0, '56000000.00', 100, '', 8, 1512311659, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1143, 7, 'IK1472', 'GODFREY', 'MUTALYA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0075', 0, '56000000.00', 100, '', 8, 1512311670, 1, '2017-12-15 09:56:55', 1, 'Select comment ...', 1),
(1144, 7, 'IK0233', 'FRANK ', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0110', 0, '32000000.00', 100, '', 8, 1512311677, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(1145, 7, 'IK1473', 'DAVID', 'MUWANIKA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0036', 0, '56000000.00', 100, '', 8, 1512311722, 1, '2017-12-15 09:56:55', 1, 'Select comment ...', 1),
(1146, 7, 'IK0233', 'KADANGADI FAMILY', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0110', 0, '32000000.00', 100, '', 8, 1512311748, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(1147, 7, 'IK1267', 'MOSES', 'NSABAGWA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0042', 0, '56000000.00', 100, '', 8, 1512311770, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1148, 7, 'IK1176', 'WILSON', 'BALISONIYIWA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0036', 0, '24000000.00', 100, '', 8, 1512311772, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1149, 7, 'IK1474', 'JAMES', 'SINZE', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0040', 0, '56000000.00', 100, '', 8, 1512311774, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1150, 7, 'IK1475', 'BOB', 'MWIDU', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0081', 0, '56000000.00', 100, '', 8, 1512311806, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1151, 7, 'IK0235', 'ARAMANZAN', 'MUGABI', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0065', 0, '32000000.00', 100, '', 8, 1512311836, 1, '2017-12-15 09:55:45', 1, 'Select comment ...', 1),
(1152, 7, 'IK1177', 'JOSEPH', 'BAGEYE', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0027', 0, '24000000.00', 100, '', 8, 1512311837, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1153, 7, 'IK1476', ' ', 'GULIKU', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0071', 0, '56000000.00', 100, '', 8, 1512311860, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1154, 7, 'IK1268', 'WILLIAM', 'JEJE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0071', 0, '56000000.00', 100, '', 8, 1512311865, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1155, 7, 'IK0236', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0062', 0, '32000000.00', 100, '', 8, 1512311874, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1156, 7, 'IK1477', ' ', 'GULELE', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0184', 0, '56000000.00', 100, '', 8, 1512311895, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1157, 7, 'IK0237', 'STEVEN', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0089', 0, '32000000.00', 100, '', 8, 1512311930, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1158, 7, 'IK1478', ' ', 'UNKNOWN', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0038', 0, '56000000.00', 100, '', 8, 1512311935, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1159, 7, 'IK1178', 'FRED', 'LUTAYA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0067', 0, '24000000.00', 100, '', 8, 1512311938, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1160, 7, 'IK1269', 'GRACE', '  ', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0141', 0, '56000000.00', 100, '', 8, 1512311952, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1161, 7, 'IK0238', 'LUKE', 'OGAYA', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0437', 0, '32000000.00', 100, '', 8, 1512311989, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1162, 7, 'IK1479', 'MOSES', 'ADISON', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0079', 0, '56000000.00', 100, '', 8, 1512311989, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1163, 7, 'IK1480', 'HAKIM', 'NKONO', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0077', 0, '56000000.00', 100, '', 8, 1512312028, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1164, 7, 'IK1178-1', 'GILBERT', 'BASOGA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0035', 0, '24000000.00', 100, '', 8, 1512312043, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1165, 7, 'IK1481', 'SIMON', 'GULIKU', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0075', 0, '56000000.00', 100, '', 8, 1512312064, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1166, 7, 'IK1482', ' ', 'UNKNOWN', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0069', 0, '56000000.00', 100, '', 8, 1512312095, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1167, 7, 'IK1179', 'FRED', '  LUTAYA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '2.0102', 0, '24000000.00', 100, '', 8, 1512312104, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1168, 7, 'IK1483', 'ABDU', 'MWIDU', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0071', 0, '56000000.00', 100, '', 8, 1512312130, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1169, 7, 'IK0239', 'OGAYA', ' ', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0284', 0, '32000000.00', 100, '', 8, 1512312139, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1170, 7, 'IK1270', 'CHARLES', 'MUKOSE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0070', 0, '56000000.00', 100, '', 8, 1512312156, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1171, 7, 'IK1180', 'UNKNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0039', 0, '24000000.00', 100, '', 8, 1512312176, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1172, 7, 'IK1484', 'KARIM', 'NSUNGU', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0134', 0, '56000000.00', 100, '', 8, 1512312192, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1173, 7, 'IK0240', 'SAULO', 'KASANGO', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0344', 0, '32000000.00', 100, '', 8, 1512312202, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1174, 7, 'IK1485', 'FRED', 'MBALUMYE', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0043', 0, '56000000.00', 100, '', 8, 1512312230, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1175, 7, 'IK0241', 'SULA', 'MUGABO', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0146', 0, '32000000.00', 100, '', 8, 1512312240, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1176, 7, 'IK1486', 'PATRICK', 'WAYAMBUKA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0077', 0, '56000000.00', 100, '', 0, 1512312275, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1178, 7, 'IK1181', 'YOWERI', 'DHAMUZUNGU', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0077', 0, '24000000.00', 100, '', 8, 1512312303, 1, '2017-12-15 09:56:38', 1, 'DISTRIBUTION LINE', 1),
(1179, 7, 'IK1487', 'SALEH', ' ', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0072', 0, '56000000.00', 100, '', 8, 1512312304, 1, '2017-12-15 09:56:56', 1, 'Select comment ...', 1),
(1180, 7, 'IK1182', 'UNKNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0050', 0, '24000000.00', 100, '', 8, 1512312357, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1181, 7, 'IK1488', 'FRED', 'MBALUMYA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0074', 0, '56000000.00', 100, '', 8, 1512312359, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1182, 7, 'IK1272', 'EDWARD', 'WALUSIMBI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0562', 0, '56000000.00', 100, '', 8, 1512312439, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1183, 7, 'IK1183', 'KARIM', 'KISULE', 'BULUMA', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0044', 0, '24000000.00', 100, '', 8, 1512312542, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1184, 7, 'IK1184', 'RICHARD', 'KIDUNDU', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0104', 0, '24000000.00', 100, '', 8, 1512312712, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1185, 7, 'IK1273', 'PETUA', 'NANGOBI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0229', 0, '56000000.00', 100, '', 8, 1512312771, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1186, 7, 'IK1489', 'TOM', 'WAYAMBUKA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0115', 0, '56000000.00', 100, '', 8, 1512312784, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1187, 7, 'IK1185', 'TABLIQ', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0026', 0, '24000000.00', 100, '', 8, 1512312802, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1188, 7, 'IK1186', 'UNKNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0152', 0, '24000000.00', 100, '', 8, 1512312870, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1189, 7, 'IK1491', 'FRED', 'MBALUMYA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0072', 0, '56000000.00', 100, '', 8, 1512312907, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1190, 7, 'IK1274', 'EDWARD', 'WALUSIMBI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0650', 0, '56000000.00', 100, '', 8, 1512312974, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1191, 7, 'IK1188', 'ZIRONDA', 'KANKUBISA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0075', 0, '24000000.00', 100, '', 8, 1512312983, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1192, 7, 'IK1492', 'AIRTEL', 'MAST', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0150', 0, '56000000.00', 100, '', 8, 1512312992, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1193, 7, 'IK1493', 'CHARLES', 'GELI', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0077', 0, '56000000.00', 100, '', 8, 1512313050, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1194, 7, 'IK1275', 'HAMDAN', 'BAGEYA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0140', 0, '56000000.00', 100, '', 8, 1512313079, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1195, 7, 'IK1494', ' ', 'UNKNOWN', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512313095, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1196, 7, 'IK1189', 'BYABEYI', 'KYABEYO', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0159', 0, '24000000.00', 100, '', 8, 1512313123, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1197, 7, 'IK1495', 'MUSEKWA', 'OCHENG', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0073', 0, '56000000.00', 100, '', 8, 1512313148, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1198, 7, 'IK1496', 'ROSE', 'MUWUMBA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0076', 0, '56000000.00', 100, '', 8, 1512313192, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1199, 7, 'IK1276', 'AGREY', 'MULAMBAZI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0061', 0, '56000000.00', 100, '', 8, 1512313198, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1200, 7, 'IK0243', 'PETER', 'NABONGO', '', '', 33, 0, 9, 19, 28, '1', '0.0000', '0.0000', '0.0000', 0, '32000000.00', 0, '', 9, 1512313210, 1, '2017-12-15 09:55:46', 1, 'DISTRIBUTION LINE', 1),
(1201, 7, 'IK1497', 'PATRICK', 'BABI', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0073', 0, '56000000.00', 100, '', 8, 1512313231, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1202, 7, 'IK1190', 'PAUL', 'MBAGO', '', '0755995531', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0127', 0, '24000000.00', 100, '', 8, 1512313249, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1203, 7, 'IK1277', 'PETER', 'WAHAPI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0063', 0, '56000000.00', 100, '', 8, 1512313298, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1204, 7, 'IK1278', 'BUMBA', 'KADILI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0073', 0, '56000000.00', 100, '', 8, 1512313376, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1205, 7, 'IK1191', 'SAULO', 'MUWANGUZI', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0076', 0, '24000000.00', 100, '', 8, 1512313421, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1206, 7, 'IK1279', 'BETTY', 'NAKIBUKA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0283', 0, '56000000.00', 100, '', 8, 1512313435, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1207, 7, 'IK1498', ' ', 'KANUNA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0076', 0, '56000000.00', 100, '', 8, 1512313448, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1209, 7, 'IK1499', ' ', 'KYAKATUKA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0120', 0, '56000000.00', 100, '', 8, 1512313495, 1, '2017-12-15 09:56:57', 1, 'Select comment ...', 1),
(1210, 7, 'IK1192', 'SAULO', 'MBIDE', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512313523, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1211, 7, 'IK1280', 'YOWERI', 'MUYOLA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0186', 0, '56000000.00', 100, '', 8, 1512313524, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1212, 7, 'IK1500', ' ', 'KATO', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0175', 0, '56000000.00', 100, '', 8, 1512313532, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1213, 7, 'IK0244', 'KARIM', 'ISABIRYE', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0126', 0, '20000000.00', 100, '', 8, 1512313537, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1214, 7, 'IK1501', ' ', 'MAYOR''S GARDEN', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0070', 0, '56000000.00', 100, '', 8, 1512313574, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1215, 7, 'IK1193', 'SOWEDI', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0054', 0, '24000000.00', 100, '', 8, 1512313601, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1216, 7, 'IK1502', ' ', 'SETI', 'PROFESSOR', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0213', 0, '56000000.00', 100, '', 8, 1512313624, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1217, 7, 'IK1503', ' ', 'UNKNOWN', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0269', 0, '56000000.00', 100, '', 8, 1512313654, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1218, 7, 'IK1281', 'KARIM', 'GWIRE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0098', 0, '56000000.00', 100, '', 8, 1512313668, 1, '2017-12-15 09:56:44', 1, 'DISTRIBUTION LINE', 1),
(1219, 7, 'IK1504', ' ', 'UNKNOWN', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0046', 0, '56000000.00', 100, '', 8, 1512313684, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1220, 7, 'IK1194', 'MATIYA', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0173', 0, '24000000.00', 100, '', 8, 1512313743, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1221, 7, 'IK1282', 'UNKNOWN', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0045', 0, '56000000.00', 100, '', 8, 1512313766, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1222, 7, 'IK1505', 'PAUL', 'BAFUKAWA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0046', 0, '56000000.00', 100, '', 8, 1512313826, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1223, 7, 'IK1506', ' ', 'MUGABI', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0036', 0, '56000000.00', 100, '', 8, 1512313862, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1224, 7, 'IK1195', 'AYUB', 'KYAKATUKA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0099', 0, '24000000.00', 100, '', 8, 1512313883, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1225, 7, 'IK1283', 'NABIRYE', 'MUHWEREZA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0071', 0, '56000000.00', 100, '', 8, 1512313884, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1226, 7, 'IK1507', 'GEOFREY', 'PEERA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0070', 0, '56000000.00', 100, '', 8, 1512313907, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1227, 7, 'IK1284', 'SAM', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0103', 0, '56000000.00', 100, '', 8, 1512313944, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1228, 7, 'IK1196', 'UN KNOWN', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0136', 0, '24000000.00', 100, '', 8, 1512313945, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1229, 7, 'IK1508', 'DAVID', 'MUGOODE', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0076', 0, '56000000.00', 100, '', 8, 1512313977, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1230, 7, 'IK0245', 'STEPHEN', 'MAGEMESO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0109', 0, '20000000.00', 100, '', 8, 1512313991, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1231, 7, 'IK1197', 'MATIYA', 'KYATEREKERA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0162', 0, '24000000.00', 100, '', 8, 1512314012, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1232, 7, 'IK1509', 'FREDRICK', 'NABEETA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0079', 0, '56000000.00', 100, '', 8, 1512314017, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1233, 7, 'IK0246', 'BALIDA', 'MIRABU', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0057', 0, '20000000.00', 100, '', 8, 1512314055, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1234, 7, 'IK1510', ' ', 'KAIRANYA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0075', 0, '56000000.00', 100, '', 8, 1512314056, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1235, 7, 'IK1511', 'JOHNSON', 'SABAGABO', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0075', 0, '56000000.00', 100, '', 8, 1512314088, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1236, 7, 'IK1198', 'PETER', 'KABONDE', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0178', 0, '24000000.00', 100, '', 8, 1512314091, 1, '2017-12-15 09:56:39', 1, 'DISTRIBUTION LINE', 1),
(1237, 7, 'IK1512', ' ', 'ISOOBA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0074', 0, '56000000.00', 100, '', 8, 1512314120, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1238, 7, 'IK0247', 'UNKNOWN', ' ', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0050', 0, '20000000.00', 100, '', 8, 1512314129, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1239, 7, 'IK1285', 'SANONI', 'DHIKWEMBYA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0220', 0, '56000000.00', 100, '', 8, 1512314133, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1240, 7, 'IK1199', 'BENEKITO', 'BYAKIKA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0174', 0, '24000000.00', 100, '', 8, 1512314204, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1241, 7, 'IK0248', 'NSADU & ISABIRYE', ' ', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0258', 0, '20000000.00', 100, '', 8, 1512314226, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1242, 7, 'IK1286', 'PAUL', 'BAVWEKUNO', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0193', 0, '56000000.00', 100, '', 8, 1512314231, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1243, 7, 'IK0249', 'STEPHEN ', 'MAGEMESO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0139', 0, '20000000.00', 100, '', 8, 1512314278, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1244, 7, 'IK1513', 'DAVID', 'WAAYA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0074', 0, '56000000.00', 100, '', 8, 1512314329, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1245, 7, 'IK1287', 'KHEFA', 'MUGALYA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0124', 0, '56000000.00', 100, '', 8, 1512314361, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1246, 7, 'IK1514', 'MARGARET', 'MBEIZA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0080', 0, '56000000.00', 100, '', 8, 1512314371, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1248, 7, 'IK1200', 'MOSES', 'BAGAGA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0354', 0, '24000000.00', 100, '', 8, 1512314372, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1249, 7, 'IK1515', 'BESWERI', 'BATWALUMA', 'KABONGE', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0068', 0, '56000000.00', 100, '', 8, 1512314415, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1250, 7, 'IK1201', 'JAMIR', 'NGOBI', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0106', 0, '24000000.00', 100, '', 8, 1512314454, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1251, 7, 'IK1288', 'STEVEN', 'KIYOBYO', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0067', 0, '56000000.00', 100, '', 8, 1512314455, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1252, 7, 'IK1202', 'KIBWIKA', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0172', 0, '24000000.00', 100, '', 8, 1512314507, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1253, 7, 'IK1289', 'BETTY', 'NAKIBUKA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0246', 0, '56000000.00', 100, '', 8, 1512314551, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1254, 7, 'IK1203', 'WAISWA', '   ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0048', 0, '24000000.00', 100, '', 8, 1512314571, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1255, 7, 'IK1204', 'NDAAYE', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0087', 0, '24000000.00', 100, '', 8, 1512314630, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1256, 7, 'IK1290', 'MOSES', 'MUSAZI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512314639, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1257, 7, 'IK1205', 'BAKARI', 'ISABIRYE', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0049', 0, '24000000.00', 100, '', 8, 1512314686, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1258, 7, 'IK1291', 'MOSES', 'MUTYALA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0073', 0, '56000000.00', 100, '', 8, 1512314708, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1259, 7, 'IK0250', 'UKNOWN', ' ', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0041', 0, '20000000.00', 100, '', 8, 1512314733, 1, '2017-12-15 09:55:46', 1, 'DISTRIBUTION LINE', 1),
(1260, 7, 'IK1206', 'MOSES', 'BAGAGA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0033', 0, '24000000.00', 100, '', 8, 1512314736, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1261, 7, 'IK1207', 'MUKUPYA', '  ', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0102', 0, '24000000.00', 100, '', 8, 1512314785, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1262, 7, 'IK1292', 'MUSA', 'BEATRICE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0162', 0, '56000000.00', 100, '', 8, 1512314791, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1263, 7, 'IK0251', 'MAKETE', 'LUKOWE', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0120', 0, '20000000.00', 100, '', 8, 1512314806, 1, '2017-12-15 09:55:46', 1, 'DISTRIBUTION LINE', 1),
(1264, 7, 'IK1208', 'JOYCE', '  MAFUTA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0246', 0, '24000000.00', 100, '', 8, 1512314859, 1, '2017-12-15 09:56:40', 1, 'DISTRIBUTION LINE', 1),
(1265, 7, 'IK1293', 'AARON', 'BALINYIGA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0096', 0, '56000000.00', 100, '', 8, 1512314893, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1266, 7, 'IK1516', 'MALIDADI', 'MULUMBA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512314915, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1267, 7, 'IK1209', 'ESUKA', 'MUSANA', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.2266', 0, '24000000.00', 100, '', 8, 1512314926, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(1268, 7, 'IK0252', 'FAROUK', 'ISABIRYE', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0081', 0, '20000000.00', 100, '', 8, 1512314932, 1, '2017-12-15 09:55:46', 1, 'DISTRIBUTION LINE', 1),
(1269, 7, 'IK1517', ' ', 'BOMBO', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0112', 0, '56000000.00', 100, '', 8, 1512314948, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1270, 7, 'IK1294', 'EDISA', 'MUGALA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0070', 0, '56000000.00', 100, '', 8, 1512314971, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1271, 7, 'IK1518', ' ', 'NFAAKI', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0084', 0, '56000000.00', 100, '', 8, 1512314977, 1, '2017-12-15 09:56:58', 1, 'Select comment ...', 1),
(1272, 7, 'IK1210', 'DAUDI', 'KALULU', '', '', 33, 0, 2, 10, 8, '1', '0.0000', '0.0000', '0.0636', 0, '24000000.00', 100, '', 8, 1512314991, 1, '2017-12-15 09:56:41', 1, 'DISTRIBUTION LINE', 1),
(1273, 7, 'IK1519', ' ', 'KAIRANYA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0047', 0, '56000000.00', 100, '', 8, 1512314999, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1274, 7, 'IK1520', 'EDRISA', ' ', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0039', 0, '56000000.00', 100, '', 8, 1512315038, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1275, 7, 'IK1295', 'DANIEL', 'MUSALO', 'SANDE', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0066', 0, '56000000.00', 100, '', 8, 1512315084, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1276, 7, 'IK1521', 'YUSUF', 'KASAJJA', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0036', 0, '56000000.00', 100, '', 8, 1512315090, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1277, 7, 'IK1522', 'GUSITE', ' ', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0075', 0, '56000000.00', 100, '', 8, 1512315127, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1278, 7, 'IK1523', 'PETER', 'GULIKU', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512315169, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1279, 7, 'IK1296', 'HARRIET', 'MUTESI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512315184, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1280, 7, 'IK1524', ' ', 'SEEMU', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0035', 0, '56000000.00', 100, '', 8, 1512315202, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1281, 7, 'IK1525', 'ELIDADI', 'KAPERE', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0043', 0, '56000000.00', 100, '', 8, 1512315229, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1282, 7, 'IK1526', 'SAM', 'GAMUTAMBULI', '(MAYOR)', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0081', 0, '56000000.00', 100, '', 8, 1512315279, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1283, 7, 'IK1527', 'HENRY', 'ZIKULABE', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0045', 0, '56000000.00', 100, '', 8, 1512315315, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1284, 7, 'IK1297', 'KITI', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0149', 0, '56000000.00', 100, '', 8, 1512315320, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1285, 7, 'IK1528', 'SAM', 'GAMUTAMBULI', '(MAYOR)', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0075', 0, '56000000.00', 100, '', 8, 1512315351, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1286, 7, 'IK1529', 'PETER', 'KYEDUNE', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0076', 0, '56000000.00', 100, '', 8, 1512315386, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1287, 7, 'IK1298', 'KEVIN', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0075', 0, '56000000.00', 100, '', 8, 1512315388, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1288, 7, 'IK1530', 'MOSES', 'MALINZI', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0079', 0, '56000000.00', 100, '', 8, 1512315423, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1289, 7, 'IK1531', ' ', 'KALIKWANI', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0074', 0, '56000000.00', 100, '', 8, 1512315456, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1290, 7, 'IK1299', 'MOSES', 'BADUBE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0033', 0, '56000000.00', 100, '', 8, 1512315465, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1291, 7, 'IK1300', 'KAWALA', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0044', 0, '56000000.00', 100, '', 8, 1512315542, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1294, 7, 'IK1301', 'ROBERT', 'WALASE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0072', 0, '56000000.00', 100, '', 8, 1512315647, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1295, 7, 'IK1532', ' ', 'SININI', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0073', 0, '56000000.00', 100, '', 8, 1512315677, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1296, 7, 'IK1533', ' ', 'KATO', '', '', 41, 0, 6, 20, 30, '1', '0.0000', '0.0000', '0.0064', 0, '56000000.00', 100, '', 8, 1512315729, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1297, 7, 'IK1302', 'DAVID', 'KOTE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512315732, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1298, 7, 'IK1303', 'BACHU', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0076', 0, '56000000.00', 100, '', 8, 1512315791, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1299, 7, 'IK1304', 'YOWERI', 'MUYOLA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0072', 0, '56000000.00', 100, '', 8, 1512315860, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1300, 7, 'IK0253', 'MATIYA', 'MUKOSE', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0049', 0, '20000000.00', 100, '', 0, 1512315888, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1301, 7, 'IK1305', 'GRACE', 'BALM', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0102', 0, '56000000.00', 100, '', 8, 1512315951, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1302, 7, 'IK0937', 'FRED ***', 'BABI', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0078', 0, '24000000.00', 100, '', 8, 1512316015, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1303, 7, 'IK1306', 'FRANCO', 'NABUGERE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0074', 0, '56000000.00', 100, '', 8, 1512316025, 1, '2017-12-15 09:56:45', 1, 'DISTRIBUTION LINE', 1),
(1304, 7, 'IK0254', 'JAMILA', ' ', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0028', 0, '20000000.00', 100, '', 8, 1512316047, 1, '2017-12-15 09:55:46', 1, 'Select comment ...', 1),
(1305, 7, 'IK1307', 'MATIA', 'TULIBATONO', '', '', 41, 0, 6, 7, 4, '1', '0.0000', '0.0000', '0.0082', 0, '56000000.00', 100, '', 8, 1512316108, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1306, 7, 'IK1308', 'NKOLA', 'SYLIVIA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0066', 0, '56000000.00', 100, '', 8, 1512316170, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1307, 7, 'IK1309', 'DAVID', 'TIBABITE', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0278', 0, '56000000.00', 100, '', 8, 1512316250, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1308, 7, 'IK1310', 'SAM', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0098', 0, '56000000.00', 100, '', 8, 1512316313, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1309, 7, 'IK1311', 'PETER', 'WAHAMPI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0174', 0, '56000000.00', 100, '', 8, 1512316393, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1310, 7, 'IK1312', 'RICHARD ', 'MUSISI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0062', 0, '56000000.00', 100, '', 8, 1512316453, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1311, 7, 'IK0932', 'FRED ', 'BABI', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0186', 0, '24000000.00', 100, '', 8, 1512316482, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1312, 7, 'IK1313', 'BASOGA', '', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0134', 0, '56000000.00', 100, '', 8, 1512316519, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1313, 7, 'IK1314', 'IVAN', 'LUBOGO', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0105', 0, '56000000.00', 100, '', 8, 1512316577, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1314, 7, 'IK0933', 'MARTIN', 'BALIGEYA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0803', 0, '24000000.00', 100, '', 8, 1512316653, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1);
INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, `chainage`, `tenure`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`, `active`) VALUES
(1315, 7, 'IK1315', 'KHADIDGA', 'AMULI', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0078', 0, '56000000.00', 100, '', 8, 1512316665, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1316, 7, 'IK1316', 'MONICA', '  ', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0070', 0, '56000000.00', 100, '', 8, 1512316722, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1317, 7, 'IK0934', 'GEORGE', 'WAGALUKA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0114', 0, '24000000.00', 100, '', 8, 1512316745, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1318, 7, 'IK1317', 'RUJA', 'BABU', 'SUMATI', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0074', 0, '56000000.00', 100, '', 8, 1512316796, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1319, 7, 'IK0935', 'WILSON', 'BAMWIBYE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0045', 0, '24000000.00', 100, '', 8, 1512316839, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1320, 7, 'IK1318', 'SALIM', 'BAMPALANA', '', '', 41, 0, 6, 7, 29, '1', '0.0000', '0.0000', '0.0227', 0, '56000000.00', 100, '', 8, 1512316888, 1, '2017-12-15 09:56:46', 1, 'DISTRIBUTION LINE', 1),
(1321, 7, 'IK0936', 'STEVEN', 'NDOWE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0113', 0, '24000000.00', 100, '', 8, 1512316932, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1322, 7, 'IK0938', 'PAUL ', 'KAYIGWA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0143', 0, '24000000.00', 100, '', 8, 1512317062, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1323, 7, 'IK0939', 'FRED', 'BABI', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0058', 0, '24000000.00', 100, '', 8, 1512317121, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1324, 7, 'IK0940', 'DANIEL ', 'KAYIGWA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0226', 0, '24000000.00', 100, '', 8, 1512317286, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1325, 7, 'IK0265', 'YASIN', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0077', 0, '20000000.00', 100, '', 8, 1512317339, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1326, 7, 'IK0941', 'RICHARD', 'MUZALE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0135', 0, '24000000.00', 100, '', 8, 1512317379, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1327, 7, 'IK0266', 'HUSSEIN', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0122', 0, '20000000.00', 100, '', 8, 1512317427, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1328, 7, 'IK1533-1', 'EDISA MUDUSU', 'MONICA MUDUSU', '& KAFUKO MUDUSU', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0170', 0, '56000000.00', 100, '', 8, 1512317438, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1329, 7, 'IK0255', 'MAWAZI', 'MAGUMBA', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0052', 0, '20000000.00', 100, '', 8, 1512317456, 1, '2017-12-15 09:55:47', 1, 'Select comment ...', 1),
(1330, 7, 'IK1534', 'CHRISTINE', 'NAMUWAYA', 'PANDE', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0243', 0, '56000000.00', 100, '', 8, 1512317469, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1331, 7, 'IK0942', 'ISAAC', 'WAYIBI', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0099', 0, '24000000.00', 100, '', 8, 1512317479, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1332, 7, 'IK1535', ' ', 'UNKNOWN', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0041', 0, '56000000.00', 100, '', 8, 1512317497, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1333, 7, 'IK0267', 'ABU', 'KULAYIRA', 'MUGABO', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0318', 0, '20000000.00', 100, '', 8, 1512317526, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1334, 7, 'IK0256', 'SIRAJE', 'KABALE', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0079', 0, '20000000.00', 100, '', 8, 1512317527, 1, '2017-12-15 09:55:47', 1, 'Select comment ...', 1),
(1335, 7, 'IK1536', ' ', 'MUSOBYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0021', 0, '56000000.00', 100, '', 8, 1512317530, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1336, 7, 'IK1537', ' ', 'MAGOOLA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0025', 0, '56000000.00', 100, '', 8, 1512317565, 1, '2017-12-15 09:56:59', 1, 'DISTRIBUTION LINE', 1),
(1337, 7, 'IK0943', 'NAIGAGA', '  ', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0097', 0, '24000000.00', 100, '', 8, 1512317581, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1338, 7, 'IK1538', 'JULIET', 'NAMUGAYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0015', 0, '56000000.00', 100, '', 8, 1512317593, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1339, 7, 'IK0268', 'MAFUMU', '  ', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0025', 0, '20000000.00', 100, '', 8, 1512317600, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(1340, 7, 'IK1539', ' ', 'SUUBI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0016', 0, '56000000.00', 100, '', 8, 1512317617, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1341, 7, 'IK1540', ' ', 'KALIKWANI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0029', 0, '56000000.00', 100, '', 8, 1512317649, 1, '2017-12-15 09:56:59', 1, 'Select comment ...', 1),
(1342, 7, 'IK1541', 'PROSSY', ' ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0032', 0, '56000000.00', 100, '', 8, 1512317687, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1343, 7, 'IK1542', 'RICHARD', 'KABEDA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0013', 0, '56000000.00', 100, '', 0, 1512317744, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1344, 7, 'IK0944', 'BOSCO', 'WANGOYE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0087', 0, '24000000.00', 100, '', 8, 1512317764, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1345, 7, 'IK1544', ' ', 'UNKNOWN', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 8, 1512317767, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1346, 7, 'IK0269', 'EDWARD', 'LUGOGOBYE', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0272', 0, '20000000.00', 100, '', 8, 1512317825, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(1347, 7, 'IK0945', 'MARTIN', 'BALIGEYA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0054', 0, '24000000.00', 100, '', 8, 1512317892, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1348, 7, 'IK1543', ' ', 'UNKNOWN', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0025', 0, '56000000.00', 100, '', 8, 1512317922, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1349, 7, 'IK1545', ' ', 'UNKNOWN', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0014', 0, '56000000.00', 100, '', 8, 1512317954, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1350, 7, 'IK1546', ' ', 'UNKNOWN', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0014', 0, '56000000.00', 100, '', 8, 1512317995, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1351, 7, 'IK0270', 'GANDI', 'ALICE', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0062', 0, '20000000.00', 100, '', 8, 1512317999, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(1352, 7, 'IK0946', 'JOSHUA', 'MUYIMA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0056', 0, '24000000.00', 100, '', 0, 1512318029, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1353, 7, 'IK1547', ' ', 'NYUNYU', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0015', 0, '56000000.00', 100, '', 8, 1512318039, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1354, 7, 'IK1548', 'MONICA', 'MAWA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0016', 0, '56000000.00', 100, '', 8, 1512318075, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1355, 7, 'IK1549', ' ', 'BAIDU', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0014', 0, '56000000.00', 100, '', 8, 1512318098, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1356, 7, 'IK0271', 'JUMA', 'WAISWA', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0044', 0, '20000000.00', 100, '', 8, 1512318107, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(1357, 7, 'IK0947', 'UNKNOWN', '  ', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0038', 0, '24000000.00', 100, '', 8, 1512318112, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1358, 7, 'IK1550', 'BESWERI', 'LUUKA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0030', 0, '56000000.00', 100, '', 8, 1512318130, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1359, 7, 'IK1551', ' ', 'UNKNOWN', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 0, 1512318154, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1360, 7, 'IK0948', 'MARTIN', 'BALIGEYA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0032', 0, '24000000.00', 100, '', 8, 1512318182, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1361, 7, 'IK1552', 'BATUKYAYE', 'NABIRYE', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0103', 0, '56000000.00', 100, '', 8, 1512318189, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1362, 7, 'IK1553', 'HARRIET', ' ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0023', 0, '56000000.00', 100, '', 8, 1512318212, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1363, 7, 'IK0272', 'MIRABU', 'NZIRANACHU', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0059', 0, '20000000.00', 100, '', 0, 1512318217, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(1366, 7, 'IK0949', 'MOSES', 'BARAZA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0116', 0, '24000000.00', 100, '', 8, 1512318244, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1367, 7, 'IK1554', 'WAISWA', 'BULOLO', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0031', 0, '56000000.00', 100, '', 8, 1512318245, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1368, 7, 'IK1555', 'FRED', 'MBALUMYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0032', 0, '56000000.00', 100, '', 8, 1512318283, 1, '2017-12-15 09:57:00', 1, 'Select comment ...', 1),
(1369, 7, 'IK0950', 'JOY', 'NAKABENGWA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0061', 0, '24000000.00', 100, '', 8, 1512318314, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1370, 7, 'IK0257', 'FRED', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0102', 0, '20000000.00', 100, '', 8, 1512318334, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1371, 7, 'IK0273', 'BUNYIIRO CHURCH OF UGANDA', '', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.1553', 0, '20000000.00', 100, '', 8, 1512318367, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(1372, 7, 'IK0951-1', 'BOSCO', 'NGOYE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0040', 0, '24000000.00', 100, '', 8, 1512318426, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1373, 7, 'IK1556', 'KALIRO T/C', ' ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0071', 0, '56000000.00', 100, '', 8, 1512318429, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1374, 7, 'IK0258', 'ELIZABETH', 'BAWAYE', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0100', 0, '20000000.00', 100, '', 0, 1512318439, 1, '2017-12-15 09:55:47', 1, 'Select comment ...', 1),
(1375, 7, 'IK1557', 'FRED', 'MBALUMYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0023', 0, '56000000.00', 100, '', 8, 1512318454, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1376, 7, 'IK1558', 'BEN', 'KIYEMBA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 8, 1512318485, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1377, 7, 'IK1559', ' ', 'NYUNYU', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0015', 0, '56000000.00', 100, '', 8, 1512318518, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1378, 7, 'IK1560', ' ', 'UNKNOWN', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0014', 0, '56000000.00', 100, '', 8, 1512318543, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1379, 7, 'IK1561', ' ', 'LUKA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0018', 0, '56000000.00', 100, '', 0, 1512318566, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1380, 7, 'IK0951', 'PAUL ', 'NGOYE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0068', 0, '24000000.00', 100, '', 8, 1512318576, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1381, 7, 'IK1562', 'JOHN', 'BAVEKUNO', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0016', 0, '56000000.00', 100, '', 8, 1512318612, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1382, 7, 'IK0274', 'WAKINANKI', 'ABUBAKARI', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0417', 0, '20000000.00', 100, '', 8, 1512318629, 1, '2017-12-15 09:55:48', 1, 'PUBLIC TOILET SITE', 1),
(1383, 7, 'IK0952', 'ZAKALIA ', 'KAFUKO', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0046', 0, '24000000.00', 100, '', 8, 1512318660, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1384, 7, 'IK0259', 'BADRU', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0139', 0, '20000000.00', 100, '', 8, 1512318697, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1385, 7, 'IK0260', 'SULAI', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0036', 0, '20000000.00', 100, '', 8, 1512318771, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1386, 7, 'IK0953', 'BETEWO', 'NAMAGANDA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0022', 0, '24000000.00', 100, '', 8, 1512318775, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1387, 7, 'IK0261', 'YAHAYA', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0088', 0, '20000000.00', 100, '', 8, 1512318854, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1388, 7, 'IK0954', 'PAUL', 'NGOYE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0064', 0, '24000000.00', 100, '', 8, 1512318913, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1389, 7, 'IK0262', 'AWALI', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0132', 0, '20000000.00', 100, '', 8, 1512318943, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1390, 7, 'IK1563', 'GODFREY', 'MUBEEZI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0018', 0, '56000000.00', 100, '', 8, 1512318984, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1391, 7, 'IK0263', 'MUZAMIRU', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0074', 0, '20000000.00', 100, '', 8, 1512319027, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1392, 7, 'IK0955', 'RONALD ', 'KASADHA', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0060', 0, '24000000.00', 100, '', 8, 1512319033, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1393, 7, 'IK1564', 'PETER', 'WAIHE', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0018', 0, '56000000.00', 100, '', 8, 1512319049, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1394, 7, 'IK1565', 'EPHRAIM', 'KUNYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0022', 0, '56000000.00', 100, '', 8, 1512319090, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1395, 7, 'IK0264', 'ARDHI', 'MUGABO', '', '', 33, 0, 9, 19, 27, '1', '0.0000', '0.0000', '0.0074', 0, '20000000.00', 100, '', 8, 1512319127, 1, '2017-12-15 09:55:47', 1, 'DISTRIBUTION LINE', 1),
(1396, 7, 'IK1566', ' ', 'MUGOLO', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0045', 0, '56000000.00', 100, '', 8, 1512319129, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1397, 7, 'IK0956', 'AWALI', 'AWUYE', '', '', 33, 0, 2, 23, 37, '1', '0.0000', '0.0000', '0.0041', 0, '24000000.00', 100, '', 8, 1512319159, 1, '2017-12-15 09:56:26', 1, 'DISTRIBUTION LINE', 1),
(1398, 7, 'IK1567', 'ALICE', '', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0012', 0, '56000000.00', 100, '', 8, 1512319377, 1, '2017-12-15 09:57:01', 1, 'DISTRIBUTION LINE', 1),
(1399, 7, 'IK1569', ' ', 'KALIKWANI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0028', 0, '56000000.00', 100, '', 8, 1512319438, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1400, 7, 'IK1570', 'FRED', 'MBALUMYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0027', 0, '56000000.00', 100, '', 8, 1512319481, 1, '2017-12-15 09:57:01', 1, 'Select comment ...', 1),
(1401, 7, 'IK1571', 'MOSES ', 'ISABIRYE', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0027', 0, '56000000.00', 100, '', 8, 1512319527, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1402, 7, 'IK1572', 'HANNINGTON', 'DAMBA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 8, 1512319599, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1403, 7, 'IK1573', '  ', 'MUTABAAZI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 8, 1512319629, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1404, 7, 'IK1574', 'FRED', 'MBALUMYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0102', 0, '56000000.00', 100, '', 8, 1512319660, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1405, 7, 'IK1575', ' ', 'LUKA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0033', 0, '56000000.00', 100, '', 8, 1512319680, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1406, 7, 'IK1576', ' ', 'NYUNYU', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0030', 0, '56000000.00', 100, '', 8, 1512319708, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1407, 7, 'IK1577', 'FRED', 'LUMI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0046', 0, '56000000.00', 100, '', 8, 1512319738, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1408, 7, 'IK1578', ' ', 'EREMEYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0056', 0, '56000000.00', 100, '', 8, 1512319794, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1409, 7, 'IK1579', 'RUTH', 'KISIRA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0029', 0, '56000000.00', 100, '', 8, 1512320050, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1410, 7, 'IK1580', 'PAUL', 'NABONGO', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0018', 0, '56000000.00', 100, '', 8, 1512320102, 1, '2017-12-15 09:57:02', 1, 'DISTRIBUTION LINE', 1),
(1411, 7, 'IK1581', ' ', 'KAAWA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0016', 0, '56000000.00', 100, '', 8, 1512320126, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1412, 7, 'IK1582', ' ', 'NYUNYU', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0066', 0, '56000000.00', 100, '', 8, 1512320152, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1413, 7, 'IK1583', 'NGOBI', 'NAPERA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 8, 1512320186, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1414, 7, 'IK1584', 'SAM', ' ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0015', 0, '56000000.00', 100, '', 8, 1512320216, 1, '2017-12-15 09:57:02', 1, 'Select comment ...', 1),
(1415, 7, 'IK1585', 'KALIRO TOWN COUNCIL', 'TOILETS', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0112', 0, '56000000.00', 100, '', 8, 1512320373, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1416, 7, 'IK1595', 'ALFRED', 'NABANGI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0011', 0, '56000000.00', 100, '', 8, 1512320417, 1, '2017-12-15 09:57:03', 1, 'DISTRIBUTION LINE', 1),
(1417, 7, 'IK1596', 'SAMSOM', '  ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0016', 0, '56000000.00', 100, '', 8, 1512320525, 1, '2017-12-15 09:57:03', 1, 'DISTRIBUTION LINE', 1),
(1418, 7, 'IK1597', 'FRED', 'MUBEZI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 8, 1512320585, 1, '2017-12-15 09:57:03', 1, 'DISTRIBUTION LINE', 1),
(1419, 7, 'IK1586', 'MOSES', ' ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0020', 0, '56000000.00', 100, '', 8, 1512320589, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1420, 7, 'IK1587', 'MOSES', ' ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0015', 0, '56000000.00', 100, '', 8, 1512320615, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1421, 7, 'IK1598', 'ZAALE', '  ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0016', 0, '56000000.00', 100, '', 8, 1512320639, 1, '2017-12-15 09:57:03', 1, 'DISTRIBUTION LINE', 1),
(1422, 7, 'IK1588', ' ', 'WAAYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0032', 0, '56000000.00', 100, '', 8, 1512320640, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1423, 7, 'IK1599', 'SAMSON', 'SANDE', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0034', 0, '56000000.00', 100, '', 8, 1512320699, 1, '2017-12-15 09:57:03', 1, 'DISTRIBUTION LINE', 1),
(1424, 7, 'IK1590', ' ', 'MUTASA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0012', 0, '56000000.00', 100, '', 0, 1512320710, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1425, 7, 'IK1600', 'SUSAN', 'KAPERE', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0015', 0, '56000000.00', 100, '', 8, 1512320763, 1, '2017-12-15 09:57:03', 1, 'DISTRIBUTION LINE', 1),
(1426, 7, 'IK1601', 'FRED', 'MUBEZI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0040', 0, '56000000.00', 100, '', 8, 1512320829, 1, '2017-12-15 09:57:03', 1, 'DISTRIBUTION LINE', 1),
(1427, 7, 'IK1589', 'SYLVIA', ' ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0014', 0, '56000000.00', 100, '', 8, 1512320837, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1428, 7, 'IK1591', 'SAM', ' ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0017', 0, '56000000.00', 100, '', 8, 1512320872, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1429, 7, 'IK1602', 'OKELLO', '  ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0285', 0, '56000000.00', 100, '', 8, 1512320893, 1, '2017-12-15 09:57:03', 1, 'DISTRIBUTION LINE', 1),
(1430, 7, 'IK1606', 'PATRICK', 'MUKUNYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0083', 0, '56000000.00', 100, '', 8, 1512320936, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1431, 7, 'IK1603', 'MWEMEKE', '  ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0169', 0, '56000000.00', 100, '', 8, 1512320958, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1432, 7, 'IK1592', 'FRED', 'MBALUMYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0015', 0, '56000000.00', 100, '', 8, 1512320963, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1433, 7, 'IK1593', 'FRED', 'MBALUMYA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0014', 0, '56000000.00', 100, '', 8, 1512321008, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1434, 7, 'IK1607', 'MUHAMED', 'OSMAN', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0091', 0, '56000000.00', 100, '', 8, 1512321015, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1435, 7, 'IK1594', 'KHALID', 'WASUKIRA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0015', 0, '56000000.00', 100, '', 8, 1512321044, 1, '2017-12-15 09:57:03', 1, 'Select comment ...', 1),
(1436, 7, 'IK1604', 'OKELLO', '   ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0000', 0, '56000000.00', 100, '', 8, 1512321046, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1437, 7, 'IK1608', 'SYLVIA', 'NAKANJA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0093', 0, '56000000.00', 100, '', 8, 1512321089, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1438, 7, 'IK1605', 'ANTHONY', 'NDIFUNA', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0054', 0, '56000000.00', 100, '', 8, 1512321112, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1439, 7, 'IK1609', 'BABU', 'MUTONI', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0090', 0, '56000000.00', 100, '', 8, 1512321174, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1440, 7, 'IK1610', 'WAMULE', 'KAYITILE', 'EFULANSI', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0042', 0, '56000000.00', 100, '', 8, 1512321476, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1441, 7, 'IK1611', 'KAWUTA', '  ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0038', 0, '56000000.00', 100, '', 8, 1512321552, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1442, 7, 'IK1612', 'WAAYA', '  ', '', '', 41, 0, 6, 24, 38, '1', '0.0000', '0.0000', '0.0057', 0, '56000000.00', 100, '', 8, 1512321604, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1443, 7, 'IK1622', 'KALIRO FOREST RESERVE', '  ', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0688', 0, '48000000.00', 100, '', 8, 1512463748, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1444, 7, 'IK1623', 'BOGERE', '  ', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0669', 0, '48000000.00', 100, '', 8, 1512463819, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1445, 7, 'IK1638', 'MULESA', '  ', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0636', 0, '48000000.00', 100, '', 8, 1512463946, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1446, 7, 'IK1625', 'JANE', 'PANDE', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0137', 0, '48000000.00', 100, '', 8, 1512464033, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1447, 7, 'IK1626', 'GRACE', 'PANDE', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0094', 0, '48000000.00', 100, '', 8, 1512464288, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1448, 7, 'IK1627', 'MULESA', '  ', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0131', 0, '48000000.00', 100, '', 8, 1512464455, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1449, 7, 'IK1628', 'LUKABWE', 'KAGGWA', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0121', 0, '48000000.00', 100, '', 8, 1512464621, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1450, 7, 'IK1629', 'ALICE', 'PANDE', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0055', 0, '48000000.00', 100, '', 8, 1512464714, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1451, 7, 'IK1630', 'TOM', 'KEEYA', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0133', 0, '48000000.00', 100, '', 8, 1512464959, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1452, 7, 'IK1631', 'MOSES', 'KEEYA', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0141', 0, '48000000.00', 100, '', 8, 1512465058, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1453, 7, 'IK1632', 'CONSTANT', 'MUSOBYA', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0036', 0, '48000000.00', 100, '', 8, 1512465139, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1454, 7, 'IK1633', 'KALIKWANI', '', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0120', 0, '48000000.00', 100, '', 8, 1512465219, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1455, 7, 'IK1634', 'PATRICK', 'PANDE', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0220', 0, '48000000.00', 100, '', 8, 1512465295, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1456, 7, 'IK1635', 'SANDE', 'MUSALWA', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0529', 0, '48000000.00', 100, '', 8, 1512465397, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1457, 7, 'IK1639', 'KADOKERA', '  ', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0155', 0, '48000000.00', 100, '', 8, 1512465785, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1458, 7, 'IK1640', 'AIDAH', 'TABAZI', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0072', 0, '48000000.00', 100, '', 8, 1512465874, 1, '2017-12-15 09:57:06', 1, 'DISTRIBUTION LINE', 1),
(1459, 7, 'IK1640-1', 'DAVID', 'BUNYI', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0050', 0, '48000000.00', 100, '', 8, 1512466109, 1, '2017-12-15 09:57:06', 1, 'DISTRIBUTION LINE', 1),
(1460, 7, 'IK1642', 'GODFREY', 'KALYA', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0179', 0, '48000000.00', 100, '', 8, 1512466595, 1, '2017-12-15 09:57:06', 1, 'DISTRIBUTION LINE', 1),
(1461, 7, 'IK1643', 'KALIRO NTC', '', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.1140', 0, '48000000.00', 100, '', 8, 1512466838, 1, '2017-12-15 09:57:06', 1, 'DISTRIBUTION LINE', 1),
(1462, 7, 'IK1641', 'HENRY', 'MULOKI', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0080', 0, '48000000.00', 100, '', 8, 1512466909, 1, '2017-12-15 09:57:06', 1, 'DISTRIBUTION LINE', 1),
(1463, 7, 'IK0762', 'SAFINA', 'NAMUKOSE', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0037', 0, '40000000.00', 100, '', 8, 1512470380, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1466, 7, 'IK0762', 'SAFINA', 'NAMUKOSE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0037', 0, '40000000.00', 100, '', 8, 1512470648, 1, '2017-12-15 09:56:15', 1, 'Select comment ...', 1),
(1467, 7, 'IK0767', 'KAWA', '', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0028', 0, '40000000.00', 100, '', 8, 1512470752, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1468, 7, 'IK0771', 'HAKIM', 'WAISWA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0047', 0, '40000000.00', 100, '', 8, 1512470856, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1469, 7, 'IK0772', 'BARAKA', '', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0059', 0, '40000000.00', 100, '', 8, 1512471158, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1470, 7, 'IK0773', 'SAUBA', 'NABIRYE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0245', 0, '40000000.00', 100, '', 8, 1512471279, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1471, 7, 'IK0774', 'MUHAMMAD', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0058', 0, '40000000.00', 100, '', 8, 1512471386, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1472, 7, 'IK0776', 'JOSEPH', 'WAISWA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0038', 0, '40000000.00', 100, '', 8, 1512471682, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1473, 7, 'IK0777', 'FAROUK', 'KASOZI', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0080', 0, '40000000.00', 100, '', 8, 1512471753, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1474, 7, 'IK0777-1', 'JUSTINE', 'NANGOBI', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0040', 0, '40000000.00', 100, '', 8, 1512471920, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1475, 7, 'IK0779', 'ZAINA', '  BABIRYE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0050', 0, '40000000.00', 100, '', 8, 1512472052, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1476, 7, 'IK0780', 'SIRAJ', 'BASORWE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0050', 0, '40000000.00', 100, '', 8, 1512472128, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1477, 7, 'IK0782', 'PATRICK', 'LUGOGOBE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0054', 0, '40000000.00', 100, '', 8, 1512472263, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1478, 7, 'IK0783', 'HELEN', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0027', 0, '40000000.00', 100, '', 8, 1512472358, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1479, 7, 'IK0787', 'GODFREY', 'TAYIRE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0068', 0, '40000000.00', 100, '', 8, 1512472562, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1480, 7, 'IK0789', 'NATHAN', 'KADHUBA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0098', 0, '40000000.00', 100, '', 8, 1512472661, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1481, 7, 'IK0790', 'MUGABI', '    ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0067', 0, '40000000.00', 100, '', 8, 1512472730, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1482, 7, 'IK0792', 'YOFISA', 'KALELE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0041', 0, '40000000.00', 100, '', 8, 1512472810, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1483, 7, 'IK0793', 'HAMIS', 'KIMBUGWE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0202', 0, '40000000.00', 100, '', 8, 1512472937, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1484, 7, 'IK0795', 'NGOBI', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0071', 0, '40000000.00', 100, '', 8, 1512473038, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1485, 7, 'IK0796', 'HAMUZA', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0041', 0, '40000000.00', 100, '', 8, 1512473135, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1486, 7, 'IK0797', 'FATUMA', 'MUTESI', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0098', 0, '40000000.00', 100, '', 8, 1512473230, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1487, 7, 'IK0798', 'FRANCIS', 'KYABWE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0081', 0, '40000000.00', 100, '', 8, 1512473334, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1488, 7, 'IK0799', 'GENGA', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0114', 0, '40000000.00', 100, '', 8, 1512473418, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1489, 7, 'IK0800', 'LOZIO', 'SOOKA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0172', 0, '40000000.00', 100, '', 8, 1512473513, 1, '2017-12-15 09:56:17', 1, 'Select comment ...', 1),
(1490, 7, 'IK0801', 'GRACE', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0049', 0, '40000000.00', 100, '', 8, 1512473588, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1491, 7, 'IK0802', 'JOWALI', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0084', 0, '40000000.00', 100, '', 8, 1512473705, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1492, 7, 'IK0803', 'YOFISA', 'KALULE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0149', 0, '40000000.00', 100, '', 8, 1512473784, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1493, 7, 'IK0804', 'NALWOGA', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0084', 0, '40000000.00', 100, '', 8, 1512473921, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1494, 7, 'IK0806', 'DAVID', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0030', 0, '40000000.00', 100, '', 8, 1512474018, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1495, 7, 'IK0807', 'UMAR', 'NANUMBA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0056', 0, '40000000.00', 100, '', 8, 1512474098, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1496, 7, 'IK0808', 'CHARLSE', 'MULUWUKA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0057', 0, '40000000.00', 100, '', 8, 1512474191, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1497, 7, 'IK0810', 'HAMIS', 'ISABIRYE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0135', 0, '40000000.00', 100, '', 8, 1512474282, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1498, 7, 'IK0811', 'ADAM', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0027', 0, '40000000.00', 100, '', 8, 1512474381, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1499, 7, 'IK0812', 'MWENDI', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0045', 0, '40000000.00', 100, '', 8, 1512474466, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1500, 7, 'IK0813', 'MULANI', 'BAGULAINE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0118', 0, '40000000.00', 100, '', 8, 1512474618, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1501, 7, 'IK0708', 'KOWA', 'MAYEMBE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0021', 0, '40000000.00', 100, '', 8, 1512474801, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1502, 7, 'IK0709', 'PETER', 'ZEMA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0031', 0, '40000000.00', 100, '', 8, 1512474892, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1503, 7, 'IK0710', 'MIRIMU', 'WAYIBI', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0038', 0, '40000000.00', 100, '', 8, 1512474964, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1504, 7, 'IK0711', 'UNKNOWN', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0039', 0, '40000000.00', 100, '', 8, 1512475020, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1505, 7, 'IK0712', 'JOSHUA', 'MUGANDA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0092', 0, '40000000.00', 100, '', 8, 1512475133, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1506, 7, 'IK0713', 'ANTHONY', 'KISIWA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0068', 0, '40000000.00', 100, '', 8, 1512475219, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1507, 7, 'IK0815', 'JACKSON', 'WAISWA', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0654', 0, '40000000.00', 100, '', 8, 1512475449, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1508, 7, 'IK0816', 'MATIA', 'NDABIRE', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0511', 0, '40000000.00', 100, '', 8, 1512475527, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1509, 7, 'IK0817', 'HUDSON', 'TENYWA', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0487', 0, '40000000.00', 100, '', 8, 1512475626, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1510, 7, 'IK0820', 'DENIS', 'BAMUTAZE', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0047', 0, '40000000.00', 100, '', 8, 1512475724, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1511, 7, 'IK0821', 'JAMES', 'LUBAMBO', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0078', 0, '40000000.00', 100, '', 8, 1512475870, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1512, 7, 'IK0834', 'MOSES', 'MAWUTA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0019', 0, '40000000.00', 100, '', 8, 1512476978, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1513, 7, 'IK0835', 'ZAYIDI', 'TENYWA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0019', 0, '40000000.00', 100, '', 8, 1512477118, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1514, 7, 'IK0836', 'SIRAJE', 'KILALE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0014', 0, '40000000.00', 100, '', 8, 1512477225, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1515, 7, 'IK0837', 'ABU', 'MWAWULA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0024', 0, '40000000.00', 100, '', 8, 1512477330, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1516, 7, 'IK0838', 'MUZAIFA', 'OBBO', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0033', 0, '40000000.00', 100, '', 8, 1512477399, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1518, 7, 'IK0839', 'HAKIM', 'BATWALA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0025', 0, '40000000.00', 100, '', 8, 1512477622, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1519, 7, 'IK0840', 'UMAR', 'BATULI', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0015', 0, '40000000.00', 100, '', 8, 1512477694, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1520, 7, 'IK0841', 'RICHARD', 'ISABIRYE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0041', 0, '40000000.00', 100, '', 8, 1512477825, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1521, 7, 'IK0842', 'NYOLA', '  ', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0413', 0, '40000000.00', 100, '', 8, 1512477884, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1522, 7, 'IK0843', 'TEKIBA', '  ', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0101', 0, '40000000.00', 100, '', 8, 1512477977, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1523, 7, 'IK0876', 'ST.PAUL C.O.U CHURCH NASUTI ', '  ', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.3446', 0, '40000000.00', 100, '', 8, 1512478121, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1524, 7, 'IK0844', 'MUSA', 'GALUBALE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0074', 0, '40000000.00', 100, '', 8, 1512478258, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1525, 7, 'IK0845', 'NAKWAGALA', '  ', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0083', 0, '40000000.00', 100, '', 8, 1512478349, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1526, 7, 'IK0846', 'SAMUEL ', 'ISABIRYE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0128', 0, '40000000.00', 100, '', 8, 1512478427, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1527, 7, 'IK0847', 'FRED', 'NAKWAGALA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0112', 0, '40000000.00', 100, '', 8, 1512478509, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1528, 7, 'IK0848', 'SAMUEL ', 'NAKWAGALA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0103', 0, '40000000.00', 100, '', 8, 1512478607, 1, '2017-12-15 09:56:20', 1, 'DISTRIBUTION LINE', 1),
(1529, 7, 'IK0849', 'RICHARD ', 'NSADHA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0101', 0, '40000000.00', 100, '', 8, 1512478682, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1530, 7, 'IK0850', 'DAVID', 'KULAGA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0072', 0, '40000000.00', 100, '', 8, 1512479336, 1, '2017-12-15 09:56:21', 1, 'Select comment ...', 1),
(1531, 7, 'IK0851', 'MOSES', 'WAKISO', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0065', 0, '40000000.00', 100, '', 8, 1512479405, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1532, 7, 'IK0852', 'PATRICK ', 'TIBENKANA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0051', 0, '40000000.00', 100, '', 8, 1512479478, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1533, 7, 'IK0853', 'BEATRICE', 'MASOMELE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0100', 0, '40000000.00', 100, '', 8, 1512479546, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1534, 7, 'IK0854', 'CHARLES', 'MUTALE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0039', 0, '40000000.00', 100, '', 8, 1512479601, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1535, 7, 'IK0855', 'MABONE', '    ', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0035', 0, '40000000.00', 100, '', 8, 1512479709, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1536, 7, 'IK0856', 'JOHN ', 'LULETERO', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0240', 0, '40000000.00', 100, '', 8, 1512479777, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1537, 7, 'IK0857', 'STANELY ', 'NYOLA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0408', 0, '40000000.00', 100, '', 8, 1512479869, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1539, 7, 'IK0858', 'KASSIM', 'WAISWA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0077', 0, '40000000.00', 100, '', 8, 1512480014, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1540, 7, 'IK0859', 'HASSAN', 'SOMAYILI', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0100', 0, '40000000.00', 100, '', 8, 1512480079, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1542, 7, 'IK0860', 'LAUBEN ', 'WANSALE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0105', 0, '40000000.00', 100, '', 8, 1512480331, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1543, 7, 'IK0861', 'FAROUK', 'ISABIRYE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0072', 0, '40000000.00', 100, '', 8, 1512480420, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1544, 7, 'IK0862', 'KASSIM', 'WAISWA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0173', 0, '40000000.00', 100, '', 8, 1512480596, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1546, 7, 'IK0863', 'SIRAJE', 'KILALE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0028', 0, '40000000.00', 100, '', 8, 1512480752, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1547, 7, 'IK0864', 'SOWEDI', 'NYONYINTONO', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0020', 0, '40000000.00', 100, '', 8, 1512480845, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1548, 7, 'IK0865', 'GODFREY', 'TUBANONE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0093', 0, '40000000.00', 100, '', 8, 1512480911, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1549, 7, 'IK0866', 'MUZAIFA', 'OBBO', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0042', 0, '40000000.00', 100, '', 8, 1512481011, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1550, 7, 'IK0867', 'YONAH', 'KADUNGANYA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0015', 0, '40000000.00', 100, '', 8, 1512481098, 1, '2017-12-15 09:56:21', 1, 'DISTRIBUTION LINE', 1),
(1559, 7, 'IK0877', 'WAIDA', 'BAZIRA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0099', 0, '40000000.00', 100, '', 8, 1512481892, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1560, 7, 'IK0878', 'SAMUEL ', 'ISABIRYE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0100', 0, '40000000.00', 100, '', 8, 1512481998, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1561, 7, 'IK0879', 'MUHAMMAD', 'MUSENZE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0160', 0, '40000000.00', 100, '', 8, 1512482120, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1562, 7, 'IK0880', 'LUBOGOYI', '  ', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0500', 0, '40000000.00', 100, '', 8, 1512482232, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1563, 7, 'IK0881', 'NYIRO', '  ', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0846', 0, '40000000.00', 100, '', 8, 1512482306, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1564, 7, 'IK0882', 'UMAR', 'BATULI', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0227', 0, '40000000.00', 100, '', 8, 1512482574, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1566, 7, 'IK0883', 'SIMON', 'BAWAYE', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0178', 0, '40000000.00', 100, '', 8, 1512482998, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1567, 7, 'IK0884', 'MUBARAKA', 'KIREGEYA', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0329', 0, '12000000.00', 100, '', 8, 1512483155, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1568, 7, 'IK0885', 'SALIM ', 'GWAYIDI', '', '', 33, NULL, 2, 16, 14, '1', NULL, NULL, '0.0062', 0, '12000000.00', 100, '', 8, 1512483251, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1569, 7, 'IK0886', 'MUSENERO', 'NTALO', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0248', 0, '12000000.00', 100, '', 8, 1512483526, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1570, 7, 'IK0887', 'EZRA', 'GABULA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0055', 0, '12000000.00', 100, '', 8, 1512483608, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1571, 7, 'IK0888', 'FREDRICK', 'MUGOYA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0041', 0, '12000000.00', 100, '', 8, 1512483686, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1572, 7, 'IK0889', 'GABRIEL', 'ODOI', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0050', 0, '12000000.00', 100, '', 8, 1512483769, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1573, 7, 'IK0890', 'PAUL', 'KAMBUZI', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0113', 0, '12000000.00', 100, '', 8, 1512483857, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1574, 7, 'IK0891', 'MADIBA', 'MINISULI', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0172', 0, '12000000.00', 100, '', 8, 1512483952, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1576, 7, 'IK0892', 'UNKNOWN', '', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0073', 0, '12000000.00', 100, '', 8, 1512484078, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1577, 7, 'IK0893', 'FIDA', 'MUTESI', 'WANSA', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0183', 0, '12000000.00', 100, '', 8, 1512484159, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1578, 7, 'IK0894', 'MALINZI', 'MUSOMO', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0124', 0, '12000000.00', 100, '', 8, 1512484237, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1579, 7, 'IK0895', 'JANE ', 'BAYITANUNGA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0106', 0, '12000000.00', 100, '', 8, 1512484318, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1580, 7, 'IK0896', 'FESTO', 'NGOBI', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0038', 0, '12000000.00', 100, '', 8, 1512484410, 1, '2017-12-15 09:56:22', 1, 'DISTRIBUTION LINE', 1),
(1581, 7, 'IK0897', 'FREDRICK', 'KASUDHA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0061', 0, '12000000.00', 100, '', 8, 1512484504, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1582, 7, 'IK0898', 'CHRISTOPHER', 'BATESA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0195', 0, '12000000.00', 100, '', 8, 1512484607, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1583, 7, 'IK0899', 'EUNICE', 'ABASA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0041', 0, '12000000.00', 100, '', 8, 1512484678, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1584, 7, 'IK0900', 'JOHN', 'KIWO', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0036', 0, '12000000.00', 100, '', 8, 1512484762, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1585, 7, 'IK0901', 'FATINA ', 'KAWALA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0444', 0, '12000000.00', 100, '', 8, 1512484905, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1586, 7, 'IK0902', 'EDISA', 'BABIRYE', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0374', 0, '12000000.00', 100, '', 8, 1512484993, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1587, 7, 'IK0903', 'MADIBA', 'BINASALE', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0083', 0, '12000000.00', 100, '', 8, 1512485093, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1588, 7, 'IK0904', 'MWAIDUMA ', 'MUTESI', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0243', 0, '12000000.00', 100, '', 8, 1512485222, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1589, 7, 'IK0905', 'SARAH ', 'NAMULONDO', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0214', 0, '12000000.00', 100, '', 8, 1512485313, 1, '2017-12-15 09:56:23', 1, 'DISTRIBUTION LINE', 1),
(1590, 7, 'IK0906', 'MARGARET ', 'AZEDI', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0427', 0, '12000000.00', 100, '', 8, 1512485405, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1);
INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, `chainage`, `tenure`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`, `active`) VALUES
(1591, 7, 'IK0907', 'LUKIYA ', 'NAMUKOSE', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0396', 0, '12000000.00', 100, '', 8, 1512485505, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1592, 7, 'IK0908', 'ISSA ', 'MAGUMBA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0083', 0, '12000000.00', 100, '', 8, 1512485654, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1594, 7, 'IK0910', 'HADIJAH', 'TILIKOMA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0220', 0, '12000000.00', 100, '', 8, 1512485883, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1595, 7, 'IK0911', 'HASSAN ', 'WAISWA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0419', 0, '12000000.00', 100, '', 8, 1512485987, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1597, 7, 'IK0913', 'AHMED ', 'BACHU', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0181', 0, '12000000.00', 100, '', 8, 1512486179, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1598, 7, 'IK0914', 'ISMA ', 'ZILIGWADI', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0116', 0, '12000000.00', 100, '', 8, 1512486261, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1599, 7, 'IK0915', 'WAKABI ', '  ', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0082', 0, '12000000.00', 100, '', 8, 1512486369, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1600, 7, 'IK0916', 'MOSES ', 'BAMULESEWO', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0139', 0, '12000000.00', 100, '', 8, 1512486742, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1601, 7, 'IK0917', 'JANE ', 'BAKULIMYA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0041', 0, '12000000.00', 100, '', 8, 1512486857, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1602, 7, 'IK0918', 'MADHIBA', 'MUTWALIBU', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0068', 0, '12000000.00', 100, '', 8, 1512486973, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1603, 7, 'IK0919', 'FAROUK ', 'NKOYIDO', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0062', 0, '12000000.00', 100, '', 8, 1512487121, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1606, 7, 'IK0970', 'EUNICE', 'BAKAKI', '', '', 33, NULL, 2, 23, 37, '1', NULL, NULL, '0.0133', 0, '24000000.00', 100, '', 8, 1512566861, 1, '2017-12-15 09:56:27', 1, 'DISTRIBUTION LINE', 1),
(1607, 7, 'IK0912', 'WILSON ', 'SANDE', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0140', 0, '12000000.00', 100, '', 8, 1512567013, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1610, 7, 'IK0920', 'COSMAS', '', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0056', NULL, '12000000.00', 100, '', 8, 1512629849, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1611, 7, 'IK0922', 'TABITHA', '', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0093', NULL, '12000000.00', 100, '', 8, 1512629948, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1612, 7, 'IK0923', 'JOSEPH', 'BALIGEYA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0177', NULL, '12000000.00', 100, '', 8, 1512630105, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1613, 7, 'IK0921', 'BEN', 'KIGO', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0077', NULL, '12000000.00', 100, '', 8, 1512635283, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1614, 7, 'IK0924', 'MOSES', 'KIGO', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0137', NULL, '12000000.00', 100, '', 8, 1512635721, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1615, 7, 'IK0925', 'MUZAMIRU', 'YOLYA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0171', NULL, '12000000.00', 100, '', 8, 1512636711, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1617, 7, 'IK0926', 'AMINA', 'NANKOMA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0053', NULL, '12000000.00', 100, '', 8, 1512637314, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1618, 7, 'IK0927', 'NAMBALE SUB COUNTY', '  ', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.1170', NULL, '12000000.00', 100, '', 8, 1512637544, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1619, 7, 'IK0928', 'ABEL', 'BANEKA', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0082', NULL, '12000000.00', 100, '', 8, 1512637804, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1620, 7, 'IK0929', 'BENARD', 'NABUTUNDU', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0635', NULL, '12000000.00', 100, '', 8, 1512638131, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1621, 7, 'IK0930', 'NAMBALE SDA CHURCH', '', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0337', NULL, '24000000.00', 100, '', 8, 1512638942, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1622, 7, 'IK0931', 'ST.JOHN`S CHURCH BUNONI', '  ', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.1122', NULL, '24000000.00', 100, '', 8, 1512639488, 1, '2017-12-15 09:56:25', 1, 'DISTRIBUTION LINE', 1),
(1624, 7, 'IK0971', 'UGANDA MARTYRS PRI.SCH. NABITOVU', '', '', '', 33, NULL, 2, 23, 37, '1', NULL, NULL, '0.0414', NULL, '24000000.00', 100, '', 8, 1512641066, 1, '2017-12-15 09:56:27', 1, 'DISTRIBUTION LINE', 1),
(1625, 7, 'IK0023', 'FATHALI', 'KAYERA', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0069', NULL, '40000000.00', 100, '', 8, 1513073632, 1, '2017-12-15 09:55:34', 1, 'DISTRIBUTION LINE', 1),
(1626, 7, 'IK0085', 'MRS.MAGUMBA', '  ', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0094', NULL, '40000000.00', 100, '', 8, 1513074102, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(1627, 7, 'IK0087', 'RICHARD', 'BAGALANA', 'KINTU', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0058', NULL, '40000000.00', 100, '', 8, 1513074280, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(1628, 7, 'IK0095', 'HAMIDU', 'BIDUSU', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0103', NULL, '40000000.00', 100, '', 8, 1513074557, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(1629, 7, 'IK0099', 'DAN', 'BWAKYA', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0063', NULL, '40000000.00', 100, '', 8, 1513074680, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(1630, 7, 'IK0100', 'ASHRAF', 'BWAKYA', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0051', NULL, '40000000.00', 100, '', 8, 1513074943, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(1631, 7, 'IK0101', 'JOSHUA', 'BWAKYA', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0049', NULL, '40000000.00', 100, '', 8, 1513075154, 1, '2017-12-15 09:55:39', 1, 'DISTRIBUTION LINE', 1),
(1632, 7, 'IK0119', 'ABDU', 'KADUYU', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0596', NULL, '40000000.00', 100, '', 8, 1513076006, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(1633, 7, 'IK0126', 'AYUBU', 'HAJJI', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0090', NULL, '40000000.00', 100, '', 8, 1513076161, 1, '2017-12-15 09:55:40', 1, 'DISTRIBUTION LINE', 1),
(1636, 7, 'IK0133', 'YOSAM', 'KIGENYI', '', '0784374210', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0569', NULL, '40000000.00', 100, '', 8, 1513076380, 1, '2017-12-15 09:55:41', 1, 'PUBLIC TOILET SITE', 1),
(1637, 7, 'IK0208', 'DAVID', 'KAKUSU', '', '', 33, NULL, 5, 6, 3, '1', NULL, NULL, '0.0084', NULL, '32000000.00', 100, '', 8, 1513076629, 1, '2017-12-15 09:55:44', 1, 'DISTRIBUTION LINE', 1),
(1638, 7, 'IK0242', 'OBBO', 'KAGAWA', '', '', 33, NULL, 9, 19, 28, '1', NULL, NULL, '0.0823', NULL, '32000000.00', 100, '', 8, 1513077231, 1, '2017-12-15 09:55:46', 1, 'DISTRIBUTION LINE', 1),
(1639, 7, 'IK0326', 'SAMUEL', 'BAGANIGIRA', '', '', 33, NULL, 3, 14, 23, '1', NULL, NULL, '0.0102', NULL, '24000000.00', 100, '', 8, 1513078834, 1, '2017-12-15 09:55:51', 1, 'DISTRIBUTION LINE', 1),
(1640, 7, 'IK0397', 'ZAITUNI', '  ', '', '', 33, NULL, 3, 13, 21, '1', NULL, NULL, '0.0038', NULL, '40000000.00', 100, '', 8, 1513079169, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(1641, 7, 'IK0398', 'BASALIRWA', '', '', '', 33, NULL, 3, 13, 21, '1', NULL, NULL, '0.0077', NULL, '40000000.00', 100, '', 8, 1513079257, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(1642, 7, 'IK0399', 'ABDU', 'BALWILE', '', '', 33, NULL, 3, 13, 21, '1', NULL, NULL, '0.0033', NULL, '40000000.00', 100, '', 8, 1513079428, 1, '2017-12-15 09:55:54', 1, 'DISTRIBUTION LINE', 1),
(1643, 7, 'IK0409', 'KYAKULAGA', '  ', '', '', 33, NULL, 3, 13, 21, '1', NULL, NULL, '0.0044', NULL, '40000000.00', 100, '', 8, 1513079571, 1, '2017-12-15 09:55:55', 1, 'DISTRIBUTION LINE', 1),
(1644, 7, 'IK0433', 'UNKNOWN', '  ', '', '', 33, NULL, 3, 13, 22, '1', NULL, NULL, '0.0050', NULL, '40000000.00', 100, '', 8, 1513079702, 1, '2017-12-15 09:55:56', 1, 'DISTRIBUTION LINE', 1),
(1645, 7, 'IK0461', 'PHILLIP', 'MUSAWO', '', '', 33, NULL, 3, 13, 22, '1', NULL, NULL, '0.0073', NULL, '40000000.00', 100, '', 8, 1513079793, 1, '2017-12-15 09:55:58', 1, 'DISTRIBUTION LINE', 1),
(1646, 7, 'IK0551', 'ROGERS', 'ISABIRYE', '', '', 33, NULL, 3, 13, 20, '1', NULL, NULL, '0.0028', NULL, '40000000.00', 100, '', 8, 1513080492, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(1647, 7, 'IK0552', 'ISAAC', 'MUYINDA', '', '', 33, NULL, 3, 13, 20, '1', NULL, NULL, '0.0034', NULL, '40000000.00', 100, '', 8, 1513080703, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(1648, 7, 'IK0553', 'MUHAMMAD', 'BUTEGO', '', '', 33, NULL, 3, 13, 20, '1', NULL, NULL, '0.0066', NULL, '40000000.00', 100, '', 8, 1513080794, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(1649, 7, 'IK0554', 'UNKNOWN', '  ', '', '', 33, NULL, 3, 13, 20, '1', NULL, NULL, '0.0072', NULL, '40000000.00', 100, '', 8, 1513080938, 1, '2017-12-15 09:56:02', 1, 'DISTRIBUTION LINE', 1),
(1650, 7, 'IK0691', 'ROBERT', 'MUSEMBYA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0046', NULL, '40000000.00', 100, '', 8, 1513081318, 1, '2017-12-15 09:56:10', 1, 'DISTRIBUTION LINE', 1),
(1651, 7, 'IK0703', 'UNKNOWN', '', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0031', NULL, '40000000.00', 100, '', 8, 1513081477, 1, '2017-12-15 09:56:11', 1, 'DISTRIBUTION LINE', 1),
(1652, 7, 'IK0714', 'UNKNOWN', '', '', '', 33, NULL, 3, 17, 18, '1', NULL, NULL, '0.0056', NULL, '40000000.00', 100, '', 8, 1513081757, 1, '2017-12-15 09:56:12', 1, 'DISTRIBUTION LINE', 1),
(1653, 7, 'IK0745', 'HASSAN', 'KABI', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0048', NULL, '40000000.00', 100, '', 8, 1513081904, 1, '2017-12-15 09:56:14', 1, '', 1),
(1654, 7, 'IK0760', 'PHILLIP', 'MULWANYI', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0175', NULL, '40000000.00', 100, '', 8, 1513082044, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1655, 7, 'IK0763', 'JOHN', 'TIBIBUZA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0043', NULL, '40000000.00', 100, '', 8, 1513082501, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1656, 7, 'IK0764', 'PETER', 'KIMUMWA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0028', NULL, '40000000.00', 100, '', 8, 1513082670, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1657, 7, 'IK0765', 'MARGARET', 'NANKWANGA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0073', NULL, '40000000.00', 100, '', 8, 1513082957, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1658, 7, 'IK0766', 'ZAITUNI', 'NALUWEMBE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0095', NULL, '40000000.00', 100, '', 8, 1513090267, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1661, 7, 'IK0769', 'JOHN', 'MPOLOGOMA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0049', NULL, '40000000.00', 100, '', 8, 1513091153, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1662, 7, 'IK0770', 'STEVEN', 'WADOBE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0044', NULL, '40000000.00', 100, '', 8, 1513091894, 1, '2017-12-15 09:56:15', 1, 'DISTRIBUTION LINE', 1),
(1663, 7, 'IK0775', 'KAUDHA', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0086', NULL, '40000000.00', 100, '', 8, 1513092592, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1664, 7, 'IK0778', 'LUKIYA', '  ', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0063', NULL, '40000000.00', 100, '', 8, 1513146445, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1665, 7, 'IK0781', 'LUSULI', 'MUKWAYA', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0036', NULL, '40000000.00', 100, '', 8, 1513146756, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1666, 7, 'IK0784', 'KEVINA', '', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0021', NULL, '40000000.00', 100, '', 8, 1513147310, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1670, 7, 'IK0785', 'SALEH', 'BINOZE', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0244', NULL, '40000000.00', 100, '', 8, 1513147809, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1671, 7, 'IK0786', 'RICHARD', 'CANON', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.1252', NULL, '40000000.00', 100, '', 8, 1513148308, 1, '2017-12-15 09:56:16', 1, 'DISTRIBUTION LINE', 1),
(1672, 7, 'IK0788', 'SEMUWEMBA', '', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0068', NULL, '40000000.00', 100, '', 8, 1513148805, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1674, 7, 'IK0791', 'IBRAHIM', '', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0028', NULL, '40000000.00', 100, '', 8, 1513149387, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1675, 7, 'IK0794', 'MUHAMMAD', 'LONDO', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0099', NULL, '40000000.00', 100, '', 8, 1513149711, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1676, 7, 'IK0805', 'NALWOGA', '', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0054', NULL, '40000000.00', 100, '', 8, 1513150023, 1, '2017-12-15 09:56:17', 1, 'DISTRIBUTION LINE', 1),
(1679, 7, 'IK0809', 'ZAINA', 'NAKISUYI', '', '', 33, NULL, 3, 13, 12, '1', NULL, NULL, '0.0086', NULL, '40000000.00', 100, '', 8, 1513150248, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1680, 7, 'IK0818', 'GLADYS', 'KAZANA', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0541', NULL, '40000000.00', 100, '', 8, 1513150825, 1, '2017-12-15 09:56:18', 1, 'DISTRIBUTION LINE', 1),
(1681, 7, 'IK0819', 'ZUBAIRI', 'WAISWA', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0223', NULL, '40000000.00', 100, '', 8, 1513151938, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1682, 7, 'IK0822', 'JAFARI', 'NDAYE', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0094', NULL, '40000000.00', 100, '', 8, 1513152062, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1683, 7, 'IK0823', 'MIRABU', 'IKULUBA', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0247', NULL, '40000000.00', 100, '', 8, 1513152152, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1684, 7, 'IK0824', 'JAMES', 'LUBAMBO', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0241', NULL, '40000000.00', 100, '', 8, 1513152561, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1685, 7, 'IK0825', 'EMMANUEL', 'KISUBI', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0226', NULL, '40000000.00', 100, '', 8, 1513153330, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1686, 7, 'IK0825', 'EMMANUEL', 'KISUBI', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0226', NULL, '40000000.00', 100, '', 8, 1513153333, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1687, 7, 'IK0826', 'JAMES', 'LUBAMBO', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0686', NULL, '40000000.00', 100, '', 8, 1513154531, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1688, 7, 'IK0827', 'RASHIDA', 'NANKYA', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0576', NULL, '40000000.00', 100, '', 8, 1513155125, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1689, 7, 'IK0828', 'JAMILA', 'NAMUGELE', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0163', NULL, '40000000.00', 100, '', 8, 1513158463, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1690, 7, 'IK0829', 'PAUL', 'MUWANGUZI', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0140', NULL, '40000000.00', 100, '', 8, 1513158613, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1691, 7, 'IK0829', 'PAUL', 'MUWANGUZI', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0140', NULL, '40000000.00', 100, '', 8, 1513158615, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1692, 7, 'IK0830', 'BALAT', 'KYABATENDA', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0099', NULL, '40000000.00', 100, '', 8, 1513158875, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1693, 7, 'IK0831', 'PAUL', 'BULLO', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0228', NULL, '40000000.00', 100, '', 8, 1513159038, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1694, 7, 'IK0832', 'KAMBUZI', 'BANANWA', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0134', NULL, '40000000.00', 100, '', 8, 1513159255, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1695, 7, 'IK0833', 'DAUDI', 'BALONDEMU', '', '', 33, NULL, 2, 16, 15, '1', NULL, NULL, '0.0000', NULL, '40000000.00', 100, '', 8, 1513160487, 1, '2017-12-15 09:56:19', 1, 'DISTRIBUTION LINE', 1),
(1696, 7, 'IK1047', 'NAIBIRI PARISH', '  ', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0241', NULL, '24000000.00', 100, '', 8, 1513161031, 1, '2017-12-15 09:56:31', 1, 'PUBLIC TOILET SITE', 1),
(1697, 7, 'IK1095', 'NURU', 'KIBIYE', '', '', 33, NULL, 2, 10, 34, '1', NULL, NULL, '0.0155', NULL, '24000000.00', 100, '', 8, 1513161544, 1, '2017-12-15 09:56:34', 1, 'DISTRIBUTION LINE', 1),
(1698, 7, 'IK1131', 'ST PETER`S CATHOLIC CHURCH NABITENDE', '    ', '', '', 33, NULL, 2, 10, 34, '1', NULL, NULL, '0.0392', NULL, '24000000.00', 100, '', 8, 1513164324, 1, '2017-12-15 09:56:36', 1, 'DISTRIBUTION LINE', 1),
(1699, 7, 'IK1142', 'CHARLES', 'WANUME', '', '', 33, NULL, 2, 10, 8, '1', NULL, NULL, '0.0079', NULL, '24000000.00', 100, '', 8, 1513166771, 1, '2017-12-15 09:56:37', 1, 'DISTRIBUTION LINE', 1),
(1701, 7, 'IK1370', 'JOHN', 'KASADA', 'STEVEN', '', 41, NULL, 6, 8, 32, '1', NULL, NULL, '0.0223', NULL, '56000000.00', 100, '', 8, 1513170707, 1, '2017-12-15 09:56:49', 1, 'DISTRIBUTION LINE', 1),
(1702, 7, 'IK1376', 'MONDOLO', '  ', '', '', 41, NULL, 6, 8, 5, '1', NULL, NULL, '0.0144', NULL, '56000000.00', 100, '', 8, 1513170799, 1, '2017-12-15 09:56:50', 1, 'DISTRIBUTION LINE', 1),
(1703, 7, 'IK1377', 'UNKNOWN', '', '', '', 41, NULL, 6, 8, 5, '1', NULL, NULL, '0.0137', NULL, '56000000.00', 100, '', 8, 1513170867, 1, '2017-12-15 09:56:50', 1, '', 1),
(1704, 7, 'IK1461', 'UNKNOWN TEACHER', '  ', '', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0161', NULL, '56000000.00', 100, '', 8, 1513171130, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1705, 7, 'IK1462', 'ANNA', 'KIWANIZI', 'KERETI', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0222', NULL, '56000000.00', 100, '', 8, 1513171227, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1706, 7, 'IK1463', 'NASSER', 'OPEDUN', '', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0082', NULL, '56000000.00', 100, '', 8, 1513171330, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1707, 7, 'IK1464', 'UNKNOWN ', '  ', '', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0035', NULL, '56000000.00', 100, '', 8, 1513171410, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1708, 7, 'IK1465', 'PEERA', 'WAAYO', 'DAVID', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0204', NULL, '56000000.00', 100, '', 8, 1513171471, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1709, 7, 'IK1466', 'ISMAIL', '  ', '', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0068', NULL, '56000000.00', 100, '', 8, 1513171534, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1710, 7, 'IK1467', 'JOSEPH', 'WABWIRE', '', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0088', NULL, '56000000.00', 100, '', 8, 1513171598, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1711, 7, 'IK1468', 'FRANCIS', 'MAKANANGA', '', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0227', NULL, '56000000.00', 100, '', 8, 1513171707, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1712, 7, 'IK1469', 'MARTIN', 'KINTU', '', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0095', NULL, '56000000.00', 100, '', 8, 1513171781, 1, '2017-12-15 09:56:55', 1, 'DISTRIBUTION LINE', 1),
(1713, 7, 'IK1490', 'CHARLES', 'WAMBI', '', '', 41, NULL, 6, 8, 31, '1', NULL, NULL, '0.0041', NULL, '56000000.00', 100, '', 8, 1513172052, 1, '2017-12-15 09:56:57', 1, 'DISTRIBUTION LINE', 1),
(1715, 7, 'IK1568', 'BETTY', 'NABUNYA', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0014', NULL, '56000000.00', 100, '', 8, 1513172496, 1, '2017-12-15 09:57:01', 1, 'DISTRIBUTION LINE', 1),
(1716, 7, 'IK1567', 'ALICE', '  ', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0012', NULL, '56000000.00', 100, '', 8, 1513172539, 1, '2017-12-15 09:57:01', 1, 'DISTRIBUTION LINE', 1),
(1717, 7, 'IK1613', 'KASAJA', '    ', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0092', NULL, '56000000.00', 100, '', 8, 1513172681, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1718, 7, 'IK1614', 'FABIANO', 'KYOTANALYA', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0043', NULL, '56000000.00', 100, '', 8, 1513172743, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1719, 7, 'IK1615', 'LUGUDO', '  ', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0022', NULL, '56000000.00', 100, '', 8, 1513172792, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1720, 7, 'IK1616', 'HABIB', 'BASALIRWA', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0027', NULL, '56000000.00', 100, '', 8, 1513172868, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1721, 7, 'IK1617', 'HASIFA', 'MUKUNGU', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0040', NULL, '48000000.00', 100, '', 8, 1513172947, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1722, 7, 'IK1618', 'WAAYA', '  ', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0026', NULL, '48000000.00', 100, '', 8, 1513173009, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1723, 7, 'IK1619', 'CHARLSE', 'BUSILI', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0023', NULL, '48000000.00', 100, '', 8, 1513173073, 1, '2017-12-15 09:57:04', 1, 'DISTRIBUTION LINE', 1),
(1724, 7, 'IK1620', 'BETTY', 'KADAMA', '', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0043', NULL, '48000000.00', 100, '', 8, 1513173125, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1725, 7, 'IK1621', 'BIN', 'PATEL', 'KALIPES', '', 41, NULL, 6, 24, 38, '1', NULL, NULL, '0.0033', NULL, '48000000.00', 100, '', 8, 1513173208, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1726, 7, 'IK1624', 'MULESA', '  ', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0352', NULL, '48000000.00', 100, '', 8, 1513173319, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1727, 7, 'IK1636', 'TOM', 'KEEYA', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0780', NULL, '48000000.00', 100, '', 8, 1513173670, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1728, 7, 'IK1637', 'CONSTANT', 'MUSOBYA', '', '', 41, NULL, 8, 11, 39, '1', NULL, NULL, '0.0523', NULL, '48000000.00', 100, '', 8, 1513173788, 1, '2017-12-15 09:57:05', 1, 'DISTRIBUTION LINE', 1),
(1729, 7, 'IK0909', 'HARRIET', 'NABIRYE', '', '', 33, NULL, 2, 22, 33, '1', NULL, NULL, '0.0332', NULL, '12000000.00', 100, '', 8, 1513244418, 1, '2017-12-15 09:56:24', 1, 'DISTRIBUTION LINE', 1),
(1730, 7, 'IK0286', 'JAMES', 'BATUME', '', '', 33, NULL, 3, 18, 26, '1', NULL, NULL, '0.0063', NULL, '24000000.00', 100, '', 8, 1513266515, 1, '2017-12-15 09:55:48', 1, 'DISTRIBUTION LINE', 1),
(1731, 7, 'IK0506-1', ' ', ' LUSALALILA', '', '', 33, NULL, 3, 13, 20, '1', NULL, NULL, '0.1674', NULL, '40000000.00', 100, '', 8, 1513323296, 1, '2017-12-15 09:56:00', 1, 'PROPOSED OFFICE SITE 1', 1),
(1732, 7, 'IK0506-2', ' ', ' LUSALALILA', '', '', 33, NULL, 3, 13, 20, '1', NULL, NULL, '0.1605', NULL, '40000000.00', 100, '', 8, 1513323350, 1, '2017-12-15 09:56:00', 1, 'PROPOSED OFFICE SITE 2', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pap_crop_tree`
--

CREATE TABLE `tbl_pap_crop_tree` (
  `id` int(11) NOT NULL,
  `pap_id` int(11) NOT NULL,
  `crop_description_rate_id` int(11) NOT NULL,
  `rate` decimal(12,2) NOT NULL,
  `quantity` smallint(6) NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_created` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_pap_crop_tree`
--

INSERT INTO `tbl_pap_crop_tree` (`id`, `pap_id`, `crop_description_rate_id`, `rate`, `quantity`, `created_by`, `date_created`, `modified_by`, `date_modified`) VALUES
(17, 2, 11, '5000.00', 7, 1, 1512061957, 1, '2017-11-30 17:12:37'),
(18, 10, 11, '25000.00', 2, 1, 1512062227, 1, '2017-11-30 17:17:07'),
(19, 2, 11, '20000.00', 51, 1, 1512135875, 1, '2017-12-01 13:44:35'),
(20, 4, 11, '300000.00', 32, 1, 1512135991, 1, '2017-12-01 13:46:31'),
(21, 4, 11, '300000.00', 32, 1, 1512136350, 1, '2017-12-01 13:52:30'),
(23, 10, 11, '100000.00', 96, 1, 1512151465, 1, '2017-12-01 18:04:25'),
(25, 18, 2, '25000.00', 4, 1, 1512212545, 1, '2017-12-02 11:02:25'),
(26, 21, 45, '150000.00', 1, 1, 1512212763, 1, '2017-12-02 11:06:03'),
(27, 23, 85, '10000.00', 1, 1, 1512212973, 1, '2017-12-02 11:09:33'),
(28, 23, 19, '10000.00', 1, 1, 1512212973, 1, '2017-12-02 11:09:33'),
(31, 27, 4, '3000.00', 1, 1, 1512213243, 1, '2017-12-02 11:14:03'),
(32, 27, 3, '15000.00', 1, 1, 1512213243, 1, '2017-12-02 11:14:03'),
(33, 30, 46, '100000.00', 1, 1, 1512213483, 1, '2017-12-02 11:18:03'),
(34, 30, 73, '70000.00', 1, 1, 1512213483, 1, '2017-12-02 11:18:03'),
(35, 31, 85, '10000.00', 1, 1, 1512213558, 1, '2017-12-02 11:19:18'),
(36, 32, 85, '10000.00', 1, 1, 1512213892, 1, '2017-12-02 11:24:52'),
(37, 33, 85, '10000.00', 2, 1, 1512214002, 1, '2017-12-02 11:26:42'),
(38, 33, 88, '10000.00', 10, 1, 1512214002, 1, '2017-12-02 11:26:42'),
(39, 33, 103, '15000.00', 12, 1, 1512214002, 1, '2017-12-02 11:26:42'),
(40, 34, 71, '150000.00', 1, 1, 1512214154, 1, '2017-12-02 11:29:14'),
(41, 34, 82, '70000.00', 1, 1, 1512214154, 1, '2017-12-02 11:29:14'),
(42, 34, 19, '10000.00', 2, 1, 1512214154, 1, '2017-12-02 11:29:14'),
(43, 34, 2, '25000.00', 1, 1, 1512214154, 1, '2017-12-02 11:29:14'),
(44, 34, 6, '10000.00', 3, 1, 1512214154, 1, '2017-12-02 11:29:14'),
(45, 35, 87, '100000.00', 5, 1, 1512214540, 1, '2017-12-02 11:35:40'),
(46, 35, 104, '25000.00', 4, 1, 1512214540, 1, '2017-12-02 11:35:40'),
(47, 35, 32, '300000.00', 3, 1, 1512214540, 1, '2017-12-02 11:35:40'),
(48, 35, 85, '10000.00', 1, 1, 1512214540, 1, '2017-12-02 11:35:40'),
(49, 35, 19, '10000.00', 1, 1, 1512214540, 1, '2017-12-02 11:35:40'),
(50, 35, 46, '100000.00', 1, 1, 1512214540, 1, '2017-12-02 11:35:40'),
(51, 35, 7, '5000.00', 12, 1, 1512214540, 1, '2017-12-02 11:35:40'),
(52, 35, 111, '100000.00', 4, 1, 1512214540, 1, '2017-12-02 11:35:40'),
(53, 38, 11, '200000.00', 1, 1, 1512214909, 1, '2017-12-02 11:41:49'),
(54, 38, 104, '25000.00', 3, 1, 1512214909, 1, '2017-12-02 11:41:49'),
(55, 39, 4, '3000.00', 6, 1, 1512215029, 1, '2017-12-02 11:43:49'),
(56, 40, 87, '100000.00', 2, 1, 1512215114, 1, '2017-12-02 11:45:14'),
(57, 42, 6, '10000.00', 7, 1, 1512215515, 1, '2017-12-02 11:51:55'),
(58, 42, 90, '35000.00', 1, 1, 1512215515, 1, '2017-12-02 11:51:55'),
(59, 42, 33, '150000.00', 2, 1, 1512215515, 1, '2017-12-02 11:51:55'),
(60, 42, 12, '100000.00', 1, 1, 1512215515, 1, '2017-12-02 11:51:55'),
(61, 42, 47, '20000.00', 1, 1, 1512215515, 1, '2017-12-02 11:51:55'),
(62, 44, 45, '150000.00', 1, 1, 1512215795, 1, '2017-12-02 11:56:35'),
(63, 44, 32, '300000.00', 1, 1, 1512215795, 1, '2017-12-02 11:56:35'),
(64, 46, 32, '300000.00', 1, 1, 1512215949, 1, '2017-12-02 11:59:09'),
(65, 2, 45, '10000.00', 6, 1, 1512215982, 1, '2017-12-02 11:59:42'),
(66, 3, 45, '10000.00', 6, 1, 1512216055, 1, '2017-12-02 12:00:55'),
(67, 3, 45, '4000.00', 118, 1, 1512216225, 1, '2017-12-02 12:03:45'),
(68, 5, 41, '2000.00', 117, 1, 1512216415, 1, '2017-12-02 12:06:55'),
(69, 3, 41, '4000.00', 118, 1, 1512216417, 1, '2017-12-02 12:06:57'),
(70, 3, 45, '4000.00', 118, 1, 1512217153, 1, '2017-12-02 12:19:13'),
(71, 54, 6, '10000.00', 5, 1, 1512217452, 1, '2017-12-02 12:24:12'),
(72, 54, 3, '15000.00', 3, 1, 1512217452, 1, '2017-12-02 12:24:12'),
(73, 54, 6, '10000.00', 6, 1, 1512217452, 1, '2017-12-02 12:24:12'),
(74, 59, 104, '25000.00', 7, 1, 1512217886, 1, '2017-12-02 12:31:26'),
(75, 60, 6, '10000.00', 3, 1, 1512217898, 1, '2017-12-02 12:31:38'),
(76, 60, 118, '4000.00', 3, 1, 1512217898, 1, '2017-12-02 12:31:38'),
(77, 61, 117, '2000.00', 5, 1, 1512218030, 1, '2017-12-02 12:33:50'),
(78, 63, 6, '10000.00', 2, 1, 1512218288, 1, '2017-12-02 12:38:08'),
(80, 67, 19, '10000.00', 1, 1, 1512218472, 1, '2017-12-02 12:41:12'),
(81, 67, 83, '60000.00', 1, 1, 1512218472, 1, '2017-12-02 12:41:12'),
(82, 1, 74, '60000.00', 83, 1, 1512218808, 1, '2017-12-02 12:46:48'),
(84, 2, 75, '50000.00', 89, 1, 1512218980, 1, '2017-12-02 12:49:40'),
(86, 2, 75, '50000.00', 89, 1, 1512219006, 1, '2017-12-02 12:50:06'),
(87, 1, 74, '60000.00', 83, 1, 1512219025, 1, '2017-12-02 12:50:25'),
(88, 2, 75, '50000.00', 89, 1, 1512219084, 1, '2017-12-02 12:51:24'),
(89, 79, 89, '50000.00', 2, 1, 1512219205, 1, '2017-12-02 12:53:25'),
(90, 80, 83, '60000.00', 1, 1, 1512219241, 1, '2017-12-02 12:54:01'),
(91, 81, 87, '100000.00', 4, 1, 1512219328, 1, '2017-12-02 12:55:28'),
(92, 82, 83, '60000.00', 1, 1, 1512219330, 1, '2017-12-02 12:55:30'),
(93, 90, 85, '10000.00', 3, 1, 1512219820, 1, '2017-12-02 13:03:40'),
(94, 90, 104, '25000.00', 10, 1, 1512219820, 1, '2017-12-02 13:03:40'),
(95, 93, 2, '25000.00', 2, 1, 1512219925, 1, '2017-12-02 13:05:25'),
(96, 93, 7, '5000.00', 2, 1, 1512219925, 1, '2017-12-02 13:05:25'),
(97, 93, 19, '10000.00', 2, 1, 1512219925, 1, '2017-12-02 13:05:25'),
(98, 93, 32, '300000.00', 2, 1, 1512219925, 1, '2017-12-02 13:05:25'),
(99, 93, 82, '70000.00', 1, 1, 1512219925, 1, '2017-12-02 13:05:25'),
(100, 94, 45, '150000.00', 1, 1, 1512219968, 1, '2017-12-02 13:06:08'),
(101, 95, 3, '15000.00', 1, 1, 1512219971, 1, '2017-12-02 13:06:11'),
(102, 95, 85, '10000.00', 1, 1, 1512219971, 1, '2017-12-02 13:06:11'),
(103, 98, 83, '60000.00', 1, 1, 1512220143, 1, '2017-12-02 13:09:03'),
(105, 101, 83, '60000.00', 1, 1, 1512220318, 1, '2017-12-02 13:11:58'),
(106, 101, 49, '80000.00', 1, 1, 1512220318, 1, '2017-12-02 13:11:58'),
(111, 120, 45, '150000.00', 1, 1, 1512220958, 1, '2017-12-02 13:22:38'),
(112, 121, 81, '80000.00', 1, 1, 1512221013, 1, '2017-12-02 13:23:33'),
(113, 124, 2, '25000.00', 1, 1, 1512221107, 1, '2017-12-02 13:25:07'),
(114, 125, 118, '4000.00', 6, 1, 1512221166, 1, '2017-12-02 13:26:06'),
(115, 125, 7, '5000.00', 1, 1, 1512221166, 1, '2017-12-02 13:26:06'),
(117, 134, 32, '300000.00', 1, 1, 1512221573, 1, '2017-12-02 13:32:53'),
(118, 136, 19, '10000.00', 5, 1, 1512221649, 1, '2017-12-02 13:34:09'),
(119, 136, 6, '10000.00', 1, 1, 1512221649, 1, '2017-12-02 13:34:09'),
(120, 141, 19, '10000.00', 2, 1, 1512221884, 1, '2017-12-02 13:38:04'),
(121, 141, 6, '10000.00', 6, 1, 1512221884, 1, '2017-12-02 13:38:04'),
(122, 141, 118, '4000.00', 4, 1, 1512221884, 1, '2017-12-02 13:38:04'),
(124, 149, 76, '150000.00', 1, 1, 1512222171, 1, '2017-12-02 13:42:51'),
(125, 150, 32, '300000.00', 1, 1, 1512222191, 1, '2017-12-02 13:43:11'),
(126, 153, 19, '10000.00', 2, 1, 1512222287, 1, '2017-12-02 13:44:47'),
(127, 7, 59, '5000.00', 122, 1, 1512222335, 1, '2017-12-02 13:45:35'),
(128, 155, 19, '10000.00', 2, 1, 1512222369, 1, '2017-12-02 13:46:09'),
(129, 155, 6, '10000.00', 2, 1, 1512222369, 1, '2017-12-02 13:46:09'),
(130, 157, 32, '300000.00', 1, 1, 1512222432, 1, '2017-12-02 13:47:12'),
(131, 7, 59, '5000.00', 122, 1, 1512222443, 1, '2017-12-02 13:47:23'),
(132, 1, 158, '150000.00', 71, 1, 1512222544, 1, '2017-12-02 13:49:04'),
(133, 160, 21, '3000.00', 3, 1, 1512222574, 1, '2017-12-02 13:49:34'),
(134, 1, 158, '150000.00', 45, 1, 1512222608, 1, '2017-12-02 13:50:08'),
(136, 163, 19, '10000.00', 1, 1, 1512222744, 1, '2017-12-02 13:52:24'),
(137, 165, 6, '10000.00', 3, 1, 1512222808, 1, '2017-12-02 13:53:28'),
(138, 167, 49, '80000.00', 1, 1, 1512222980, 1, '2017-12-02 13:56:20'),
(139, 168, 83, '60000.00', 2, 1, 1512223226, 1, '2017-12-02 14:00:26'),
(140, 168, 19, '10000.00', 15, 1, 1512223226, 1, '2017-12-02 14:00:26'),
(141, 168, 49, '80000.00', 2, 1, 1512223226, 1, '2017-12-02 14:00:26'),
(142, 172, 95, '300000.00', 5, 1, 1512223375, 1, '2017-12-02 14:02:55'),
(143, 179, 7, '5000.00', 5, 1, 1512223599, 1, '2017-12-02 14:06:39'),
(144, 179, 83, '60000.00', 1, 1, 1512223599, 1, '2017-12-02 14:06:39'),
(145, 179, 19, '10000.00', 13, 1, 1512223599, 1, '2017-12-02 14:06:39'),
(146, 180, 117, '2000.00', 10, 1, 1512223648, 1, '2017-12-02 14:07:28'),
(147, 182, 19, '10000.00', 1, 1, 1512223669, 1, '2017-12-02 14:07:49'),
(149, 185, 9, '2000.00', 3, 1, 1512223844, 1, '2017-12-02 14:10:44'),
(150, 186, 6, '10000.00', 4, 1, 1512224166, 1, '2017-12-02 14:16:06'),
(151, 188, 117, '2000.00', 6, 1, 1512224254, 1, '2017-12-02 14:17:34'),
(153, 190, 45, '150000.00', 1, 1, 1512224273, 1, '2017-12-02 14:17:53'),
(155, 198, 19, '10000.00', 2, 1, 1512224915, 1, '2017-12-02 14:28:35'),
(156, 198, 6, '10000.00', 2, 1, 1512224915, 1, '2017-12-02 14:28:35'),
(157, 216, 85, '10000.00', 1, 1, 1512225901, 1, '2017-12-02 14:45:01'),
(158, 228, 83, '60000.00', 1, 1, 1512226727, 1, '2017-12-02 14:58:47'),
(159, 229, 3, '15000.00', 1, 1, 1512226729, 1, '2017-12-02 14:58:49'),
(160, 230, 7, '5000.00', 1, 1, 1512226824, 1, '2017-12-02 15:00:24'),
(161, 230, 9, '2000.00', 1, 1, 1512226824, 1, '2017-12-02 15:00:24'),
(162, 230, 85, '10000.00', 1, 1, 1512226824, 1, '2017-12-02 15:00:24'),
(163, 236, 87, '100000.00', 4, 1, 1512227084, 1, '2017-12-02 15:04:44'),
(164, 237, 76, '150000.00', 2, 1, 1512227108, 1, '2017-12-02 15:05:08'),
(165, 237, 3, '15000.00', 10, 1, 1512227108, 1, '2017-12-02 15:05:08'),
(166, 240, 76, '150000.00', 1, 1, 1512227298, 1, '2017-12-02 15:08:18'),
(167, 240, 2, '25000.00', 10, 1, 1512227298, 1, '2017-12-02 15:08:18'),
(168, 240, 79, '70000.00', 1, 1, 1512227298, 1, '2017-12-02 15:08:18'),
(169, 240, 72, '100000.00', 1, 1, 1512227298, 1, '2017-12-02 15:08:18'),
(170, 240, 32, '300000.00', 1, 1, 1512227298, 1, '2017-12-02 15:08:18'),
(171, 242, 6, '10000.00', 4, 1, 1512227372, 1, '2017-12-02 15:09:32'),
(172, 243, 45, '150000.00', 1, 1, 1512227567, 1, '2017-12-02 15:12:47'),
(173, 244, 95, '300000.00', 3, 1, 1512227921, 1, '2017-12-02 15:18:41'),
(174, 244, 45, '150000.00', 3, 1, 1512227921, 1, '2017-12-02 15:18:41'),
(175, 244, 2, '25000.00', 3, 1, 1512227921, 1, '2017-12-02 15:18:41'),
(176, 245, 19, '10000.00', 2, 1, 1512227971, 1, '2017-12-02 15:19:31'),
(177, 245, 7, '5000.00', 2, 1, 1512227971, 1, '2017-12-02 15:19:31'),
(178, 248, 19, '10000.00', 3, 1, 1512228139, 1, '2017-12-02 15:22:19'),
(179, 250, 19, '10000.00', 2, 1, 1512228239, 1, '2017-12-02 15:23:59'),
(180, 255, 45, '150000.00', 5, 1, 1512228430, 1, '2017-12-02 15:27:10'),
(181, 255, 2, '25000.00', 1, 1, 1512228430, 1, '2017-12-02 15:27:10'),
(182, 256, 22, '2500.00', 6, 1, 1512228584, 1, '2017-12-02 15:29:44'),
(183, 256, 7, '5000.00', 6, 1, 1512228584, 1, '2017-12-02 15:29:44'),
(184, 270, 90, '35000.00', 3, 1, 1512229225, 1, '2017-12-02 15:40:25'),
(185, 5, 285, '100000.00', 87, 1, 1512230177, 1, '2017-12-02 15:56:17'),
(186, 290, 87, '100000.00', 5, 1, 1512230344, 1, '2017-12-02 15:59:04'),
(187, 302, 45, '150000.00', 1, 1, 1512230988, 1, '2017-12-02 16:09:48'),
(188, 305, 45, '150000.00', 1, 1, 1512231300, 1, '2017-12-02 16:15:00'),
(189, 1, 314, '150000.00', 45, 1, 1512231830, 1, '2017-12-02 16:23:50'),
(190, 318, 6, '10000.00', 1, 1, 1512231931, 1, '2017-12-02 16:25:31'),
(191, 326, 2, '25000.00', 1, 1, 1512232189, 1, '2017-12-02 16:29:49'),
(192, 327, 2, '25000.00', 1, 1, 1512232250, 1, '2017-12-02 16:30:50'),
(193, 328, 123, '5000.00', 1, 1, 1512232456, 1, '2017-12-02 16:34:16'),
(194, 328, 3, '15000.00', 1, 1, 1512232456, 1, '2017-12-02 16:34:16'),
(195, 345, 113, '30000.00', 1, 1, 1512235088, 1, '2017-12-02 17:18:08'),
(196, 345, 45, '150000.00', 1, 1, 1512235088, 1, '2017-12-02 17:18:08'),
(197, 345, 19, '10000.00', 20, 1, 1512235088, 1, '2017-12-02 17:18:08'),
(198, 345, 77, '100000.00', 3, 1, 1512235088, 1, '2017-12-02 17:18:08'),
(199, 347, 2, '25000.00', 10, 1, 1512235171, 1, '2017-12-02 17:19:31'),
(200, 348, 79, '70000.00', 2, 1, 1512235240, 1, '2017-12-02 17:20:40'),
(201, 348, 45, '150000.00', 1, 1, 1512235240, 1, '2017-12-02 17:20:40'),
(202, 349, 79, '70000.00', 3, 1, 1512235318, 1, '2017-12-02 17:21:58'),
(205, 351, 45, '150000.00', 7, 1, 1512235491, 1, '2017-12-02 17:24:51'),
(206, 356, 45, '150000.00', 1, 1, 1512235885, 1, '2017-12-02 17:31:25'),
(207, 1, 361, '15000.00', 3, 1, 1512236246, 1, '2017-12-02 17:37:26'),
(208, 364, 82, '70000.00', 1, 1, 1512236350, 1, '2017-12-02 17:39:10'),
(209, 365, 45, '150000.00', 1, 1, 1512236426, 1, '2017-12-02 17:40:26'),
(210, 365, 83, '60000.00', 3, 1, 1512236426, 1, '2017-12-02 17:40:26'),
(211, 370, 46, '100000.00', 1, 1, 1512236796, 1, '2017-12-02 17:46:36'),
(212, 373, 45, '150000.00', 1, 1, 1512236989, 1, '2017-12-02 17:49:49'),
(213, 375, 45, '150000.00', 1, 1, 1512237110, 1, '2017-12-02 17:51:50'),
(214, 378, 19, '10000.00', 1, 1, 1512237239, 1, '2017-12-02 17:53:59'),
(215, 378, 33, '150000.00', 2, 1, 1512237239, 1, '2017-12-02 17:53:59'),
(216, 378, 9, '2000.00', 2, 1, 1512237239, 1, '2017-12-02 17:53:59'),
(217, 378, 3, '15000.00', 1, 1, 1512237239, 1, '2017-12-02 17:53:59'),
(218, 3, 377, '10000.00', 19, 1, 1512237350, 1, '2017-12-02 17:55:50'),
(219, 3, 377, '10000.00', 19, 1, 1512237372, 1, '2017-12-02 17:56:12'),
(221, 380, 45, '150000.00', 1, 1, 1512237454, 1, '2017-12-02 17:57:34'),
(222, 381, 36, '350000.00', 2, 1, 1512237470, 1, '2017-12-02 17:57:50'),
(223, 381, 19, '10000.00', 4, 1, 1512237470, 1, '2017-12-02 17:57:50'),
(224, 382, 19, '10000.00', 8, 1, 1512237635, 1, '2017-12-02 18:00:35'),
(225, 382, 7, '5000.00', 1, 1, 1512237635, 1, '2017-12-02 18:00:35'),
(226, 382, 9, '2000.00', 5, 1, 1512237635, 1, '2017-12-02 18:00:35'),
(227, 382, 123, '5000.00', 1, 1, 1512237635, 1, '2017-12-02 18:00:35'),
(228, 384, 76, '150000.00', 1, 1, 1512237885, 1, '2017-12-02 18:04:45'),
(229, 384, 81, '80000.00', 1, 1, 1512237885, 1, '2017-12-02 18:04:45'),
(230, 385, 76, '150000.00', 1, 1, 1512238008, 1, '2017-12-02 18:06:48'),
(231, 385, 81, '80000.00', 1, 1, 1512238008, 1, '2017-12-02 18:06:48'),
(232, 385, 86, '2000.00', 4, 1, 1512238008, 1, '2017-12-02 18:06:48'),
(233, 389, 73, '70000.00', 1, 1, 1512291015, 1, '2017-12-03 08:50:15'),
(234, 397, 71, '150000.00', 1, 1, 1512291335, 1, '2017-12-03 08:55:35'),
(235, 401, 45, '150000.00', 1, 1, 1512291470, 1, '2017-12-03 08:57:50'),
(236, 405, 55, '20000.00', 1, 1, 1512291649, 1, '2017-12-03 09:00:49'),
(237, 406, 55, '20000.00', 1, 1, 1512291710, 1, '2017-12-03 09:01:50'),
(238, 407, 71, '150000.00', 1, 1, 1512291783, 1, '2017-12-03 09:03:03'),
(239, 1, 412, '25000.00', 2, 1, 1512292047, 1, '2017-12-03 09:07:27'),
(240, 419, 116, '20000.00', 1, 1, 1512292113, 1, '2017-12-03 09:08:33'),
(241, 420, 122, '5000.00', 2, 1, 1512292191, 1, '2017-12-03 09:09:51'),
(242, 422, 71, '150000.00', 1, 1, 1512292271, 1, '2017-12-03 09:11:11'),
(243, 432, 71, '150000.00', 1, 1, 1512292542, 1, '2017-12-03 09:15:42'),
(244, 435, 71, '150000.00', 1, 1, 1512292622, 1, '2017-12-03 09:17:02'),
(245, 436, 79, '70000.00', 2, 1, 1512292650, 1, '2017-12-03 09:17:30'),
(246, 436, 81, '80000.00', 1, 1, 1512292650, 1, '2017-12-03 09:17:30'),
(247, 436, 11, '200000.00', 1, 1, 1512292650, 1, '2017-12-03 09:17:30'),
(248, 449, 122, '5000.00', 5, 1, 1512292937, 1, '2017-12-03 09:22:17'),
(249, 456, 2, '25000.00', 1, 1, 1512293144, 1, '2017-12-03 09:25:44'),
(250, 457, 2, '25000.00', 1, 1, 1512293222, 1, '2017-12-03 09:27:02'),
(251, 467, 2, '25000.00', 1, 1, 1512293517, 1, '2017-12-03 09:31:57'),
(252, 483, 45, '150000.00', 1, 1, 1512294224, 1, '2017-12-03 09:43:44'),
(253, 495, 2, '25000.00', 3, 1, 1512294711, 1, '2017-12-03 09:51:51'),
(254, 495, 55, '20000.00', 1, 1, 1512294711, 1, '2017-12-03 09:51:51'),
(255, 495, 122, '5000.00', 10, 1, 1512294711, 1, '2017-12-03 09:51:51'),
(256, 501, 6, '10000.00', 3, 1, 1512294977, 1, '2017-12-03 09:57:07'),
(257, 506, 122, '5000.00', 1, 1, 1512295241, 1, '2017-12-03 10:00:41'),
(258, 529, 45, '150000.00', 1, 1, 1512295805, 1, '2017-12-03 10:10:05'),
(259, 530, 122, '5000.00', 4, 1, 1512295846, 1, '2017-12-03 10:10:46'),
(260, 532, 45, '150000.00', 1, 1, 1512295878, 1, '2017-12-03 10:11:18'),
(261, 535, 3, '15000.00', 1, 1, 1512295906, 1, '2017-12-03 10:11:46'),
(262, 541, 3, '15000.00', 1, 1, 1512295996, 1, '2017-12-03 10:13:16'),
(263, 542, 45, '150000.00', 1, 1, 1512296023, 1, '2017-12-03 10:13:43'),
(264, 545, 6, '10000.00', 4, 1, 1512296148, 1, '2017-12-03 10:15:48'),
(265, 545, 22, '2500.00', 1, 1, 1512296148, 1, '2017-12-03 10:15:48'),
(266, 546, 92, '15000.00', 1, 1, 1512296148, 1, '2017-12-03 10:15:48'),
(268, 569, 45, '150000.00', 1, 1, 1512296698, 1, '2017-12-03 10:24:58'),
(269, 570, 45, '150000.00', 1, 1, 1512296706, 1, '2017-12-03 10:25:06'),
(270, 575, 6, '10000.00', 2, 1, 1512296759, 1, '2017-12-03 10:25:59'),
(272, 597, 6, '10000.00', 3, 1, 1512297150, 1, '2017-12-03 10:32:30'),
(273, 601, 122, '5000.00', 6, 1, 1512297222, 1, '2017-12-03 10:33:42'),
(274, 1, 602, '150000.00', 33, 1, 1512297314, 1, '2017-12-03 10:35:14'),
(278, 608, 122, '5000.00', 4, 1, 1512297461, 1, '2017-12-03 10:37:41'),
(279, 608, 122, '5000.00', 196, 1, 1512297461, 1, '2017-12-03 10:37:41'),
(280, 611, 6, '10000.00', 2, 1, 1512297512, 1, '2017-12-03 10:38:32'),
(281, 611, 9, '2000.00', 1, 1, 1512297512, 1, '2017-12-03 10:38:32'),
(282, 1, 602, '150000.00', 33, 1, 1512297658, 1, '2017-12-03 10:40:58'),
(283, 623, 73, '70000.00', 2, 1, 1512297726, 1, '2017-12-03 10:42:06'),
(284, 624, 6, '10000.00', 4, 1, 1512297778, 1, '2017-12-03 10:42:58'),
(285, 626, 19, '10000.00', 8, 1, 1512297818, 1, '2017-12-03 10:43:38'),
(286, 628, 83, '60000.00', 2, 1, 1512297822, 1, '2017-12-03 10:43:42'),
(287, 628, 19, '10000.00', 1, 1, 1512297822, 1, '2017-12-03 10:43:42'),
(288, 632, 6, '10000.00', 7, 1, 1512297927, 1, '2017-12-03 10:45:27'),
(289, 635, 83, '60000.00', 1, 1, 1512297956, 1, '2017-12-03 10:45:56'),
(290, 638, 19, '10000.00', 15, 1, 1512298009, 1, '2017-12-03 10:46:49'),
(291, 643, 6, '10000.00', 12, 1, 1512298109, 1, '2017-12-03 10:48:29'),
(292, 647, 7, '5000.00', 2, 1, 1512298168, 1, '2017-12-03 10:49:28'),
(293, 658, 123, '5000.00', 1, 1, 1512298353, 1, '2017-12-03 10:52:33'),
(294, 658, 122, '5000.00', 2, 1, 1512298353, 1, '2017-12-03 10:52:33'),
(296, 661, 3, '15000.00', 9, 1, 1512298388, 1, '2017-12-03 10:53:08'),
(297, 664, 2, '25000.00', 1, 1, 1512298531, 1, '2017-12-03 10:55:31'),
(298, 666, 107, '5000.00', 60, 1, 1512298546, 1, '2017-12-03 10:55:46'),
(299, 669, 83, '60000.00', 1, 1, 1512298689, 1, '2017-12-03 10:58:09'),
(300, 669, 125, '150000.00', 2, 1, 1512298689, 1, '2017-12-03 10:58:09'),
(301, 669, 19, '10000.00', 2, 1, 1512298689, 1, '2017-12-03 10:58:09'),
(302, 680, 2, '25000.00', 1, 1, 1512299157, 1, '2017-12-03 11:05:57'),
(303, 697, 32, '300000.00', 1, 1, 1512299640, 1, '2017-12-03 11:14:00'),
(304, 697, 19, '10000.00', 3, 1, 1512299640, 1, '2017-12-03 11:14:00'),
(305, 697, 129, '15000.00', 8, 1, 1512299640, 1, '2017-12-03 11:14:00'),
(306, 1, 699, '15000.00', 3, 1, 1512299770, 1, '2017-12-03 11:16:10'),
(307, 708, 3, '15000.00', 6, 1, 1512299882, 1, '2017-12-03 11:18:02'),
(308, 708, 5, '1000.00', 8, 1, 1512299882, 1, '2017-12-03 11:18:02'),
(309, 715, 107, '5000.00', 120, 1, 1512300000, 1, '2017-12-03 11:20:00'),
(310, 715, 129, '15000.00', 5, 1, 1512300000, 1, '2017-12-03 11:20:00'),
(311, 721, 90, '35000.00', 1, 1, 1512300115, 1, '2017-12-03 11:21:55'),
(312, 724, 6, '10000.00', 116, 1, 1512300182, 1, '2017-12-03 11:23:02'),
(313, 724, 29, '20000.00', 1, 1, 1512300182, 1, '2017-12-03 11:23:02'),
(314, 724, 3, '15000.00', 6, 1, 1512300182, 1, '2017-12-03 11:23:02'),
(315, 724, 5, '1000.00', 14, 1, 1512300182, 1, '2017-12-03 11:23:02'),
(316, 732, 122, '5000.00', 7, 1, 1512300399, 1, '2017-12-03 11:26:39'),
(317, 732, 83, '60000.00', 6, 1, 1512300399, 1, '2017-12-03 11:26:39'),
(318, 732, 84, '15000.00', 4, 1, 1512300399, 1, '2017-12-03 11:26:39'),
(319, 734, 83, '60000.00', 1, 1, 1512300468, 1, '2017-12-03 11:27:48'),
(320, 739, 125, '150000.00', 1, 1, 1512300630, 1, '2017-12-03 11:30:30'),
(321, 741, 122, '5000.00', 5, 1, 1512300637, 1, '2017-12-03 11:30:37'),
(322, 745, 122, '5000.00', 6, 1, 1512300734, 1, '2017-12-03 11:32:14'),
(323, 751, 72, '100000.00', 1, 1, 1512300853, 1, '2017-12-03 11:34:13'),
(325, 767, 83, '60000.00', 2, 1, 1512301362, 1, '2017-12-03 11:42:42'),
(326, 770, 3, '15000.00', 1, 1, 1512301523, 1, '2017-12-03 11:45:23'),
(327, 773, 3, '15000.00', 1, 1, 1512301623, 1, '2017-12-03 11:47:03'),
(328, 776, 6, '10000.00', 5, 1, 1512301711, 1, '2017-12-03 11:48:31'),
(329, 776, 19, '10000.00', 3, 1, 1512301711, 1, '2017-12-03 11:48:31'),
(330, 776, 46, '100000.00', 1, 1, 1512301711, 1, '2017-12-03 11:48:31'),
(331, 776, 33, '150000.00', 1, 1, 1512301711, 1, '2017-12-03 11:48:31'),
(332, 782, 19, '10000.00', 3, 1, 1512301864, 1, '2017-12-03 11:51:04'),
(333, 782, 7, '5000.00', 2, 1, 1512301864, 1, '2017-12-03 11:51:04'),
(334, 782, 77, '100000.00', 1, 1, 1512301864, 1, '2017-12-03 11:51:04'),
(335, 786, 19, '10000.00', 1, 1, 1512301983, 1, '2017-12-03 11:53:03'),
(337, 795, 132, '150000.00', 1, 1, 1512302397, 1, '2017-12-03 11:59:57'),
(338, 795, 45, '150000.00', 1, 1, 1512302397, 1, '2017-12-03 11:59:57'),
(339, 795, 2, '25000.00', 1, 1, 1512302397, 1, '2017-12-03 11:59:57'),
(340, 796, 6, '10000.00', 4, 1, 1512302400, 1, '2017-12-03 12:00:00'),
(341, 796, 45, '150000.00', 1, 1, 1512302400, 1, '2017-12-03 12:00:00'),
(342, 796, 29, '20000.00', 1, 1, 1512302400, 1, '2017-12-03 12:00:00'),
(343, 796, 84, '15000.00', 5, 1, 1512302400, 1, '2017-12-03 12:00:00'),
(344, 796, 19, '10000.00', 3, 1, 1512302400, 1, '2017-12-03 12:00:00'),
(350, 801, 33, '150000.00', 1, 1, 1512302610, 1, '2017-12-03 12:03:30'),
(351, 801, 19, '10000.00', 7, 1, 1512302610, 1, '2017-12-03 12:03:30'),
(352, 801, 85, '10000.00', 1, 1, 1512302610, 1, '2017-12-03 12:03:30'),
(353, 801, 125, '150000.00', 1, 1, 1512302610, 1, '2017-12-03 12:03:30'),
(356, 806, 2, '25000.00', 1, 1, 1512302755, 1, '2017-12-03 12:05:55'),
(357, 808, 46, '100000.00', 1, 1, 1512302798, 1, '2017-12-03 12:06:38'),
(358, 810, 45, '150000.00', 1, 1, 1512302852, 1, '2017-12-03 12:07:32'),
(359, 813, 5, '1000.00', 1, 1, 1512302902, 1, '2017-12-03 12:08:22'),
(360, 816, 77, '100000.00', 2, 1, 1512302982, 1, '2017-12-03 12:09:42'),
(361, 821, 3, '15000.00', 2, 1, 1512303147, 1, '2017-12-03 12:12:27'),
(362, 823, 19, '10000.00', 1, 1, 1512303205, 1, '2017-12-03 12:13:25'),
(363, 824, 46, '100000.00', 1, 1, 1512303297, 1, '2017-12-03 12:14:57'),
(364, 827, 19, '10000.00', 2, 1, 1512303468, 1, '2017-12-03 12:17:48'),
(365, 827, 89, '50000.00', 2, 1, 1512303468, 1, '2017-12-03 12:17:48'),
(366, 830, 19, '10000.00', 1, 1, 1512303615, 1, '2017-12-03 12:20:15'),
(367, 830, 46, '100000.00', 1, 1, 1512303615, 1, '2017-12-03 12:20:15'),
(368, 831, 32, '300000.00', 1, 1, 1512303636, 1, '2017-12-03 12:20:36'),
(369, 844, 81, '80000.00', 7, 1, 1512303868, 1, '2017-12-03 12:24:28'),
(370, 850, 19, '10000.00', 2, 1, 1512303952, 1, '2017-12-03 12:25:52'),
(371, 870, 19, '10000.00', 3, 1, 1512304357, 1, '2017-12-03 12:32:37'),
(372, 870, 83, '60000.00', 2, 1, 1512304357, 1, '2017-12-03 12:32:37'),
(373, 870, 6, '10000.00', 1, 1, 1512304357, 1, '2017-12-03 12:32:37'),
(374, 876, 83, '60000.00', 3, 1, 1512304552, 1, '2017-12-03 12:35:52'),
(375, 876, 73, '70000.00', 2, 1, 1512304552, 1, '2017-12-03 12:35:52'),
(376, 876, 46, '100000.00', 1, 1, 1512304552, 1, '2017-12-03 12:35:52'),
(377, 876, 6, '10000.00', 3, 1, 1512304552, 1, '2017-12-03 12:35:52'),
(378, 878, 83, '60000.00', 1, 1, 1512304648, 1, '2017-12-03 12:37:28'),
(379, 883, 7, '5000.00', 4, 1, 1512304883, 1, '2017-12-03 12:41:23'),
(380, 883, 55, '20000.00', 9, 1, 1512304883, 1, '2017-12-03 12:41:23'),
(381, 883, 83, '60000.00', 2, 1, 1512304883, 1, '2017-12-03 12:41:23'),
(382, 883, 129, '15000.00', 2, 1, 1512304883, 1, '2017-12-03 12:41:23'),
(383, 883, 3, '15000.00', 1, 1, 1512304883, 1, '2017-12-03 12:41:23'),
(384, 910, 45, '150000.00', 3, 1, 1512305599, 1, '2017-12-03 12:53:19'),
(385, 915, 3, '15000.00', 1, 1, 1512305704, 1, '2017-12-03 12:55:04'),
(386, 917, 2, '25000.00', 1, 1, 1512305735, 1, '2017-12-03 12:55:35'),
(387, 923, 2, '25000.00', 1, 1, 1512305828, 1, '2017-12-03 12:57:08'),
(388, 923, 45, '150000.00', 1, 1, 1512305828, 1, '2017-12-03 12:57:08'),
(389, 926, 45, '150000.00', 1, 1, 1512305896, 1, '2017-12-03 12:58:16'),
(391, 949, 6, '10000.00', 1, 1, 1512306425, 1, '2017-12-03 13:07:05'),
(392, 981, 3, '15000.00', 1, 1, 1512307200, 1, '2017-12-03 13:20:00'),
(393, 989, 83, '60000.00', 1, 1, 1512307460, 1, '2017-12-03 13:24:20'),
(394, 991, 83, '60000.00', 12, 1, 1512307593, 1, '2017-12-03 13:26:33'),
(395, 1000, 83, '60000.00', 1, 1, 1512308010, 1, '2017-12-03 13:33:30'),
(396, 1001, 73, '70000.00', 1, 1, 1512308013, 1, '2017-12-03 13:33:33'),
(397, 1001, 6, '10000.00', 8, 1, 1512308013, 1, '2017-12-03 13:33:33'),
(398, 1002, 29, '20000.00', 3, 1, 1512308013, 1, '2017-12-03 13:33:33'),
(399, 1003, 6, '10000.00', 10, 1, 1512308071, 1, '2017-12-03 13:34:31'),
(400, 1005, 6, '10000.00', 3, 1, 1512308132, 1, '2017-12-03 13:35:32'),
(401, 1005, 90, '35000.00', 1, 1, 1512308132, 1, '2017-12-03 13:35:32'),
(402, 1039, 83, '60000.00', 2, 1, 1512308751, 1, '2017-12-03 13:45:51'),
(403, 1052, 45, '150000.00', 1, 1, 1512309003, 1, '2017-12-03 13:50:03'),
(404, 1060, 83, '60000.00', 5, 1, 1512309148, 1, '2017-12-03 13:52:28'),
(405, 1068, 123, '5000.00', 2, 1, 1512309352, 1, '2017-12-03 13:55:52'),
(406, 1072, 83, '60000.00', 15, 1, 1512309494, 1, '2017-12-03 13:58:14'),
(407, 1072, 7, '5000.00', 8, 1, 1512309494, 1, '2017-12-03 13:58:14'),
(408, 1084, 83, '60000.00', 2, 1, 1512309869, 1, '2017-12-03 14:04:29'),
(409, 1085, 2, '25000.00', 1, 1, 1512309871, 1, '2017-12-03 14:04:31'),
(410, 1091, 46, '100000.00', 1, 1, 1512310048, 1, '2017-12-03 14:07:28'),
(411, 1092, 123, '5000.00', 2, 1, 1512310103, 1, '2017-12-03 14:08:23'),
(412, 1100, 6, '10000.00', 8, 1, 1512310379, 1, '2017-12-03 14:12:59'),
(413, 1105, 19, '10000.00', 1, 1, 1512310502, 1, '2017-12-03 14:15:02'),
(415, 1, 1073, '150000.00', 45, 1, 1512310675, 1, '2017-12-03 14:17:55'),
(416, 1118, 45, '150000.00', 1, 1, 1512310725, 1, '2017-12-03 14:18:45'),
(417, 1123, 6, '10000.00', 13, 1, 1512310835, 1, '2017-12-03 14:20:35'),
(418, 1124, 81, '80000.00', 1, 1, 1512310850, 1, '2017-12-03 14:20:50'),
(419, 1124, 4, '3000.00', 1, 1, 1512310850, 1, '2017-12-03 14:20:50'),
(420, 1135, 3, '15000.00', 3, 1, 1512311322, 1, '2017-12-03 14:28:42'),
(421, 1139, 45, '150000.00', 1, 1, 1512311597, 1, '2017-12-03 14:33:17'),
(422, 1142, 90, '35000.00', 1, 1, 1512311659, 1, '2017-12-03 14:34:19'),
(423, 1169, 19, '10000.00', 1, 1, 1512312139, 1, '2017-12-03 14:42:19'),
(424, 1170, 90, '35000.00', 1, 1, 1512312156, 1, '2017-12-03 14:42:36'),
(425, 1184, 96, '100000.00', 2, 1, 1512312712, 1, '2017-12-03 14:51:52'),
(426, 1184, 3, '15000.00', 2, 1, 1512312712, 1, '2017-12-03 14:51:52'),
(427, 1184, 5, '1000.00', 4, 1, 1512312712, 1, '2017-12-03 14:51:52'),
(428, 1185, 87, '100000.00', 8, 1, 1512312771, 1, '2017-12-03 14:52:51'),
(429, 1190, 32, '300000.00', 2, 1, 1512312974, 1, '2017-12-03 14:56:14'),
(430, 1196, 19, '10000.00', 6, 1, 1512313123, 1, '2017-12-03 14:58:43'),
(431, 1196, 123, '5000.00', 3, 1, 1512313123, 1, '2017-12-03 14:58:43'),
(434, 1202, 32, '300000.00', 1, 1, 1512313249, 1, '2017-12-03 15:00:49'),
(435, 1205, 32, '300000.00', 1, 1, 1512313421, 1, '2017-12-03 15:03:41'),
(436, 1205, 19, '10000.00', 8, 1, 1512313421, 1, '2017-12-03 15:03:41'),
(437, 1213, 2, '25000.00', 2, 1, 1512313537, 1, '2017-12-03 15:05:37'),
(438, 1218, 6, '10000.00', 1, 1, 1512313668, 1, '2017-12-03 15:07:48'),
(439, 1220, 32, '300000.00', 1, 1, 1512313744, 1, '2017-12-03 15:09:04'),
(440, 1220, 125, '150000.00', 2, 1, 1512313744, 1, '2017-12-03 15:09:04'),
(441, 1220, 19, '10000.00', 8, 1, 1512313744, 1, '2017-12-03 15:09:04'),
(442, 1225, 6, '10000.00', 3, 1, 1512313884, 1, '2017-12-03 15:11:24'),
(443, 1233, 32, '300000.00', 1, 1, 1512314055, 1, '2017-12-03 15:14:15'),
(444, 1238, 71, '150000.00', 1, 1, 1512314129, 1, '2017-12-03 15:15:29'),
(445, 1238, 19, '10000.00', 1, 1, 1512314129, 1, '2017-12-03 15:15:29'),
(446, 1239, 6, '10000.00', 3, 1, 1512314133, 1, '2017-12-03 15:15:33'),
(447, 1241, 81, '80000.00', 1, 1, 1512314226, 1, '2017-12-03 15:17:06'),
(448, 1243, 19, '10000.00', 1, 1, 1512314278, 1, '2017-12-03 15:17:58'),
(449, 1245, 125, '150000.00', 1, 1, 1512314362, 1, '2017-12-03 15:19:22'),
(450, 1256, 6, '10000.00', 3, 1, 1512314639, 1, '2017-12-03 15:23:59'),
(451, 1259, 19, '10000.00', 1, 1, 1512314733, 1, '2017-12-03 15:25:33'),
(452, 1263, 118, '4000.00', 20, 1, 1512314806, 1, '2017-12-03 15:26:46'),
(453, 1275, 6, '10000.00', 4, 1, 1512315084, 1, '2017-12-03 15:31:24'),
(454, 1300, 117, '2000.00', 20, 1, 1512315888, 1, '2017-12-03 15:44:48'),
(455, 1314, 77, '100000.00', 3, 1, 1512316653, 1, '2017-12-03 15:57:33'),
(456, 1314, 3, '15000.00', 3, 1, 1512316653, 1, '2017-12-03 15:57:33'),
(457, 1314, 73, '70000.00', 1, 1, 1512316653, 1, '2017-12-03 15:57:33'),
(460, 1326, 3, '15000.00', 1, 1, 1512317379, 1, '2017-12-03 16:09:39'),
(461, 1331, 3, '15000.00', 2, 1, 1512317479, 1, '2017-12-03 16:11:19'),
(462, 1331, 83, '60000.00', 1, 1, 1512317479, 1, '2017-12-03 16:11:19'),
(463, 1333, 45, '150000.00', 1, 1, 1512317526, 1, '2017-12-03 16:12:06'),
(464, 1334, 45, '150000.00', 1, 1, 1512317527, 1, '2017-12-03 16:12:07'),
(465, 1337, 5, '1000.00', 1, 1, 1512317581, 1, '2017-12-03 16:13:01'),
(466, 1344, 3, '15000.00', 1, 1, 1512317764, 1, '2017-12-03 16:16:04'),
(467, 1346, 85, '10000.00', 1, 1, 1512317825, 1, '2017-12-03 16:17:05'),
(468, 1356, 90, '35000.00', 1, 1, 1512318107, 1, '2017-12-03 16:21:47'),
(471, 1374, 9, '2000.00', 5, 1, 1512318439, 1, '2017-12-03 16:27:19'),
(472, 1374, 19, '10000.00', 1, 1, 1512318439, 1, '2017-12-03 16:27:19'),
(473, 1382, 85, '10000.00', 1, 1, 1512318629, 1, '2017-12-03 16:30:29'),
(474, 1388, 77, '100000.00', 2, 1, 1512318913, 1, '2017-12-03 16:35:13'),
(475, 1395, 3, '15000.00', 1, 1, 1512319127, 1, '2017-12-03 16:38:47'),
(476, 1397, 19, '10000.00', 1, 1, 1512319159, 1, '2017-12-03 16:39:19'),
(477, 1397, 5, '1000.00', 1, 1, 1512319159, 1, '2017-12-03 16:39:19'),
(481, 1606, 45, '150000.00', 1, 1, 1512566861, 1, '2017-12-06 13:27:41'),
(482, 1606, 257, '5000.00', 1, 1, 1512566861, 1, '2017-12-06 13:27:41'),
(483, 1607, 19, '10000.00', 1, 1, 1512567013, 1, '2017-12-06 13:30:13'),
(486, 1611, 19, '10000.00', 1, 1, 1512629948, 1, '2017-12-07 06:59:08'),
(487, 1612, 3, '15000.00', 1, 1, 1512630105, 1, '2017-12-07 07:01:45'),
(488, 1612, 19, '10000.00', 8, 1, 1512630105, 1, '2017-12-07 07:01:45'),
(489, 1, 14, '2000.00', 14, 1, 1512632775, 1, '2017-12-07 07:46:15'),
(490, 1613, 19, '10000.00', 5, 1, 1512635283, 1, '2017-12-07 08:28:03'),
(491, 1614, 83, '60000.00', 2, 1, 1512635721, 1, '2017-12-07 08:35:21'),
(492, 1614, 19, '10000.00', 3, 1, 1512635721, 1, '2017-12-07 08:35:21'),
(497, 1617, 19, '10000.00', 3, 1, 1512637314, 1, '2017-12-07 09:01:54'),
(498, 1617, 6, '10000.00', 1, 1, 1512637314, 1, '2017-12-07 09:01:54'),
(499, 1618, 3, '15000.00', 3, 1, 1512637544, 1, '2017-12-07 09:05:44'),
(500, 1619, 257, '5000.00', 1, 1, 1512637804, 1, '2017-12-07 09:10:04'),
(501, 1620, 45, '150000.00', 1, 1, 1512638131, 1, '2017-12-07 09:15:31'),
(502, 1621, 75, '350000.00', 1, 1, 1512638942, 1, '2017-12-07 09:29:02'),
(503, 1622, 5, '1000.00', 1, 1, 1512639488, 1, '2017-12-07 09:38:08'),
(504, 1622, 77, '100000.00', 1, 1, 1512639488, 1, '2017-12-07 09:38:08'),
(507, 1, 14, '1000.00', 23, 1, 1512649953, 1, '2017-12-07 12:32:33'),
(508, 1, 14, '1000.00', 23, 1, 1512650009, 1, '2017-12-07 12:33:29'),
(509, 2, 14, '15000.00', 129, 1, 1512733126, 1, '2017-12-08 11:38:46'),
(511, 1615, 19, '10000.00', 1, 1, 1512824252, 1, '2017-12-09 12:57:32'),
(512, 1615, 3, '15000.00', 1, 1, 1512824252, 1, '2017-12-09 12:57:32'),
(513, 1372, 6, '10000.00', 2, 1, 1512826157, 1, '2017-12-09 13:29:17'),
(514, 1113, 83, '60000.00', 1, 1, 1512826942, 1, '2017-12-09 13:42:22'),
(515, 123, 1, '5000.00', 1626, 1, 1513074102, 1, '2017-12-12 10:21:42'),
(516, 48, 1, '150000.00', 1626, 1, 1513074102, 1, '2017-12-12 10:21:42'),
(517, 162, 6, '10000.00', 7, 1, 1513075866, 1, '2017-12-12 10:51:06'),
(518, 45, 1, '150000.00', 1632, 1, 1513076006, 1, '2017-12-12 10:53:26'),
(521, 1200, 107, '5000.00', 100, 1, 1513077480, 1, '2017-12-12 11:18:00'),
(522, 1200, 32, '300000.00', 2, 1, 1513077480, 1, '2017-12-12 11:18:00'),
(523, 350, 46, '100000.00', 1, 1, 1513078951, 1, '2017-12-12 11:42:31'),
(524, 350, 108, '3000.00', 4, 1, 1513078951, 1, '2017-12-12 11:42:31'),
(525, 84, 1, '15000.00', 1642, 1, 1513079428, 1, '2017-12-12 11:50:28'),
(526, 6, 2, '10000.00', 1655, 1, 1513082501, 1, '2017-12-12 12:41:41'),
(527, 5, 2, '1000.00', 1656, 1, 1513082670, 1, '2017-12-12 12:44:30'),
(528, 257, 1, '5000.00', 1657, 1, 1513082957, 1, '2017-12-12 12:49:17'),
(529, 45, 1, '150000.00', 1658, 1, 1513090267, 1, '2017-12-12 14:51:07'),
(530, 257, 1, '5000.00', 1658, 1, 1513090267, 1, '2017-12-12 14:51:07'),
(531, 5, 2, '1000.00', 1659, 1, 1513091141, 1, '2017-12-12 15:05:41'),
(532, 5, 2, '1000.00', 1660, 1, 1513091148, 1, '2017-12-12 15:05:48'),
(533, 5, 2, '1000.00', 1661, 1, 1513091153, 1, '2017-12-12 15:05:53'),
(534, 257, 1, '5000.00', 1662, 1, 1513091894, 1, '2017-12-12 15:18:14'),
(536, 5, 1, '1000.00', 1663, 1, 1513092592, 1, '2017-12-12 15:29:52'),
(537, 6, 1, '10000.00', 1664, 1, 1513146445, 1, '2017-12-13 06:27:25'),
(538, 6, 1, '10000.00', 1665, 1, 1513146756, 1, '2017-12-13 06:32:36'),
(539, 45, 1, '150000.00', 1666, 1, 1513147310, 1, '2017-12-13 06:41:50'),
(540, 84, 1, '15000.00', 1666, 1, 1513147310, 1, '2017-12-13 06:41:50'),
(542, 6, 1, '10000.00', 1667, 1, 1513147802, 1, '2017-12-13 06:50:02'),
(544, 6, 1, '10000.00', 1668, 1, 1513147808, 1, '2017-12-13 06:50:08'),
(546, 6, 1, '10000.00', 1669, 1, 1513147809, 1, '2017-12-13 06:50:09'),
(548, 6, 1, '10000.00', 1670, 1, 1513147809, 1, '2017-12-13 06:50:09'),
(549, 257, 4, '5000.00', 1671, 1, 1513148308, 1, '2017-12-13 06:58:28'),
(550, 84, 1, '15000.00', 1672, 1, 1513148805, 1, '2017-12-13 07:06:45'),
(551, 87, 1, '100000.00', 1673, 1, 1513149387, 1, '2017-12-13 07:16:27'),
(552, 87, 1, '100000.00', 1674, 1, 1513149387, 1, '2017-12-13 07:16:27'),
(554, 134, 1, '80000.00', 1677, 1, 1513150243, 1, '2017-12-13 07:30:43'),
(555, 134, 1, '80000.00', 1678, 1, 1513150244, 1, '2017-12-13 07:30:44'),
(556, 134, 1, '80000.00', 1679, 1, 1513150248, 1, '2017-12-13 07:30:48'),
(557, 257, 1, '5000.00', 1680, 1, 1513150825, 1, '2017-12-13 07:40:25'),
(559, 3, 1, '15000.00', 1680, 1, 1513150825, 1, '2017-12-13 07:40:25'),
(560, 75, 1, '350000.00', 1680, 1, 1513150825, 1, '2017-12-13 07:40:25'),
(561, 3, 1, '15000.00', 1681, 1, 1513151938, 1, '2017-12-13 07:58:58'),
(563, 257, 1, '5000.00', 1683, 1, 1513152152, 1, '2017-12-13 08:02:32'),
(564, 6, 12, '10000.00', 1684, 1, 1513152561, 1, '2017-12-13 08:09:21'),
(565, 14, 23, '1000.00', 1, 1, 1513153234, 1, '2017-12-13 08:20:34'),
(566, 85, 3, '15000.00', 1685, 1, 1513153330, 1, '2017-12-13 14:59:28'),
(567, 85, 3, '10000.00', 1686, 1, 1513153333, 1, '2017-12-13 08:22:13'),
(568, 83, 1, '60000.00', 1687, 1, 1513154531, 1, '2017-12-13 08:42:11'),
(569, 84, 2, '15000.00', 1688, 1, 1513155125, 1, '2017-12-13 08:52:05'),
(570, 6, 3, '10000.00', 1688, 1, 1513155125, 1, '2017-12-13 08:52:05'),
(572, 5, 1, '1000.00', 1688, 1, 1513155125, 1, '2017-12-13 08:52:05'),
(573, 125, 6, '150000.00', 1688, 1, 1513155125, 1, '2017-12-13 08:52:05'),
(574, 1688, 83, '60000.00', 2, 1, 1513157573, 1, '2017-12-13 09:32:53'),
(575, 1688, 6, '10000.00', 3, 1, 1513157573, 1, '2017-12-13 09:32:53'),
(576, 1688, 19, '10000.00', 1, 1, 1513157573, 1, '2017-12-13 09:32:53'),
(577, 1688, 5, '1000.00', 1, 1, 1513157573, 1, '2017-12-13 09:32:53'),
(578, 1688, 125, '150000.00', 6, 1, 1513157573, 1, '2017-12-13 09:32:53'),
(579, 1680, 257, '5000.00', 1, 1, 1513158095, 1, '2017-12-13 09:41:35'),
(580, 1680, 19, '10000.00', 1, 1, 1513158095, 1, '2017-12-13 09:41:35'),
(581, 1680, 75, '350000.00', 1, 1, 1513158095, 1, '2017-12-13 09:41:35'),
(582, 1680, 78, '80000.00', 1, 1, 1513158095, 1, '2017-12-13 09:41:35'),
(583, 1681, 5, '1000.00', 1, 1, 1513158213, 1, '2017-12-13 09:43:33'),
(584, 30, 1, '10000.00', 1689, 1, 1513158463, 1, '2017-12-13 09:47:43'),
(585, 258, 1, '100000.00', 1689, 1, 1513158463, 1, '2017-12-13 09:47:43'),
(586, 45, 1, '150000.00', 1689, 1, 1513158463, 1, '2017-12-13 09:47:43'),
(587, 123, 1, '5000.00', 1690, 1, 1513158613, 1, '2017-12-13 09:50:13'),
(588, 6, 2, '10000.00', 1690, 1, 1513158613, 1, '2017-12-13 09:50:13'),
(589, 123, 1, '5000.00', 1691, 1, 1513158615, 1, '2017-12-13 09:50:15'),
(590, 6, 2, '10000.00', 1691, 1, 1513158615, 1, '2017-12-13 09:50:15'),
(591, 77, 1, '100000.00', 1692, 1, 1513158875, 1, '2017-12-13 09:54:35'),
(592, 45, 3, '150000.00', 1693, 1, 1513159038, 1, '2017-12-13 09:57:18'),
(593, 32, 1, '300000.00', 1693, 1, 1513159038, 1, '2017-12-13 09:57:18'),
(594, 5, 1, '1000.00', 1694, 1, 1513159255, 1, '2017-12-13 10:00:55'),
(595, 3, 1, '15000.00', 1694, 1, 1513159255, 1, '2017-12-13 10:00:55'),
(596, 46, 1, '100000.00', 1695, 1, 1513160487, 1, '2017-12-13 10:21:27'),
(597, 257, 1, '5000.00', 1695, 1, 1513160487, 1, '2017-12-13 10:21:27'),
(598, 6, 6, '10000.00', 1695, 1, 1513160487, 1, '2017-12-13 10:21:27'),
(599, 184, 9, '2000.00', 1, 1, 1513162839, 1, '2017-12-13 11:00:39'),
(600, 379, 76, '150000.00', 1, 1, 1513162955, 1, '2017-12-13 11:02:35'),
(601, 3, 1, '15000.00', 1698, 1, 1513164324, 1, '2017-12-13 11:25:24'),
(602, 659, 2, '25000.00', 1, 1, 1513166043, 1, '2017-12-13 11:54:03'),
(603, 272, 1, '5000.00', 1701, 1, 1513170707, 1, '2017-12-13 13:11:47'),
(605, 140, 2, '1000.00', 1706, 1, 1513171330, 1, '2017-12-13 13:22:10'),
(606, 232, 1, '150000.00', 1711, 1, 1513171707, 1, '2017-12-13 13:28:27'),
(607, 187, 1, '70000.00', 1711, 1, 1513171707, 1, '2017-12-13 13:28:27'),
(608, 171, 1, '150000.00', 1712, 1, 1513171781, 1, '2017-12-13 13:29:41'),
(609, 158, 1, '20000.00', 1726, 1, 1513173319, 1, '2017-12-13 13:55:19'),
(613, 171, 1, '150000.00', 1727, 1, 1513173670, 1, '2017-12-13 14:01:10'),
(614, 230, 30, '5000.00', 1728, 1, 1513173788, 1, '2017-12-13 14:03:08'),
(615, 197, 25, '120000.00', 5, 1, 1513174788, 1, '2017-12-13 14:19:48'),
(618, 760, 46, '100000.00', 1, 1, 1513176684, 1, '2017-12-13 14:51:24'),
(620, 931, 7, '5000.00', 10, 1, 1513177495, 1, '2017-12-13 15:04:55'),
(621, 798, 6, '10000.00', 1, 1, 1513181128, 1, '2017-12-13 16:05:28'),
(622, 798, 257, '5000.00', 1, 1, 1513181128, 1, '2017-12-13 16:05:28'),
(623, 805, 95, '300000.00', 30, 1, 1513192195, 1, '2017-12-13 19:09:55'),
(624, 805, 2, '25000.00', 7, 1, 1513192195, 1, '2017-12-13 19:09:55'),
(626, 980, 257, '5000.00', 4, 1, 1513233008, 1, '2017-12-14 06:30:08'),
(627, 1528, 95, '300000.00', 1, 1, 1513233206, 1, '2017-12-14 06:33:26'),
(628, 1528, 257, '5000.00', 1, 1, 1513233206, 1, '2017-12-14 06:33:26'),
(629, 887, 257, '5000.00', 1, 1, 1513233311, 1, '2017-12-14 06:35:11'),
(631, 1529, 257, '5000.00', 1, 1, 1513233401, 1, '2017-12-14 06:36:41'),
(632, 1532, 96, '100000.00', 1, 1, 1513233614, 1, '2017-12-14 06:40:14'),
(633, 1532, 257, '5000.00', 1, 1, 1513233614, 1, '2017-12-14 06:40:14'),
(634, 1536, 6, '10000.00', 3, 1, 1513234020, 1, '2017-12-14 06:47:00'),
(635, 1536, 129, '15000.00', 1, 1, 1513234020, 1, '2017-12-14 06:47:00'),
(636, 1536, 5, '1000.00', 1, 1, 1513234020, 1, '2017-12-14 06:47:00'),
(637, 1536, 257, '5000.00', 1, 1, 1513234020, 1, '2017-12-14 06:47:00'),
(638, 1537, 257, '5000.00', 1, 1, 1513235342, 1, '2017-12-14 07:09:02'),
(639, 1539, 84, '15000.00', 1, 1, 1513236100, 1, '2017-12-14 07:21:40'),
(641, 1542, 92, '15000.00', 2, 1, 1513236472, 1, '2017-12-14 07:27:52'),
(642, 1523, 3, '15000.00', 2, 1, 1513236720, 1, '2017-12-14 07:32:00'),
(643, 1523, 256, '5000.00', 2, 1, 1513236720, 1, '2017-12-14 07:32:00'),
(647, 1560, 257, '5000.00', 1, 1, 1513237149, 1, '2017-12-14 07:39:09'),
(648, 1568, 95, '300000.00', 5, 1, 1513237352, 1, '2017-12-14 07:42:32'),
(649, 1568, 2, '25000.00', 1, 1, 1513237352, 1, '2017-12-14 07:42:32'),
(650, 1579, 125, '150000.00', 2, 1, 1513237654, 1, '2017-12-14 07:47:34'),
(651, 1585, 19, '10000.00', 4, 1, 1513237788, 1, '2017-12-14 07:49:48'),
(652, 1588, 32, '300000.00', 1, 1, 1513238989, 1, '2017-12-14 08:09:49'),
(653, 1588, 19, '10000.00', 1, 1, 1513238989, 1, '2017-12-14 08:09:49'),
(654, 1589, 6, '10000.00', 4, 1, 1513239312, 1, '2017-12-14 08:15:12'),
(655, 1589, 19, '10000.00', 6, 1, 1513239312, 1, '2017-12-14 08:15:12'),
(658, 1590, 3, '15000.00', 3, 1, 1513239611, 1, '2017-12-14 08:20:11'),
(659, 1590, 83, '60000.00', 2, 1, 1513239611, 1, '2017-12-14 08:20:11'),
(660, 1591, 6, '10000.00', 2, 1, 1513240017, 1, '2017-12-14 08:26:57'),
(661, 1591, 256, '5000.00', 1, 1, 1513240017, 1, '2017-12-14 08:26:57'),
(662, 1591, 19, '10000.00', 3, 1, 1513240017, 1, '2017-12-14 08:26:57'),
(663, 1592, 257, '5000.00', 1, 1, 1513244064, 1, '2017-12-14 09:34:24'),
(670, 12, 1, '100000.00', 1729, 1, 1513244418, 1, '2017-12-14 09:40:18'),
(671, 19, 9, '10000.00', 1729, 1, 1513244418, 1, '2017-12-14 09:40:18'),
(674, 1729, 11, '200000.00', 1, 1, 1513244496, 1, '2017-12-14 09:41:36'),
(675, 1729, 19, '10000.00', 9, 1, 1513244496, 1, '2017-12-14 09:41:36'),
(676, 1595, 19, '10000.00', 1, 1, 1513244669, 1, '2017-12-14 09:44:29'),
(677, 1595, 257, '5000.00', 1, 1, 1513244669, 1, '2017-12-14 09:44:29'),
(678, 1597, 19, '10000.00', 2, 1, 1513244759, 1, '2017-12-14 09:45:59'),
(679, 1598, 19, '10000.00', 2, 1, 1513244869, 1, '2017-12-14 09:47:49'),
(680, 1599, 257, '5000.00', 1, 1, 1513244950, 1, '2017-12-14 09:49:10'),
(681, 1600, 96, '100000.00', 1, 1, 1513245217, 1, '2017-12-14 09:53:37'),
(682, 1600, 257, '5000.00', 1, 1, 1513245217, 1, '2017-12-14 09:53:37'),
(684, 1601, 19, '10000.00', 1, 1, 1513245367, 1, '2017-12-14 09:56:07'),
(685, 1603, 257, '5000.00', 1, 1, 1513245443, 1, '2017-12-14 09:57:23'),
(686, 1322, 257, '5000.00', 1, 1, 1513245619, 1, '2017-12-14 10:00:19'),
(690, 1324, 6, '10000.00', 8, 1, 1513245700, 1, '2017-12-14 10:01:40'),
(691, 1324, 3, '15000.00', 2, 1, 1513245700, 1, '2017-12-14 10:01:40'),
(692, 1324, 257, '5000.00', 1, 1, 1513245700, 1, '2017-12-14 10:01:40'),
(693, 1380, 257, '5000.00', 1, 1, 1513245920, 1, '2017-12-14 10:05:20'),
(694, 1383, 257, '5000.00', 1, 1, 1513246031, 1, '2017-12-14 10:07:11'),
(695, 1392, 257, '5000.00', 1, 1, 1513246167, 1, '2017-12-14 10:09:27'),
(696, 1125, 257, '5000.00', 1, 1, 1513246230, 1, '2017-12-14 10:10:30'),
(697, 497, 257, '5000.00', 1, 1, 1513246300, 1, '2017-12-14 10:11:40'),
(698, 549, 257, '5000.00', 2, 1, 1513246400, 1, '2017-12-14 10:13:20'),
(699, 560, 257, '5000.00', 1, 1, 1513246490, 1, '2017-12-14 10:14:50'),
(700, 577, 257, '5000.00', 1, 1, 1513246565, 1, '2017-12-14 10:16:05'),
(702, 838, 257, '5000.00', 1, 1, 1513246736, 1, '2017-12-14 10:18:56'),
(703, 793, 74, '30000.00', 1, 1, 1513247441, 1, '2017-12-14 10:30:41'),
(704, 793, 257, '5000.00', 1, 1, 1513247441, 1, '2017-12-14 10:30:41'),
(705, 793, 19, '10000.00', 1, 1, 1513247441, 1, '2017-12-14 10:30:41'),
(706, 66, 118, '4000.00', 2, 1, 1513249769, 1, '2017-12-14 11:09:29'),
(707, 76, 32, '300000.00', 1, 1, 1513249792, 1, '2017-12-14 11:09:52'),
(709, 107, 32, '300000.00', 1, 1, 1513249878, 1, '2017-12-14 11:11:18'),
(710, 114, 32, '300000.00', 1, 1, 1513249918, 1, '2017-12-14 11:11:58'),
(711, 99, 32, '300000.00', 1, 1, 1513249939, 1, '2017-12-14 11:12:19'),
(712, 119, 37, '150000.00', 1, 1, 1513250098, 1, '2017-12-14 11:14:58'),
(713, 105, 2, '25000.00', 1, 1, 1513251266, 1, '2017-12-14 11:34:26'),
(714, 147, 75, '350000.00', 1, 1, 1513251405, 1, '2017-12-14 11:36:45'),
(715, 605, 75, '350000.00', 1, 1, 1513251432, 1, '2017-12-14 11:37:12'),
(717, 592, 124, '20000.00', 5, 1, 1513251478, 1, '2017-12-14 11:37:58'),
(718, 557, 6, '10000.00', 2, 1, 1513251523, 1, '2017-12-14 11:38:43'),
(719, 442, 6, '10000.00', 2, 1, 1513251550, 1, '2017-12-14 11:39:10'),
(720, 832, 261, '15000.00', 3, 1, 1513254584, 1, '2017-12-14 12:29:44'),
(721, 854, 122, '5000.00', 5, 1, 1513254932, 1, '2017-12-14 12:35:32'),
(722, 863, 122, '5000.00', 1, 1, 1513255243, 1, '2017-12-14 12:40:43'),
(723, 999, 257, '5000.00', 1, 1, 1513260471, 1, '2017-12-14 14:07:51'),
(724, 1086, 126, '200000.00', 1, 1, 1513261365, 1, '2017-12-14 14:22:45'),
(725, 1126, 272, '5000.00', 1, 1, 1513261664, 1, '2017-12-14 14:27:44'),
(726, 1126, 229, '5000.00', 1, 1, 1513261664, 1, '2017-12-14 14:27:44'),
(727, 1371, 2, '25000.00', 3, 1, 1513267594, 1, '2017-12-14 16:06:34'),
(728, 1306, 141, '10000.00', 23, 1, 1513267808, 1, '2017-12-14 16:10:08'),
(729, 1308, 272, '5000.00', 1, 1, 1513267931, 1, '2017-12-14 16:12:11'),
(730, 1309, 229, '5000.00', 1, 1, 1513268022, 1, '2017-12-14 16:13:42'),
(731, 1310, 229, '5000.00', 1, 1, 1513268076, 1, '2017-12-14 16:14:36'),
(732, 1451, 253, '80000.00', 1, 1, 1513268731, 1, '2017-12-14 16:25:31'),
(733, 1451, 254, '100000.00', 1, 1, 1513268731, 1, '2017-12-14 16:25:31'),
(734, 1284, 312, '50000.00', 1, 1, 1513268923, 1, '2017-12-14 16:28:43'),
(735, 1141, 45, '150000.00', 1, 1, 1513269113, 1, '2017-12-14 16:31:53'),
(736, 1141, 51, '20000.00', 1, 1, 1513269113, 1, '2017-12-14 16:31:53'),
(737, 841, 32, '300000.00', 2, 1, 1513269473, 1, '2017-12-14 16:37:53'),
(738, 841, 275, '30000.00', 1, 1, 1513269473, 1, '2017-12-14 16:37:53'),
(739, 841, 96, '100000.00', 1, 1, 1513269473, 1, '2017-12-14 16:37:53');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pap_improvement`
--

CREATE TABLE `tbl_pap_improvement` (
  `id` int(11) NOT NULL,
  `pap_id` int(11) NOT NULL,
  `district_property_rate_id` int(11) NOT NULL,
  `rate` decimal(12,2) NOT NULL,
  `quantity` decimal(10,3) NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_created` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_pap_improvement`
--

INSERT INTO `tbl_pap_improvement` (`id`, `pap_id`, `district_property_rate_id`, `rate`, `quantity`, `created_by`, `date_created`, `modified_by`, `date_modified`) VALUES
(20, 17, 55, '15000.00', '13.000', 1, 1512151773, 1, '2017-12-01 18:09:33'),
(21, 20, 2, '150000.00', '14.000', 1, 1512209505, 1, '2017-12-02 10:11:45'),
(23, 20, 13, '150000.00', '15.000', 1, 1512211836, 1, '2017-12-02 10:50:36'),
(24, 15, 60, '6000.00', '244.000', 1, 1512227921, 1, '2017-12-02 15:18:41'),
(27, 17, 60, '15000.00', '1100.000', 1, 1512310379, 1, '2017-12-03 14:12:59'),
(29, 27, 15, '6000.00', '0.850', 1, 1512632052, 1, '2017-12-13 09:54:44'),
(32, 16, 20, '150000.00', '6.640', 1, 1513072671, 1, '2017-12-13 08:19:45'),
(33, 14, 20, '150000.00', '1.850', 1, 1513153234, 1, '2017-12-13 08:20:34'),
(34, 888, 29, '50000.00', '30.000', 1, 1513257224, 1, '2017-12-14 13:13:44'),
(35, 891, 31, '150000.00', '30.000', 1, 1513257857, 1, '2017-12-14 13:24:17'),
(36, 902, 31, '150000.00', '4.000', 1, 1513258263, 1, '2017-12-14 13:31:03');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pap_photos`
--

CREATE TABLE `tbl_pap_photos` (
  `id` int(11) NOT NULL,
  `pap_id` int(11) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `description` varchar(150) NOT NULL,
  `date_created` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Photos for each class';

-- --------------------------------------------------------

--
-- Table structure for table `tbl_parish`
--

CREATE TABLE `tbl_parish` (
  `id` int(10) UNSIGNED NOT NULL,
  `parish_name` varchar(50) NOT NULL,
  `subcounty` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Districts in Uganda';

--
-- Dumping data for table `tbl_parish`
--

INSERT INTO `tbl_parish` (`id`, `parish_name`, `subcounty`, `active`) VALUES
(6, 'BUKAYE ', 5, 1),
(7, 'BUKUMANKOOLA', 6, 1),
(8, 'LUMBUYE', 6, 1),
(9, 'NKONO', 1, 1),
(10, 'KIDAAGO NABITENDE', 2, 1),
(11, 'BUTEGE', 8, 1),
(12, 'NAIGOMBYA', 0, 1),
(13, 'NAMUNGALWE', 3, 1),
(14, 'NAMUNKESU', 3, 1),
(15, 'MAGOGO', 5, 1),
(16, 'NASUTI', 2, 1),
(17, 'BULUMWAKI', 3, 1),
(18, 'NAMUNSALA', 3, 1),
(19, 'BUNYIRO', 9, 1),
(20, 'BUYUNGA', 6, 1),
(21, 'MWENDE-NFUKO', 3, 1),
(22, 'NAIBIRI', 2, 1),
(23, 'MAYIRA', 2, 1),
(24, 'NAIGOMBYA', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_coverage`
--

CREATE TABLE `tbl_project_coverage` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_created` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_project_coverage`
--

INSERT INTO `tbl_project_coverage` (`id`, `project_id`, `district_id`, `created_by`, `date_created`, `modified_by`, `date_modified`) VALUES
(13, 7, 33, 1, 1511953645, 1, '2017-11-29 11:07:25'),
(14, 7, 41, 1, 1511953645, 1, '2017-11-29 11:07:25'),
(15, 9, 24, 1, 1513259961, 1, '2017-12-14 13:59:21'),
(16, 8, 48, 1, 1513260130, 1, '2017-12-14 14:02:10');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_property_description`
--

CREATE TABLE `tbl_property_description` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_property_description`
--

INSERT INTO `tbl_property_description` (`id`, `title`, `description`, `active`) VALUES
(8, 'BARBED WIRE ON LOCAL POLES', '', 1),
(9, 'BARBED WIRE ON TREATED POLES', '', 1),
(10, 'BARBED WIRE ON CONCRETE POSTS', '', 1),
(11, 'GCI ROOF, OPEN TIMBER POLES, PARTLY GCI SHEETS WALLS', '', 1),
(12, 'PREFABRICATED MOBILE MONEY KIOSK', '', 1),
(13, 'CEMENT SCREED FLOOR ON SITE CONCRETE', '', 1),
(14, 'CONCRETE', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_property_type`
--

CREATE TABLE `tbl_property_type` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_property_type`
--

INSERT INTO `tbl_property_type` (`id`, `title`, `description`, `active`) VALUES
(12, 'FENCE', '', 1),
(13, 'KIOSK', '', 1),
(14, 'COVERED VERANDAH', '', 1),
(15, 'VERANDAH', '', 1),
(16, 'PAVERS', '', 1),
(17, 'SLAB', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_property_types_description`
--

CREATE TABLE `tbl_property_types_description` (
  `id` int(11) NOT NULL,
  `property_type_id` int(11) NOT NULL,
  `property_description_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_property_types_description`
--

INSERT INTO `tbl_property_types_description` (`id`, `property_type_id`, `property_description_id`) VALUES
(6, 12, 8),
(7, 12, 9),
(8, 12, 10),
(9, 13, 11),
(10, 13, 12),
(11, 14, 13),
(13, 15, 13),
(14, 16, 14),
(15, 17, 14);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subcounty`
--

CREATE TABLE `tbl_subcounty` (
  `id` int(10) UNSIGNED NOT NULL,
  `subcounty_name` varchar(50) NOT NULL,
  `district` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Districts in Uganda';

--
-- Dumping data for table `tbl_subcounty`
--

INSERT INTO `tbl_subcounty` (`id`, `subcounty_name`, `district`, `active`) VALUES
(1, 'IGANGA MUNICIPALITY', 33, 1),
(2, 'NAMBALE', 33, 1),
(3, 'NAMUNGALWE', 33, 1),
(4, 'NABITENDE', 33, 1),
(5, 'NAKALAMA ', 33, 1),
(6, 'KALIRO TOWN COUNCIL', 41, 1),
(7, 'KALIRO TOWN COUNCIL', 0, 1),
(8, 'NAMUGONGO', 41, 1),
(9, 'NAWANYINGI', 33, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tree_or_crop_types`
--

CREATE TABLE `tbl_tree_or_crop_types` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_tree_or_crop_types`
--

INSERT INTO `tbl_tree_or_crop_types` (`id`, `title`, `description`) VALUES
(34, 'BANANA', ''),
(35, 'COFFEE', ''),
(36, 'JACKFRUIT', ''),
(37, 'SUGARCANE', ''),
(38, 'MANGO', ''),
(39, 'AVOCADO', ''),
(40, 'PAWPAW', ''),
(41, 'GUAVA', ''),
(42, 'MUTUBA', ''),
(43, 'NSAMBYA', ''),
(44, 'MVULE', ''),
(45, 'ACACIA', ''),
(46, 'MUSIZI', ''),
(47, 'MAHOGANY', ''),
(48, 'PINE', ''),
(49, 'EUCALYPTUS', ''),
(50, 'ORNAMENTAL TREE', ''),
(51, 'SATANI(KIAPPLE) TREE', ''),
(52, 'MUKOGE', ''),
(56, 'ORANGE', ''),
(57, 'MUGAVU', ''),
(58, 'UMBRELLA TREE', ''),
(59, 'YAMS', ''),
(60, 'BAMBOO', ''),
(61, 'MUKOKOWE', ''),
(62, 'GRIVERIA', ''),
(63, 'HEDGE (LOCAL)', ''),
(64, 'JAMBULA', ''),
(65, 'KABAKANJAGALA', ''),
(66, 'BUSH TREE', ''),
(68, 'MKAPA', ''),
(69, 'MORINGA', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_village`
--

CREATE TABLE `tbl_village` (
  `id` int(10) UNSIGNED NOT NULL,
  `village_name` varchar(50) NOT NULL,
  `parish` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Districts in Uganda';

--
-- Dumping data for table `tbl_village`
--

INSERT INTO `tbl_village` (`id`, `village_name`, `parish`, `active`) VALUES
(3, 'BUKAYE', 6, 1),
(4, 'KIRINDI', 7, 1),
(5, 'KALITUNSI', 8, 1),
(6, 'NKONO CENTRAL', 9, 1),
(7, 'MABOGO', 6, 0),
(8, 'NABITENDE', 10, 1),
(9, 'NATWAMA', 11, 0),
(10, 'ZIBONDO', 12, 1),
(11, 'KAWETE', 0, 1),
(12, 'KAWETE', 13, 1),
(13, 'MAGOGO', 15, 1),
(14, 'BUSIMBA', 16, 1),
(15, 'NASUTI NORTH', 16, 1),
(16, 'BUBOGO A', 14, 1),
(17, 'BUBOGO B', 14, 1),
(18, 'BULUMWAKI I', 17, 1),
(19, 'BULANGA', 21, 1),
(20, 'NAMUNGALWE A', 13, 1),
(21, 'NAMUNGALWE B', 13, 1),
(22, 'NAMUNGALWE RURAL', 13, 1),
(23, 'NABIKOOTE', 14, 1),
(24, 'NAMUNFUMA', 14, 1),
(25, 'NAMUNKESU', 14, 1),
(26, 'NAMUNSALA', 18, 1),
(27, 'BUNYIRO CENTRAL', 19, 1),
(28, 'LWABAGA', 19, 1),
(29, 'MWANGA', 7, 1),
(30, 'NAKIYANJA ZONE', 20, 1),
(31, 'INDUSTRIAL AREA', 8, 1),
(32, 'VALLEY HILL', 8, 1),
(33, 'NAIBIRI SOUTH', 22, 1),
(34, 'BUYALE', 10, 1),
(35, 'BUKOSE', 10, 1),
(36, 'NABITENDE', 10, 1),
(37, 'NABITOVU', 23, 1),
(38, 'ZIBONDO', 24, 1),
(39, 'NATWAANA', 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tenure`
--

CREATE TABLE `tenure` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tenure`
--

INSERT INTO `tenure` (`id`, `title`, `description`) VALUES
(7, 'Mailo', ''),
(8, 'Customary', ''),
(9, 'Licencee', ''),
(10, 'Freehold', ''),
(11, 'Kibanja', ''),
(12, 'Leasehold', '');

-- --------------------------------------------------------

--
-- Table structure for table `tree_crop_types_description`
--

CREATE TABLE `tree_crop_types_description` (
  `id` int(11) NOT NULL,
  `tree_crop_id` int(11) NOT NULL,
  `crop_description_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tree_crop_types_description`
--

INSERT INTO `tree_crop_types_description` (`id`, `tree_crop_id`, `crop_description_id`) VALUES
(8, 34, 14),
(9, 34, 15),
(10, 34, 16),
(11, 34, 18),
(12, 34, 20),
(13, 37, 14),
(14, 37, 16),
(15, 37, 18),
(16, 37, 19),
(17, 37, 20),
(18, 35, 13),
(19, 35, 14),
(20, 35, 16),
(21, 35, 18),
(22, 35, 19),
(23, 45, 23),
(24, 45, 29),
(25, 45, 30),
(26, 45, 31),
(27, 39, 13),
(28, 39, 14),
(29, 39, 19),
(30, 39, 20),
(31, 49, 13),
(32, 49, 26),
(33, 49, 28),
(34, 49, 31),
(35, 49, 33),
(36, 41, 19),
(37, 41, 21),
(38, 41, 34),
(39, 36, 17),
(40, 36, 19),
(41, 36, 21),
(42, 36, 35),
(43, 47, 13),
(44, 47, 24),
(45, 47, 25),
(46, 47, 26),
(47, 47, 27),
(48, 47, 28),
(49, 38, 13),
(50, 38, 14),
(51, 38, 19),
(52, 38, 20),
(53, 52, 23),
(54, 52, 24),
(55, 52, 25),
(56, 52, 28),
(57, 52, 30),
(58, 46, 13),
(59, 46, 24),
(60, 46, 25),
(61, 46, 26),
(62, 46, 27),
(63, 46, 28),
(64, 44, 13),
(65, 44, 24),
(66, 44, 25),
(67, 44, 26),
(68, 44, 27),
(69, 44, 28),
(70, 42, 23),
(71, 42, 24),
(72, 42, 25),
(73, 42, 26),
(74, 42, 27),
(75, 42, 28),
(76, 43, 13),
(77, 43, 24),
(78, 43, 25),
(79, 43, 26),
(80, 43, 27),
(81, 43, 28),
(82, 50, 29),
(83, 50, 31),
(84, 40, 13),
(85, 40, 14),
(86, 40, 18),
(87, 40, 19),
(88, 40, 20),
(89, 48, 13),
(90, 48, 23),
(91, 48, 30),
(92, 48, 36),
(97, 46, 23),
(98, 50, 30),
(99, 56, 13),
(100, 56, 14),
(101, 56, 17),
(102, 56, 18),
(103, 56, 19),
(104, 57, 13),
(105, 57, 23),
(106, 57, 24),
(107, 57, 25),
(108, 57, 26),
(109, 57, 27),
(110, 57, 28),
(112, 39, 23),
(113, 38, 23),
(114, 59, 23),
(115, 59, 37),
(116, 60, 29),
(117, 60, 30),
(118, 60, 34),
(119, 51, 37),
(120, 43, 19),
(121, 44, 23),
(122, 61, 23),
(123, 61, 24),
(124, 61, 25),
(125, 61, 28),
(126, 61, 30),
(127, 62, 13),
(128, 62, 23),
(129, 62, 24),
(130, 62, 25),
(131, 62, 27),
(132, 62, 28),
(133, 63, 37),
(134, 64, 13),
(135, 64, 23),
(136, 64, 24),
(137, 64, 25),
(138, 64, 26),
(139, 64, 27),
(140, 64, 28),
(141, 58, 13),
(142, 58, 23),
(143, 58, 24),
(144, 58, 25),
(146, 58, 28),
(147, 65, 13),
(148, 65, 23),
(149, 65, 24),
(150, 65, 25),
(153, 65, 28),
(154, 66, 13),
(155, 66, 23),
(156, 66, 28),
(157, 66, 29),
(158, 68, 13),
(159, 68, 23),
(160, 68, 28),
(161, 68, 29),
(162, 69, 37);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accesslevel`
--
ALTER TABLE `accesslevel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expense_type` (`expenseType`);

--
-- Indexes for table `expensetypes`
--
ALTER TABLE `expensetypes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `land_access`
--
ALTER TABLE `land_access`
  ADD PRIMARY KEY (`pap_id`);

--
-- Indexes for table `land_access_project`
--
ALTER TABLE `land_access_project`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `project_category_unit` (`project_category_unit`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `land_access_project_category`
--
ALTER TABLE `land_access_project_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `land_access_project_category_unit`
--
ALTER TABLE `land_access_project_category_unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_client`
--
ALTER TABLE `tbl_client`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_created_by` (`created_by`),
  ADD KEY `fk_modified_by` (`modified_by`);

--
-- Indexes for table `tbl_comment`
--
ALTER TABLE `tbl_comment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_county`
--
ALTER TABLE `tbl_county`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_crop_description`
--
ALTER TABLE `tbl_crop_description`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_district`
--
ALTER TABLE `tbl_district`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_district_croptree_rate`
--
ALTER TABLE `tbl_district_croptree_rate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_district_property_rate`
--
ALTER TABLE `tbl_district_property_rate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_paps`
--
ALTER TABLE `tbl_paps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `modified_by` (`modified_by`),
  ADD KEY `fk_county_id` (`county_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `subcounty_id` (`subcounty_id`),
  ADD KEY `village_id` (`village_id`),
  ADD KEY `parish_id` (`parish_id`);

--
-- Indexes for table `tbl_pap_crop_tree`
--
ALTER TABLE `tbl_pap_crop_tree`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_modified_by` (`modified_by`),
  ADD KEY `fk_created_by` (`created_by`),
  ADD KEY `fk_pap_id` (`pap_id`),
  ADD KEY `crop_description_rate_id` (`crop_description_rate_id`);

--
-- Indexes for table `tbl_pap_improvement`
--
ALTER TABLE `tbl_pap_improvement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_modified_by` (`modified_by`),
  ADD KEY `fk_created_by` (`created_by`),
  ADD KEY `fk_pap_id` (`pap_id`),
  ADD KEY `fk_improvement_description_rate_id` (`district_property_rate_id`);

--
-- Indexes for table `tbl_pap_photos`
--
ALTER TABLE `tbl_pap_photos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_modified_by` (`modified_by`),
  ADD KEY `fk_created_by` (`created_by`),
  ADD KEY `fk_pap_id` (`pap_id`) USING BTREE;

--
-- Indexes for table `tbl_parish`
--
ALTER TABLE `tbl_parish`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_project_coverage`
--
ALTER TABLE `tbl_project_coverage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_district_id` (`district_id`),
  ADD KEY `fk_project_id` (`project_id`),
  ADD KEY `fk_created_by` (`created_by`),
  ADD KEY `fk_modified_by` (`modified_by`);

--
-- Indexes for table `tbl_property_description`
--
ALTER TABLE `tbl_property_description`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_property_type`
--
ALTER TABLE `tbl_property_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_property_types_description`
--
ALTER TABLE `tbl_property_types_description`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_subcounty`
--
ALTER TABLE `tbl_subcounty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_tree_or_crop_types`
--
ALTER TABLE `tbl_tree_or_crop_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_village`
--
ALTER TABLE `tbl_village`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tenure`
--
ALTER TABLE `tenure`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tree_crop_types_description`
--
ALTER TABLE `tree_crop_types_description`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accesslevel`
--
ALTER TABLE `accesslevel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `expensetypes`
--
ALTER TABLE `expensetypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `land_access`
--
ALTER TABLE `land_access`
  MODIFY `pap_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `land_access_project`
--
ALTER TABLE `land_access_project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `land_access_project_category`
--
ALTER TABLE `land_access_project_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `land_access_project_category_unit`
--
ALTER TABLE `land_access_project_category_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `position`
--
ALTER TABLE `position`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `tbl_client`
--
ALTER TABLE `tbl_client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_comment`
--
ALTER TABLE `tbl_comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_county`
--
ALTER TABLE `tbl_county`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_crop_description`
--
ALTER TABLE `tbl_crop_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `tbl_district`
--
ALTER TABLE `tbl_district`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;
--
-- AUTO_INCREMENT for table `tbl_district_croptree_rate`
--
ALTER TABLE `tbl_district_croptree_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;
--
-- AUTO_INCREMENT for table `tbl_district_property_rate`
--
ALTER TABLE `tbl_district_property_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `tbl_paps`
--
ALTER TABLE `tbl_paps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1733;
--
-- AUTO_INCREMENT for table `tbl_pap_crop_tree`
--
ALTER TABLE `tbl_pap_crop_tree`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=740;
--
-- AUTO_INCREMENT for table `tbl_pap_improvement`
--
ALTER TABLE `tbl_pap_improvement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `tbl_pap_photos`
--
ALTER TABLE `tbl_pap_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_parish`
--
ALTER TABLE `tbl_parish`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `tbl_project_coverage`
--
ALTER TABLE `tbl_project_coverage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `tbl_property_description`
--
ALTER TABLE `tbl_property_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `tbl_property_type`
--
ALTER TABLE `tbl_property_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `tbl_property_types_description`
--
ALTER TABLE `tbl_property_types_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `tbl_subcounty`
--
ALTER TABLE `tbl_subcounty`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `tbl_tree_or_crop_types`
--
ALTER TABLE `tbl_tree_or_crop_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;
--
-- AUTO_INCREMENT for table `tbl_village`
--
ALTER TABLE `tbl_village`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `tenure`
--
ALTER TABLE `tenure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `tree_crop_types_description`
--
ALTER TABLE `tree_crop_types_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
