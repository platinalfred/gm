-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 02, 2017 at 01:26 PM
-- Server version: 5.6.38
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gmtconsu_ims`
--

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
(7, 'CONSULTANCY SERVICES FOR THE DEVELOPMENT OF A RESETTLEMENT ACTION PLAN (RAP) FOR THE IGANGA â€“ KALIRO WATER SUPPLY SYSTEM ', NULL, 5, 'IKWS', 5, 15, '2017-11-29 08:19:48', 0, '0000-00-00 00:00:00', 1, 1);

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
(49, 33, 55, 80000.00),
(50, 33, 57, 100000.00),
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
(102, 33, 96, 5000.00),
(103, 33, 96, 15000.00),
(104, 33, 94, 25000.00),
(105, 33, 95, 5000.00),
(106, 33, 93, 2000.00),
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
(121, 33, 118, 10000.00);

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
(21, 33, 13, 100000.00);

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
(20, 'BUYUNGA', 6, 1);

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
(14, 7, 41, 1, 1511953645, 1, '2017-11-29 11:07:25');

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
(13, 'CEMENT SCREED FLOOR ON SITE CONCRETE', '', 1);

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
(15, 'VERANDAH', '', 1);

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
(13, 15, 13);

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
(51, 'SATANI TREE', ''),
(52, 'MUKOGE', ''),
(56, 'ORANGE', ''),
(57, 'MUGAVU', ''),
(58, 'UMBRELLA TREE', ''),
(59, 'YAMS', ''),
(60, 'BAMBOO', '');

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
(9, 'NATWAMA', 11, 1),
(10, 'ZIBONDO', 12, 1),
(11, 'KAWETE', 0, 1),
(12, 'KAWETE', 13, 1),
(13, 'MAGOGO', 15, 1),
(14, 'BUSIMBA', 16, 1),
(15, 'NASUTI NORTH', 16, 1),
(16, 'BUBOGO A', 14, 1),
(17, 'BUBOGO B', 14, 1),
(18, 'BULUMWAKI I', 17, 1),
(19, 'BULANGA', 13, 1),
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
(32, 'VALLEY HILL', 8, 1);

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
(93, 51, 13),
(94, 51, 14),
(95, 51, 23),
(96, 51, 30),
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
(118, 60, 34);

--
-- Indexes for dumped tables
--

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `land_access_project_category`
--
ALTER TABLE `land_access_project_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `land_access_project_category_unit`
--
ALTER TABLE `land_access_project_category_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;
--
-- AUTO_INCREMENT for table `tbl_district_property_rate`
--
ALTER TABLE `tbl_district_property_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `tbl_pap_photos`
--
ALTER TABLE `tbl_pap_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_parish`
--
ALTER TABLE `tbl_parish`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `tbl_project_coverage`
--
ALTER TABLE `tbl_project_coverage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `tbl_property_description`
--
ALTER TABLE `tbl_property_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `tbl_property_type`
--
ALTER TABLE `tbl_property_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `tbl_property_types_description`
--
ALTER TABLE `tbl_property_types_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `tbl_subcounty`
--
ALTER TABLE `tbl_subcounty`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `tbl_tree_or_crop_types`
--
ALTER TABLE `tbl_tree_or_crop_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
--
-- AUTO_INCREMENT for table `tbl_village`
--
ALTER TABLE `tbl_village`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `tenure`
--
ALTER TABLE `tenure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `tree_crop_types_description`
--
ALTER TABLE `tree_crop_types_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
