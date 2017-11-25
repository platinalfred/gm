-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 25, 2017 at 03:49 PM
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
  `way_leave` decimal(8,2) DEFAULT NULL,
  `rightofway` decimal(8,2) DEFAULT NULL,
  `total_take` decimal(8,2) DEFAULT NULL,
  `diminution_rate` int(11) NOT NULL,
  `rate_per_acre` decimal(12,2) NOT NULL,
  `land_interest` int(11) NOT NULL,
  `chainage` varchar(30) NOT NULL,
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

INSERT INTO `tbl_paps` (`id`, `project_id`, `pap_ref`, `firstname`, `lastname`, `othername`, `phone_contact`, `district_id`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `photo_url`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, `chainage`, `date_created`, `created_by`, `date_modified`, `modified_by`, `comment`, `active`) VALUES
(2, 3, 'PAP_1511365820', 'Alfred', 'platin', 'Mugasa', '0702771124', 31, 1, 1, 1, 1, NULL, '0.00', '1.00', '0.00', 0, '0.00', 0, '0+100', 1511365820, 1, '2017-11-22 15:50:20', 1, NULL, 1),
(3, 3, 'PAP_1511365825', 'Alfred', 'platin', 'Mugasa', '0702771124', 31, 1, 1, 1, 1, NULL, '0.00', '1.00', '0.00', 0, '0.00', 0, '0+100', 1511365825, 1, '2017-11-22 15:50:25', 1, NULL, 1),
(4, 3, 'PAP_1511365841', 'Alfred', 'platin', 'Mugasa', '0702771124', 31, 1, 1, 1, 1, NULL, '0.00', '1.00', '0.00', 0, '0.00', 0, '0+100', 1511365841, 1, '2017-11-22 15:50:41', 1, NULL, 1),
(5, 3, 'PAP_1511367071', 'Brayan', 'Wamani', 'Matovu', '0701108282', 31, 1, 1, 1, 1, NULL, '0.00', '2.00', '0.00', 0, '0.00', 0, '100+200', 1511367071, 1, '2017-11-22 16:11:11', 1, NULL, 1),
(6, 6, 'PAP_1511612577', 'Alfred', 'Platin', 'Mugasa', '0702771124', 31, 1, 1, 1, 1, NULL, '0.00', '0.00', '12.00', 80, '15.00', 100, '0+200', 1511612577, 1, '2017-11-25 14:37:12', 1, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_paps`
--
ALTER TABLE `tbl_paps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `modified_by` (`modified_by`),
  ADD KEY `fk_county_id` (`county_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_paps`
--
ALTER TABLE `tbl_paps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
