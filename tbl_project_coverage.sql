-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2017 at 03:06 PM
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

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_project_coverage`
--
ALTER TABLE `tbl_project_coverage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
