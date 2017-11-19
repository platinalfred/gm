-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2017 at 12:44 PM
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

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_pap_improvement`
--
ALTER TABLE `tbl_pap_improvement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
