-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 31, 2023 at 04:46 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `supermarket`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `message` varchar(400) NOT NULL,
  `id` int(11) NOT NULL,
  `submitted_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`name`, `email`, `message`, `id`, `submitted_at`) VALUES
('Liyanage Maneesha Kaushalya', 'maneeshakaushalya28@gmail.com', 'hi', 5, '2023-12-29'),
('Liyanage Maneesha Kaushalya', 'maneeshakaushalya28@gmail.com', 'great website', 6, '2023-12-29');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `name` varchar(100) DEFAULT NULL,
  `age` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `payment` decimal(10,2) NOT NULL,
  `order_id` int(255) NOT NULL,
  `ordered_time` datetime DEFAULT NULL,
  `status` varchar(10) DEFAULT 'Pending',
  `delivery` varchar(10) DEFAULT 'Pending',
  `emailaddress` varchar(100) NOT NULL,
  `product_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `product_id`, `customer_name`, `address`, `phone_number`, `payment`, `order_id`, `ordered_time`, `status`, `delivery`, `emailaddress`, `product_data`) VALUES
(17, NULL, 'Maneesha kaushalya', '278/2 vidyaraja mawatha hokandara south hokandara', '0769919349', 0.00, 459103, '2023-12-29 07:24:46', 'success', 'Shipped', 'maneeshakaushalya28@gmail.com', 'Maliban Smart Cream Crackers 125g, Munchee Chocolate Marie 400g'),
(20, NULL, 'Maneesha ', '214/22 mewalla road', '0772432211', 0.00, 747015, '2023-12-29 12:54:59', 'success', 'Shipped', 'maneeshakaushalya28@gmail.com', 'Green Beans, Brinjals'),
(45, NULL, 'Liyanage Maneesha Kaushalya', '278/2 Vidyaraja Mawatha Horkandara South Horkandara', '0769919349', 0.00, 214030, '2023-12-30 10:02:45', 'success', 'Pending', 'maneeshakaushalya28@gmail.com', 'Brinjals'),
(46, NULL, 'Liyanage Maneesha Kaushalya', '278/2 Vidyaraja Mawatha Horkandara South Horkandara', '0769919349', 0.00, 569972, '2023-12-30 10:10:40', 'success', 'Pending', 'kalanamanahara4@gmial.com', 'Brinjals'),
(47, NULL, 'Liyanage Maneesha Kaushalya', '278/2 Vidyaraja Mawatha Horkandara South Horkandara', '0769919349', 0.00, 623268, '2023-12-30 10:26:56', 'success', 'Pending', 'maneeshakaushalya28@gmail.com', 'Cabbage'),
(48, NULL, 'Liyanage Maneesha Kaushalya', '278/2 Vidyaraja Mawatha Horkandara South Horkandara', '0769919349', 0.00, 128216, '2023-12-30 10:47:40', 'success', 'Pending', 'maneeshakaushalya28@gmail.com', 'Brinjals, Brinjals'),
(49, NULL, 'Liyanage Maneesha Kaushalya', '278/2 Vidyaraja Mawatha Horkandara South Horkandara', '0769919349', 0.00, 464992, '2023-12-30 14:36:09', 'success', 'Pending', 'maneeshakaushalya28@gmail.com', 'Cabbage'),
(50, NULL, 'Liyanage Maneesha Kaushalya', '278/2 Vidyaraja Mawatha Horkandara South Horkandara', '0769919349', 0.00, 332476, '2023-12-30 22:55:56', 'success', 'Pending', 'maneeshakaushalya28@gmail.com', 'Cabbage'),
(51, NULL, 'Liyanage Maneesha Kaushalya', '278/2 Vidyaraja Mawatha Horkandara South Horkandara', '0769919349', 0.00, 276281, '2023-12-30 22:58:27', 'success', 'Pending', 'maneeshakaushalya28@gmail.com', 'Cabbage, Cabbage');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `image_url` varchar(1000) DEFAULT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `quantity`, `image_url`, `category`) VALUES
(10475, 'Keells Marie 80g', 'Keells Marie 80g\r\n', 20.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/10475Pic119010.jpg?alt=media&token', ''),
(10497, 'Cabbage', '1KG', 100.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/10497Pic915005.jpg?alt=media&token', 'Fresh Produce'),
(14573, 'Keells Cream Cracker 85g', ' Cracker 85g\r\n', 15.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/14573Pic118976 (1).jpg?alt=media&token', ''),
(25861, 'Keells Dish Wash Bar 100g', 'Keells Dish Wash Bar 100g\r\n', 10.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/25861Pic111083 (1).jpg?alt=media&token', ''),
(35973, 'Kotmale Uht Strawberry Milk 170ml', '170ml', 100.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/35973Pic113471.jpg?alt=media&token', 'Beverages and Dairy'),
(36715, 'Tiara O Kay Spng Layer Cake Clas 18g', '18g\r\n', 100.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/36715Pic1004.jpg?alt=media&token', 'Groceries'),
(67244, 'Brinjals', '1kg', 100.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/67244Pic914008.jpg?alt=media&token', 'Fresh Produce'),
(74496, 'Munchee Chocolate Marie 400g', ' 400g\r\n', 400.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/74496Pic29718.jpg?alt=media&token', 'Groceries'),
(77420, 'Maliban Smart Cream Crackers 125g', '125g', 100.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/77420Pic9714.jpg?alt=media&token', 'Groceries'),
(86643, 'Green Beans', '1KG', 100.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/86643Pic915008.jpg?alt=media&token', 'Fresh Produce'),
(99243, 'Ambewela Non Fat Milk 1L', 'Milk 1L\r\n', 100.00, 10, 'https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/99243Pic27284.jpg?alt=media&token', 'Beverages and Dairy');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`email`, `password`, `id`) VALUES
('maneeshakaushalya28@gmail.com', 'maneesha2002', 4),
('kalanamanahara4@gmial.com', 'Kalana123', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
