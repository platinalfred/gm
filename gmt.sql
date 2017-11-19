-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2017 at 01:43 PM
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
  `date_added` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_modified` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `land_access_project`
--

INSERT INTO `land_access_project` (`id`, `project_title`, `project_category`, `project_category_unit`, `project_reference`, `client_id`, `date_added`, `created_by`, `date_modified`, `modified_by`, `active`) VALUES
(1, 'Rehabilitation of Rwizi settlers', NULL, 4, 'REF837N', 4, '2017-11-10 12:18:59', 0, '0000-00-00 00:00:00', 1, 1),
(2, 'Land title', NULL, 4, 'GREA2016', 4, '2017-11-10 12:20:59', 0, '0000-00-00 00:00:00', 1, 1),
(3, 'Standard Gauge Railway for Ntungamo', NULL, 1, 'NME2311', 3, '2017-11-10 12:34:52', 0, '0000-00-00 00:00:00', 1, 1);

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

--
-- Dumping data for table `land_access_project_category`
--

INSERT INTO `land_access_project_category` (`id`, `title`, `description`, `active`, `date_added`, `date_modified`, `modified_by`) VALUES
(1, 'Permanent Land Acquisition', 'Permanent Land Acquisition', 1, '2017-10-23 11:20:30', '2017-10-23 09:26:30', 0),
(2, 'Temporary land Acquisition', 'Temporary land Acquisition', 1, '2017-10-23 11:26:53', '2017-10-23 09:26:53', 0);

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
(1, 'Right of way', 1, 'This involves full utilization of the entire piece of land. In other words, land ownership is totally transferred from the primary owner, to the body in charge.\r\nExamples of activities that require this type of acquisition are road construction, Laying water pipelines, and etc. This type majorly falls under the Permanent land acquisition Category.\r\nAnd the agencies involved here are UNRA & NWSC', '2017-11-09 06:08:58', 0, '2017-11-09 05:18:43', 1),
(2, 'Way Leaves', 2, 'In this type of acquisition, land is used limitedly depending on the activity at hand.  In other words, the primary land owner is allowed to use this particular piece of land to some extent. A good example on this is say, assuming electricity power lines are passed through some oneâ€™s land, it would not imply that he would no longer be using that land completely, he could still  use it for activities like farming but limited to only growing short crops like beans, maize, and etc. but not for crops like Bananas, trees and etc. REA is the only agency involved', '2017-11-09 06:12:16', 0, '2017-11-09 05:18:48', 1),
(4, 'Right of way and Way leaves', 3, 'Combines both right of way and wayleaves', '2017-11-09 06:20:31', 0, '2017-11-09 05:20:40', 1),
(5, 'Total Size', 1, 'Applicable incase of Roads, Agriculture, Oil and Gas, and Water Sector Projects', '2017-11-15 05:05:09', 0, '2017-11-15 16:05:09', 1);

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
(1, 'Alfred', 'Platin', 'Mugasa', 1, '', '9e11830101b6b723ae3fb11e660a2123', 1, 'mplat84@gmail.com', '0702771124', '', '', 1, '0000-00-00', NULL, 1510582406, '2017-11-14 10:51:41', '', 1),
(4, 'Allan ', 'Jesse ', 'Odekke', 2, '', '9e11830101b6b723ae3fb11e660a2123', 1, 'allan@gmail.com', '0702771124', '0774355568', 'Kampala', 0, '0000-00-00', NULL, 1510660039, '2017-11-14 11:47:19', '', 1),
(5, 'Wamani', 'Brayan', 'Matovu', 1, '', '9e11830101b6b723ae3fb11e660a2123', 1, 'brwamani@gmail.com', '0702771124', '0774355568', 'Wakiso', 1, '0000-00-00', NULL, 1510660262, '2017-11-14 11:51:02', '', 1);

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
(1, 'Uganda Electricity Transmission Company', 'Nakasero Road Road, Kampala', '10347, Kampala', '0414989029', '0414083093', 'procurement@uetcl.go.ug', 'contact@uetcl.go.ug', '', 0, 1510235600, 1, '2017-11-10 10:51:14'),
(2, 'Uganda National Roads Authority', 'Mackinnon Road, Kampala', '45989, Kampala', '0312837837', '', 'info@unra.go.ug', '', '', 0, 1510236100, 1, '2017-11-10 10:48:47'),
(3, 'Uganda Railways Corporation', 'Nasser Road, Kampala', '938939, Kampala', '0438939030', '', 'info@urc.go.ug', '', '', 0, 1510236271, 1, '2017-11-09 11:04:31'),
(4, 'Electricity Regulatory Authority', 'Electricity Towers, Nakasero, Kampala', '98083, Kampala', '0414319082', '', 'info@era.go.ug', 'contact@era.go.ug', '', 0, 1510236852, 1, '2017-11-09 11:14:12');

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

--
-- Dumping data for table `tbl_county`
--

INSERT INTO `tbl_county` (`id`, `county_name`, `district`, `active`) VALUES
(1, 'Bugahya', 31, 1),
(2, 'Dakabela', 107, 1),
(3, 'Kyabigambiire', 0, 1),
(4, 'Buhaguzi', 31, 1),
(7, 'Buseruka', 31, 1);

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
(1, 0, 'Mature', '', 1),
(2, 0, 'Average', '', 0),
(3, 0, 'Building', '', 0),
(4, 0, 'Building Pole', '', 0),
(5, 0, 'Electric', '', 1),
(6, 0, 'Firewood', '', 1),
(7, 0, 'Mature Good', '', 1),
(8, 0, 'Seedling', '', 1),
(9, 0, 'Young Good', '', 1),
(10, 0, 'Young', '', 1),
(11, 0, 'Timber', '', 1),
(12, 0, 'Telephone', '', 1);

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
(1, 1, 1, 20000.00),
(2, 1, 2, 4000.00);

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
(2, 1, 2, 20000.00),
(3, 1, 1, 10000.00),
(4, 1, 1, 10000.00),
(5, 1, 1, 10000.00),
(6, 1, 3, 2000.00);

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
  `village` int(11) NOT NULL,
  `photo_url` varchar(100) DEFAULT NULL,
  `way_leave` decimal(8,2) DEFAULT NULL,
  `rightofway` decimal(8,2) DEFAULT NULL,
  `total_take` decimal(8,2) DEFAULT NULL,
  `chainage` decimal(8,2) NOT NULL,
  `date_created` int(11) NOT NULL COMMENT 'Timestamp of the moment the member was added',
  `created_by` int(11) NOT NULL COMMENT 'Reference to staff who created this record',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp of the moment the member was modified',
  `modified_by` int(11) NOT NULL COMMENT 'Reference to staff who modified the record',
  `comment` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_paps`
--

INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `chainage`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`) VALUES
(1, 1, 'PAP_1510756252', 'Alfred', 'Platin ', 'Mugasa', '0702771124', 22, 17, 451, 321, 0, NULL, '0.23', '1.01', '2.00', '200.00', 1510756252, 1, '2017-11-15 14:30:52', 1, NULL);

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
(1, 1, 1, '20000.00', 30000, 1, 1510756252, 1, '2017-11-15 14:30:52');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pap_improvement`
--

CREATE TABLE `tbl_pap_improvement` (
  `id` int(11) NOT NULL,
  `pap_id` int(11) NOT NULL,
  `district_property_rate_id` int(11) NOT NULL,
  `rate` decimal(12,2) NOT NULL,
  `quantity` smallint(6) NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_created` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(1, 'Bulindi', 1, 1),
(2, 'Kibaire', 1, 1),
(3, 'Kisabagwa', 1, 1),
(4, 'Kibugubya', 1, 1),
(5, 'Kibingo', 0, 1);

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
(1, 1, 78, 1, 1510578284, 1, '2017-11-13 13:04:44'),
(2, 1, 22, 1, 1510578284, 1, '2017-11-13 13:04:44'),
(3, 1, 54, 1, 1510578284, 1, '2017-11-13 13:04:44'),
(4, 1, 52, 1, 1510579030, 1, '2017-11-13 13:17:10'),
(5, 3, 9, 1, 1510668603, 1, '2017-11-14 14:10:03'),
(6, 3, 28, 1, 1510668603, 1, '2017-11-14 14:10:03'),
(7, 3, 5, 1, 1510668603, 1, '2017-11-14 14:10:03'),
(8, 3, 4, 1, 1510668603, 1, '2017-11-14 14:10:03');

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
(1, 'Barbed Wire', '', 1),
(2, 'No roof, Burnt Bricks', '', 1),
(3, 'Corrugated Galvanised Iron Sheets Walls', '', 1),
(4, 'Corrugated Galvanised Iron Sheets and Timber', '', 1),
(5, 'Corrugated Galvanised Iron Sheets and Timber, cement Scree, Galvanised Iron sheet Doors', '', 1),
(6, 'Kiappo', '', 1),
(7, 'Live Hedge', '', 1);

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
(1, 'Bathroom Slab', '', 1),
(2, 'Kiosk', '', 1),
(3, 'Fence', '', 1),
(4, 'Main House', 'Semi Permanent', 1),
(5, 'Out Hourse ', 'Semi Permanent', 1),
(6, 'Pit Latrine(Permanent)', 'Permanent', 1),
(7, 'Plate Rack', '', 1),
(8, 'Slab Abatoor', '', 1),
(9, 'Stall (Temporally)', 'Temporally', 1),
(10, 'Temporally Structure', '', 1),
(11, 'Washrooms', '', 1);

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
(1, 1, 2),
(2, 1, 3),
(3, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subcounty`
--

CREATE TABLE `tbl_subcounty` (
  `id` int(10) UNSIGNED NOT NULL,
  `subcounty_name` varchar(50) NOT NULL,
  `county` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Districts in Uganda';

--
-- Dumping data for table `tbl_subcounty`
--

INSERT INTO `tbl_subcounty` (`id`, `subcounty_name`, `county`, `active`) VALUES
(1, 'Kyabigambire', 1, 1),
(2, 'Buseruka', 1, 1),
(4, 'Buseruka', 1, 1),
(5, 'Kitoba', 1, 1);

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
(2, 'Eucalyptus', 'Eucalyptus tree'),
(3, 'Mutuba', 'Mutuba'),
(4, 'Bush Tree', 'Bush Tree'),
(5, 'Pine', 'Pine tree'),
(6, 'Mango', ''),
(7, 'Mugavu', ''),
(8, 'Acacia', ''),
(9, 'Teak Tree', ''),
(10, 'Banana', ''),
(11, 'Musambya', ''),
(12, 'Kiko', '');

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
(1, 'Kihambya', 1, 1),
(2, 'Kakindo', 1, 1);

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
(1, 'Mailo', ''),
(2, 'Customary', ''),
(3, 'Freehold', ''),
(4, 'Leasehold', ''),
(5, 'Kibanja', ''),
(6, 'Licencee', '');

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
(1, 8, 1),
(2, 4, 1),
(3, 4, 7),
(4, 4, 9),
(5, 4, 10);

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
  ADD KEY `fk_county_id` (`county_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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
-- AUTO_INCREMENT for table `position`
--
ALTER TABLE `position`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_client`
--
ALTER TABLE `tbl_client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tbl_county`
--
ALTER TABLE `tbl_county`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `tbl_crop_description`
--
ALTER TABLE `tbl_crop_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `tbl_district`
--
ALTER TABLE `tbl_district`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;
--
-- AUTO_INCREMENT for table `tbl_district_croptree_rate`
--
ALTER TABLE `tbl_district_croptree_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tbl_district_property_rate`
--
ALTER TABLE `tbl_district_property_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tbl_paps`
--
ALTER TABLE `tbl_paps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tbl_pap_crop_tree`
--
ALTER TABLE `tbl_pap_crop_tree`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tbl_pap_improvement`
--
ALTER TABLE `tbl_pap_improvement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_parish`
--
ALTER TABLE `tbl_parish`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_project_coverage`
--
ALTER TABLE `tbl_project_coverage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `tbl_property_description`
--
ALTER TABLE `tbl_property_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `tbl_property_type`
--
ALTER TABLE `tbl_property_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `tbl_property_types_description`
--
ALTER TABLE `tbl_property_types_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tbl_subcounty`
--
ALTER TABLE `tbl_subcounty`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tbl_tree_or_crop_types`
--
ALTER TABLE `tbl_tree_or_crop_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `tbl_village`
--
ALTER TABLE `tbl_village`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tenure`
--
ALTER TABLE `tenure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tree_crop_types_description`
--
ALTER TABLE `tree_crop_types_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
