-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 25, 2015 at 05:13 PM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `minimalism`
--
CREATE DATABASE IF NOT EXISTS `minimalism` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `minimalism`;

-- --------------------------------------------------------

--
-- Table structure for table `things`
--

CREATE TABLE IF NOT EXISTS `things` (
`thingid` int(10) unsigned NOT NULL,
  `internal_order` mediumint(8) unsigned DEFAULT '0',
  `is_private` tinyint(1) unsigned DEFAULT '0',
  `is_container` tinyint(1) unsigned DEFAULT '0',
  `container` int(10) unsigned DEFAULT '0',
  `title` varchar(250) DEFAULT NULL,
  `description` mediumtext,
  `image` varchar(250) DEFAULT NULL,
  `thumb_tiny` varchar(250) DEFAULT NULL,
  `thumb_medium` varchar(250) DEFAULT NULL,
  `thumb_big` varchar(250) DEFAULT NULL,
  `upload_date` int(10) unsigned DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=127 ;

--
-- Dumping data for table `things`
--

INSERT INTO `things` (`thingid`, `internal_order`, `is_private`, `is_container`, `container`, `title`, `description`, `image`, `thumb_tiny`, `thumb_medium`, `thumb_big`, `upload_date`) VALUES
(1, 1, 0, 0, 0, 'Belt', NULL, 'things/1/belt.jpg', 'things/1/belt.jpg', 'things/1/belt.jpg', 'things/1/belt.jpg', 1416568567),
(2, 2, 0, 0, 0, 'Camera', NULL, 'things/1/camera.jpg', 'things/1/camera.jpg', 'things/1/camera.jpg', 'things/1/camera.jpg', 1416568567),
(3, 3, 0, 0, 0, 'Watch', NULL, 'things/1/clock.jpg', 'things/1/clock.jpg', 'things/1/clock.jpg', 'things/1/clock.jpg', 1416568567),
(4, 4, 0, 0, 0, 'Jacket', NULL, 'things/1/jacket.jpg', 'things/1/jacket.jpg', 'things/1/jacket.jpg', 'things/1/jacket.jpg', 1416568567),
(5, 5, 0, 0, 0, 'Jeans', NULL, 'things/1/jeans.jpg', 'things/1/jeans.jpg', 'things/1/jeans.jpg', 'things/1/jeans.jpg', 1416568567),
(6, 6, 0, 0, 0, 'MacBook', NULL, 'things/1/macbook.jpg', 'things/1/macbook.jpg', 'things/1/macbook.jpg', 'things/1/macbook.jpg', 1416568567),
(7, 7, 0, 1, 0, 'Rucksack', NULL, 'things/1/rucksack.jpg', 'things/1/rucksack.jpg', 'things/1/rucksack.jpg', 'things/1/rucksack.jpg', 1416568567),
(8, 8, 0, 0, 0, 'Notebook', NULL, 'things/1/notebook.jpg', 'things/1/notebook.jpg', 'things/1/notebook.jpg', 'things/1/notebook.jpg', 1416568567),
(9, 9, 0, 0, 0, 'Razor', NULL, 'things/1/razor.jpg', 'things/1/razor.jpg', 'things/1/razor.jpg', 'things/1/razor.jpg', 1416568567),
(10, 10, 0, 0, 0, 'Shirt', NULL, 'things/1/shirt.jpg', 'things/1/shirt.jpg', 'things/1/shirt.jpg', 'things/1/shirt.jpg', 1416568567),
(11, 11, 0, 0, 0, 'Shoes', NULL, 'things/1/shoes.jpg', 'things/1/shoes.jpg', 'things/1/shoes.jpg', 'things/1/shoes.jpg', 1416568567),
(12, 12, 0, 0, 0, 'Socks', NULL, 'things/1/socks.jpg', 'things/1/socks.jpg', 'things/1/socks.jpg', 'things/1/socks.jpg', 1416568567),
(13, 13, 0, 0, 0, 'T-shirt', NULL, 'things/1/tshirt.jpg', 'things/1/tshirt.jpg', 'things/1/tshirt.jpg', 'things/1/tshirt.jpg', 1416568567),
(14, 14, 0, 0, 0, 'T-shirt', NULL, 'things/1/tshirt2.jpg', 'things/1/tshirt2.jpg', 'things/1/tshirt2.jpg', 'things/1/tshirt2.jpg', 1416568567),
(15, 15, 0, 0, 0, 'T-shirt', NULL, 'things/1/tshirt3.jpg', 'things/1/tshirt3.jpg', 'things/1/tshirt3.jpg', 'things/1/tshirt3.jpg', 1416568567),
(16, 16, 0, 0, 0, 'T-shirts', NULL, 'things/1/tshirts.jpg', 'things/1/tshirts.jpg', 'things/1/tshirts.jpg', 'things/1/tshirts.jpg', 1416568567),
(17, 1, 0, 0, 0, 'Dress', NULL, 'things/2/dress.jpg', 'things/2/dress.jpg', 'things/2/dress.jpg', 'things/2/dress.jpg', 1416568667),
(18, 2, 0, 0, 0, 'Glasses', NULL, 'things/2/glasses.jpg', 'things/2/glasses.jpg', 'things/2/glasses.jpg', 'things/2/glasses.jpg', 1416568667),
(19, 3, 0, 0, 0, 'Pants', NULL, 'things/2/hose.jpg', 'things/2/hose.jpg', 'things/2/hose.jpg', 'things/2/hose.jpg', 1416568667),
(20, 4, 0, 0, 0, 'Laptop', NULL, 'things/2/lenovo-yoga.jpg', 'things/2/lenovo-yoga.jpg', 'things/2/lenovo-yoga.jpg', 'things/2/lenovo-yoga.jpg', 1416568667),
(21, 5, 0, 0, 0, 'Running Shoes', NULL, 'things/2/shoes-1.jpg', 'things/2/shoes-1.jpg', 'things/2/shoes-1.jpg', 'things/2/shoes-1.jpg', 1416568667),
(22, 6, 0, 0, 0, 'Red High Heels', NULL, 'things/2/shoes-2.jpg', 'things/2/shoes-2.jpg', 'things/2/shoes-2.jpg', 'things/2/shoes-2.jpg', 1416568667),
(23, 7, 0, 0, 0, 'Second Pair of red high heels', NULL, 'things/2/shoes-3.jpg', 'things/2/shoes-3.jpg', 'things/2/shoes-3.jpg', 'things/2/shoes-3.jpg', 1416568667),
(24, 8, 0, 0, 0, 'Sweater', NULL, 'things/2/sweater.jpg', 'things/2/sweater.jpg', 'things/2/sweater.jpg', 'things/2/sweater.jpg', 1416568667),
(25, 9, 0, 0, 0, 'Toothbrush', NULL, 'things/2/toothbrush.jpg', 'things/2/toothbrush.jpg', 'things/2/toothbrush.jpg', 'things/2/toothbrush.jpg', 1416568667),
(26, 10, 0, 0, 0, 'Top', NULL, 'things/2/top.jpg', 'things/2/top.jpg', 'things/2/top.jpg', 'things/2/top.jpg', 1416568667),
(27, 1, 0, 0, 0, 'Boots', NULL, 'things/3/boots.jpg', 'things/3/boots.jpg', 'things/3/boots.jpg', 'things/3/boots.jpg', 1416569667),
(28, 2, 0, 0, 0, 'Macbook', NULL, 'things/3/macbook.jpg', 'things/3/macbook.jpg', 'things/3/macbook.jpg', 'things/3/macbook.jpg', 1416569667),
(29, 3, 0, 0, 0, 'Rain Boots', NULL, 'things/3/rain-boots.jpg', 'things/3/rain-boots.jpg', 'things/3/rain-boots.jpg', 'things/3/rain-boots.jpg', 1416569667),
(30, 4, 0, 0, 0, 'Shaver', NULL, 'things/3/shaver.jpg', 'things/3/shaver.jpg', 'things/3/shaver.jpg', 'things/3/shaver.jpg', 1416569667),
(31, 5, 0, 0, 0, 'Shoes', NULL, 'things/3/shoes.jpg', 'things/3/shoes.jpg', 'things/3/shoes.jpg', 'things/3/shoes.jpg', 1416569667),
(32, 6, 0, 0, 0, 'Training pants', NULL, 'things/3/training-pants.jpg', 'things/3/training-pants.jpg', 'things/3/training-pants.jpg', 'things/3/training-pants.jpg', 1416569667),
(33, 7, 0, 0, 0, 'T-Shirts', NULL, 'things/3/tshirts.jpg', 'things/3/tshirts.jpg', 'things/3/tshirts.jpg', 'things/3/tshirts.jpg', 1416569667),
(34, 0, 0, 1, 0, 'Bag', NULL, 'things/4/bag.jpg', 'things/4/bag.jpg', 'things/4/bag.jpg', 'things/4/bag.jpg', 1416570077),
(35, 0, 0, 0, 0, 'Boots', NULL, 'things/4/boots.jpg', 'things/4/boots.jpg', 'things/4/boots.jpg', 'things/4/boots.jpg', 1416570077),
(36, 0, 0, 0, 0, 'Chucks', NULL, 'things/4/chucks.png', 'things/4/chucks.png', 'things/4/chucks.png', 'things/4/chucks.png', 1416570077),
(37, 0, 0, 0, 0, 'Iphone', NULL, 'things/4/iphone-5-ios-7.jpg', 'things/4/iphone-5-ios-7.jpg', 'things/4/iphone-5-ios-7.jpg', 'things/4/iphone-5-ios-7.jpg', 1416570077),
(38, 0, 0, 0, 0, 'Macbook', NULL, 'things/4/macbook.jpg', 'things/4/macbook.jpg', 'things/4/macbook.jpg', 'things/4/macbook.jpg', 1416570077),
(39, 0, 0, 0, 0, 'Shoes', NULL, 'things/4/shoes.jpg', 'things/4/shoes.jpg', 'things/4/shoes.jpg', 'things/4/shoes.jpg', 1416570077),
(40, 0, 0, 0, 0, 'Socks', NULL, 'things/4/socks.jpg', 'things/4/socks.jpg', 'things/4/socks.jpg', 'things/4/socks.jpg', 1416570077),
(41, 0, 0, 0, 0, 'Tie', NULL, 'things/4/tie.jpg', 'things/4/tie.jpg', 'things/4/tie.jpg', 'things/4/tie.jpg', 1416570077),
(42, 0, 0, 0, 0, 'Underpants', NULL, 'things/4/underpants.jpg', 'things/4/underpants.jpg', 'things/4/underpants.jpg', 'things/4/underpants.jpg', 1416570077),
(43, 1, 0, 0, 0, 'aerator', NULL, 'things/5/aerator.jpg', 'things/5/aerator.jpg', 'things/5/aerator.jpg', 'things/5/aerator.jpg', 1416572077),
(44, 2, 0, 1, 0, 'bag 1', NULL, 'things/5/bag1.jpg', 'things/5/bag1.jpg', 'things/5/bag1.jpg', 'things/5/bag1.jpg', 1416572077),
(45, 3, 0, 1, 0, 'bag 2', NULL, 'things/5/bag2.jpg', 'things/5/bag2.jpg', 'things/5/bag2.jpg', 'things/5/bag2.jpg', 1416572077),
(46, 4, 0, 1, 0, 'bag 3', NULL, 'things/5/bag3.jpg', 'things/5/bag3.jpg', 'things/5/bag3.jpg', 'things/5/bag3.jpg', 1416572077),
(47, 5, 0, 0, 0, 'batteries', NULL, 'things/5/batteries.jpg', 'things/5/batteries.jpg', 'things/5/batteries.jpg', 'things/5/batteries.jpg', 1416572077),
(48, 6, 0, 0, 0, 'belt', NULL, 'things/5/belt.jpg', 'things/5/belt.jpg', 'things/5/belt.jpg', 'things/5/belt.jpg', 1416572077),
(49, 7, 0, 0, 0, 'camcorder', NULL, 'things/5/camcorder.jpg', 'things/5/camcorder.jpg', 'things/5/camcorder.jpg', 'things/5/camcorder.jpg', 1416572077),
(50, 8, 0, 0, 0, 'camera', NULL, 'things/5/camera.jpg', 'things/5/camera.jpg', 'things/5/camera.jpg', 'things/5/camera.jpg', 1416572077),
(51, 9, 0, 0, 0, 'cds', NULL, 'things/5/cds.jpg', 'things/5/cds.jpg', 'things/5/cds.jpg', 'things/5/cds.jpg', 1416572077),
(52, 10, 0, 0, 0, 'contacts', NULL, 'things/5/contacts.jpg', 'things/5/contacts.jpg', 'things/5/contacts.jpg', 'things/5/contacts.jpg', 1416572077),
(53, 11, 0, 0, 0, 'glasses', NULL, 'things/5/glasses.jpg', 'things/5/glasses.jpg', 'things/5/glasses.jpg', 'things/5/glasses.jpg', 1416572077),
(54, 12, 0, 0, 0, 'gym shirts', NULL, 'things/5/gymshirts.jpg', 'things/5/gymshirts.jpg', 'things/5/gymshirts.jpg', 'things/5/gymshirts.jpg', 1416572077),
(55, 13, 0, 0, 0, 'gym shorts', NULL, 'things/5/gymshorts.jpg', 'things/5/gymshorts.jpg', 'things/5/gymshorts.jpg', 'things/5/gymshorts.jpg', 1416572077),
(56, 14, 0, 0, 0, 'hair product', NULL, 'things/5/hairproduct.jpg', 'things/5/hairproduct.jpg', 'things/5/hairproduct.jpg', 'things/5/hairproduct.jpg', 1416572077),
(57, 15, 0, 0, 0, 'hair trimmer', NULL, 'things/5/hairtrimmer.jpg', 'things/5/hairtrimmer.jpg', 'things/5/hairtrimmer.jpg', 'things/5/hairtrimmer.jpg', 1416572077),
(58, 16, 0, 0, 0, 'harddrives', NULL, 'things/5/harddrives.jpg', 'things/5/harddrives.jpg', 'things/5/harddrives.jpg', 'things/5/harddrives.jpg', 1416572077),
(59, 17, 0, 0, 0, 'hat', NULL, 'things/5/hat.jpg', 'things/5/hat.jpg', 'things/5/hat.jpg', 'things/5/hat.jpg', 1416572077),
(60, 18, 0, 0, 0, 'headphones', NULL, 'things/5/headphones.jpg', 'things/5/headphones.jpg', 'things/5/headphones.jpg', 'things/5/headphones.jpg', 1416572077),
(61, 19, 0, 0, 0, 'ipod touch', NULL, 'things/5/ipodtouch.jpg', 'things/5/ipodtouch.jpg', 'things/5/ipodtouch.jpg', 'things/5/ipodtouch.jpg', 1416572077),
(62, 20, 0, 0, 0, 'jacket 1', NULL, 'things/5/jacket1.jpg', 'things/5/jacket1.jpg', 'things/5/jacket1.jpg', 'things/5/jacket1.jpg', 1416572077),
(63, 21, 0, 0, 0, 'jacket 2', NULL, 'things/5/jacket2.jpg', 'things/5/jacket2.jpg', 'things/5/jacket2.jpg', 'things/5/jacket2.jpg', 1416572077),
(64, 22, 0, 0, 0, 'jeans 1', NULL, 'things/5/jeans1.jpg', 'things/5/jeans1.jpg', 'things/5/jeans1.jpg', 'things/5/jeans1.jpg', 1416572077),
(65, 23, 0, 0, 0, 'jeans 2', NULL, 'things/5/jeans2.jpg', 'things/5/jeans2.jpg', 'things/5/jeans2.jpg', 'things/5/jeans2.jpg', 1416572077),
(66, 24, 0, 0, 0, 'jeans 3', NULL, 'things/5/jeans3.jpg', 'things/5/jeans3.jpg', 'things/5/jeans3.jpg', 'things/5/jeans3.jpg', 1416572077),
(67, 25, 0, 0, 0, 'macbook pro', NULL, 'things/5/macbookpro.jpg', 'things/5/macbookpro.jpg', 'things/5/macbookpro.jpg', 'things/5/macbookpro.jpg', 1416572077),
(68, 26, 0, 0, 0, 'monitor adapter', NULL, 'things/5/monitoradapter.jpg', 'things/5/monitoradapter.jpg', 'things/5/monitoradapter.jpg', 'things/5/monitoradapter.jpg', 1416572077),
(69, 27, 0, 0, 0, 'mouse', NULL, 'things/5/mouse.jpg', 'things/5/mouse.jpg', 'things/5/mouse.jpg', 'things/5/mouse.jpg', 1416572077),
(70, 28, 0, 0, 0, 'netbook', NULL, 'things/5/netbook.jpg', 'things/5/netbook.jpg', 'things/5/netbook.jpg', 'things/5/netbook.jpg', 1416572077),
(71, 29, 0, 0, 0, 'nikeplus watch', NULL, 'things/5/nikeplus.jpg', 'things/5/nikeplus.jpg', 'things/5/nikeplus.jpg', 'things/5/nikeplus.jpg', 1416572077),
(72, 30, 0, 0, 0, 'pens', NULL, 'things/5/pens.jpg', 'things/5/pens.jpg', 'things/5/pens.jpg', 'things/5/pens.jpg', 1416572077),
(73, 31, 0, 0, 0, 'phone', NULL, 'things/5/phone.jpg', 'things/5/phone.jpg', 'things/5/phone.jpg', 'things/5/phone.jpg', 1416572077),
(74, 32, 0, 0, 0, 'polo 1', NULL, 'things/5/polo1.jpg', 'things/5/polo1.jpg', 'things/5/polo1.jpg', 'things/5/polo1.jpg', 1416572077),
(75, 33, 0, 0, 0, 'polo 2', NULL, 'things/5/polo2.jpg', 'things/5/polo2.jpg', 'things/5/polo2.jpg', 'things/5/polo2.jpg', 1416572077),
(76, 34, 0, 0, 0, 'polo 3', NULL, 'things/5/polo3.jpg', 'things/5/polo3.jpg', 'things/5/polo3.jpg', 'things/5/polo3.jpg', 1416572077),
(77, 35, 0, 0, 0, 'sd card and cloth', NULL, 'things/5/sdcardcloth.jpg', 'things/5/sdcardcloth.jpg', 'things/5/sdcardcloth.jpg', 'things/5/sdcardcloth.jpg', 1416572077),
(78, 36, 0, 0, 0, 'shirt 1', NULL, 'things/5/shirt1.jpg', 'things/5/shirt1.jpg', 'things/5/shirt1.jpg', 'things/5/shirt1.jpg', 1416572077),
(79, 37, 0, 0, 0, 'shirt 2', NULL, 'things/5/shirt2.jpg', 'things/5/shirt2.jpg', 'things/5/shirt2.jpg', 'things/5/shirt2.jpg', 1416572077),
(80, 38, 0, 0, 0, 'shoes 1', NULL, 'things/5/shoes1.jpg', 'things/5/shoes1.jpg', 'things/5/shoes1.jpg', 'things/5/shoes1.jpg', 1416572077),
(81, 39, 0, 0, 0, 'shoes 2', NULL, 'things/5/shoes2.jpg', 'things/5/shoes2.jpg', 'things/5/shoes2.jpg', 'things/5/shoes2.jpg', 1416572077),
(82, 40, 0, 0, 0, 'shoes 3', NULL, 'things/5/shoes3.jpg', 'things/5/shoes3.jpg', 'things/5/shoes3.jpg', 'things/5/shoes3.jpg', 1416572077),
(83, 41, 0, 0, 0, 'sketchbooks', NULL, 'things/5/sketchbooks.jpg', 'things/5/sketchbooks.jpg', 'things/5/sketchbooks.jpg', 'things/5/sketchbooks.jpg', 1416572077),
(84, 42, 0, 0, 0, 'socks', NULL, 'things/5/socks.jpg', 'things/5/socks.jpg', 'things/5/socks.jpg', 'things/5/socks.jpg', 1416572077),
(85, 43, 0, 0, 0, 'sunglasses', NULL, 'things/5/sunglasses.jpg', 'things/5/sunglasses.jpg', 'things/5/sunglasses.jpg', 'things/5/sunglasses.jpg', 1416572077),
(86, 44, 0, 0, 0, 'toothbrush', NULL, 'things/5/toothbrush.jpg', 'things/5/toothbrush.jpg', 'things/5/toothbrush.jpg', 'things/5/toothbrush.jpg', 1416572077),
(87, 45, 0, 0, 0, 'travel journal', NULL, 'things/5/traveljournal.jpg', 'things/5/traveljournal.jpg', 'things/5/traveljournal.jpg', 'things/5/traveljournal.jpg', 1416572077),
(88, 46, 0, 0, 0, 'tripod', NULL, 'things/5/tripod.jpg', 'things/5/tripod.jpg', 'things/5/tripod.jpg', 'things/5/tripod.jpg', 1416572077),
(89, 47, 0, 0, 0, 'tshirt 1', NULL, 'things/5/tshirt1.jpg', 'things/5/tshirt1.jpg', 'things/5/tshirt1.jpg', 'things/5/tshirt1.jpg', 1416572077),
(90, 48, 0, 0, 0, 'tshirt 2', NULL, 'things/5/tshirt2.jpg', 'things/5/tshirt2.jpg', 'things/5/tshirt2.jpg', 'things/5/tshirt2.jpg', 1416572077),
(91, 49, 0, 0, 0, 'tshirt 3', NULL, 'things/5/tshirt3.jpg', 'things/5/tshirt3.jpg', 'things/5/tshirt3.jpg', 'things/5/tshirt3.jpg', 1416572077),
(92, 50, 0, 0, 0, 'tshirt 4', NULL, 'things/5/tshirt4.jpg', 'things/5/tshirt4.jpg', 'things/5/tshirt4.jpg', 'things/5/tshirt4.jpg', 1416572077),
(93, 51, 0, 0, 0, 'tshirt 5', NULL, 'things/5/tshirt5.jpg', 'things/5/tshirt5.jpg', 'things/5/tshirt5.jpg', 'things/5/tshirt5.jpg', 1416572077),
(94, 52, 0, 0, 0, 'umbrella', NULL, 'things/5/umbrella.jpg', 'things/5/umbrella.jpg', 'things/5/umbrella.jpg', 'things/5/umbrella.jpg', 1416572077),
(95, 53, 0, 0, 0, 'underwear', NULL, 'things/5/underwear.jpg', 'things/5/underwear.jpg', 'things/5/underwear.jpg', 'things/5/underwear.jpg', 1416572077),
(96, 54, 0, 0, 0, 'usb squid', NULL, 'things/5/usbsquid.jpg', 'things/5/usbsquid.jpg', 'things/5/usbsquid.jpg', 'things/5/usbsquid.jpg', 1416572077),
(97, 55, 0, 0, 0, 'wallet', NULL, 'things/5/wallet.jpg', 'things/5/wallet.jpg', 'things/5/wallet.jpg', 'things/5/wallet.jpg', 1416572077),
(98, 56, 0, 0, 0, 'watch', NULL, 'things/5/watch.jpg', 'things/5/watch.jpg', 'things/5/watch.jpg', 'things/5/watch.jpg', 1416572077),
(99, 1, 0, 1, 0, 'Suitcase', NULL, 'things/7/suitcase.jpg', 'things/7/suitcase.jpg', 'things/7/suitcase.jpg', 'things/7/suitcase.jpg', 1416575089),
(100, 2, 0, 0, 0, 'Socks', NULL, 'things/7/adidas-socks.jpg', 'things/7/adidas-socks.jpg', 'things/7/adidas-socks.jpg', 'things/7/adidas-socks.jpg', 1416575089),
(101, 3, 0, 0, 0, 'Socks', NULL, 'things/7/assorted-socks.jpg', 'things/7/assorted-socks.jpg', 'things/7/assorted-socks.jpg', 'things/7/assorted-socks.jpg', 1416575089),
(102, 4, 0, 0, 0, 'Black Jacket', NULL, 'things/7/black-jacket.jpg', 'things/7/black-jacket.jpg', 'things/7/black-jacket.jpg', 'things/7/black-jacket.jpg', 1416575089),
(103, 5, 0, 0, 0, 'Boots', NULL, 'things/7/bootshoes.jpg', 'things/7/bootshoes.jpg', 'things/7/bootshoes.jpg', 'things/7/bootshoes.jpg', 1416575089),
(104, 6, 0, 0, 0, 'Boss Shoes', NULL, 'things/7/boss-shoes.jpg', 'things/7/boss-shoes.jpg', 'things/7/boss-shoes.jpg', 'things/7/boss-shoes.jpg', 1416575089),
(105, 7, 0, 0, 0, 'Bud Spencer T-Shirt', NULL, 'things/7/bud-spencer.JPG', 'things/7/bud-spencer.JPG', 'things/7/bud-spencer.JPG', 'things/7/bud-spencer.JPG', 1416575089),
(106, 8, 0, 0, 0, 'Cardigan', NULL, 'things/7/cardigan.jpg', 'things/7/cardigan.jpg', 'things/7/cardigan.jpg', 'things/7/cardigan.jpg', 1416575089),
(107, 9, 0, 0, 0, 'Glasses', NULL, 'things/7/glasses.jpg', 'things/7/glasses.jpg', 'things/7/glasses.jpg', 'things/7/glasses.jpg', 1416575089),
(108, 10, 0, 0, 0, 'Iphone', NULL, 'things/7/iphone.jpg', 'things/7/iphone.jpg', 'things/7/iphone.jpg', 'things/7/iphone.jpg', 1416575089),
(109, 11, 0, 0, 0, 'IPhone 4', NULL, 'things/7/Iphone-4.jpg', 'things/7/Iphone-4.jpg', 'things/7/Iphone-4.jpg', 'things/7/Iphone-4.jpg', 1416575089),
(110, 12, 0, 0, 0, 'Jacket', NULL, 'things/7/jacket.jpg', 'things/7/jacket.jpg', 'things/7/jacket.jpg', 'things/7/jacket.jpg', 1416575089),
(111, 13, 0, 0, 0, 'Jeans Shorts', NULL, 'things/7/jeans-shorts.jpg', 'things/7/jeans-shorts.jpg', 'things/7/jeans-shorts.jpg', 'things/7/jeans-shorts.jpg', 1416575089),
(112, 14, 0, 0, 0, 'Keys', NULL, 'things/7/keys.jpg', 'things/7/keys.jpg', 'things/7/keys.jpg', 'things/7/keys.jpg', 1416575089),
(113, 15, 0, 0, 0, 'Mobile phone', NULL, 'things/7/maxresdefault.jpg', 'things/7/maxresdefault.jpg', 'things/7/maxresdefault.jpg', 'things/7/maxresdefault.jpg', 1416575089),
(114, 16, 0, 0, 0, 'Minion Shirt', NULL, 'things/7/minion-tshirt.JPG', 'things/7/minion-tshirt.JPG', 'things/7/minion-tshirt.JPG', 'things/7/minion-tshirt.JPG', 1416575089),
(115, 17, 0, 0, 0, 'Pants', NULL, 'things/7/pants.JPG', 'things/7/pants.JPG', 'things/7/pants.JPG', 'things/7/pants.JPG', 1416575089),
(116, 18, 0, 0, 0, 'Parfume', NULL, 'things/7/parfume.png', 'things/7/parfume.png', 'things/7/parfume.png', 'things/7/parfume.png', 1416575089),
(117, 19, 0, 0, 0, 'Pullover', NULL, 'things/7/pullover.JPG', 'things/7/pullover.JPG', 'things/7/pullover.JPG', 'things/7/pullover.JPG', 1416575089),
(118, 20, 0, 0, 0, 'Razor', NULL, 'things/7/razor.jpg', 'things/7/razor.jpg', 'things/7/razor.jpg', 'things/7/razor.jpg', 1416575089),
(119, 21, 0, 0, 0, 'Shoes', NULL, 'things/7/shoes-2.jpg', 'things/7/shoes-2.jpg', 'things/7/shoes-2.jpg', 'things/7/shoes-2.jpg', 1416575089),
(120, 22, 0, 0, 0, 'Shoes', NULL, 'things/7/shoes.jpg', 'things/7/shoes.jpg', 'things/7/shoes.jpg', 'things/7/shoes.jpg', 1416575089),
(121, 23, 0, 0, 0, 'Shorts', NULL, 'things/7/shorts.jpg', 'things/7/shorts.jpg', 'things/7/shorts.jpg', 'things/7/shorts.jpg', 1416575089),
(122, 24, 0, 0, 0, 'Skateboard', NULL, 'things/7/skateboard-2.jpg', 'things/7/skateboard-2.jpg', 'things/7/skateboard-2.jpg', 'things/7/skateboard-2.jpg', 1416575089),
(123, 25, 0, 0, 0, 'Superman Tshirt', NULL, 'things/7/superman-tshirt.JPG', 'things/7/superman-tshirt.JPG', 'things/7/superman-tshirt.JPG', 'things/7/superman-tshirt.JPG', 1416575089),
(124, 26, 0, 0, 0, 'T-Shirt', NULL, 'things/7/t-shirt-nachtschicht.JPG', 'things/7/t-shirt-nachtschicht.JPG', 'things/7/t-shirt-nachtschicht.JPG', 'things/7/t-shirt-nachtschicht.JPG', 1416575089),
(125, 27, 0, 0, 0, 'Underpants', NULL, 'things/7/underpants.jpg', 'things/7/underpants.jpg', 'things/7/underpants.jpg', 'things/7/underpants.jpg', 1416575089),
(126, 28, 0, 0, 0, 'Watch', NULL, 'things/7/watch.png', 'things/7/watch.png', 'things/7/watch.png', 'things/7/watch.png', 1416575089);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`userid` int(10) unsigned NOT NULL,
  `user_group` tinyint(1) unsigned DEFAULT NULL,
  `nick_name` varchar(150) DEFAULT NULL,
  `first_name` varchar(150) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password_hash` varchar(5) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `possession_count` mediumint(8) unsigned DEFAULT NULL,
  `about_me` mediumtext,
  `join_date` int(10) unsigned DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `user_group`, `nick_name`, `first_name`, `last_name`, `email`, `password_hash`, `password`, `birthdate`, `possession_count`, `about_me`, `join_date`) VALUES
(1, 1, 'johnny', 'John', 'Doe', 'john@doe.com', '2aHMR', 'fe5bcf17219babe395998582ba1e912f47ec56cb', '1979-01-01', 16, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 1413535862),
(2, 1, 'Mary', 'Mary', 'Jane', 'mary@jane.com', 'bX!Zf', '1314b42dd25e982b2eefdf8ab675dd12f3a563d2', '1980-02-02', 10, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.   ', 1413535962),
(4, 1, 'Marc', 'Marc', 'Williams', 'marc@williams.com', '#-LtE', 'a7f0111943f85d97b92552f2b7fd27596351a42d', '1956-04-04', 9, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.   ', 1413536892),
(3, 1, 'Colin', 'Peter', 'Gibbons', 'peter@gibbons.com', '^-l#_', '6bbb613eb03f32678e6d48b885318602de901c4a', '1966-05-05', 56, 'Hello! I''m Colin. I''m a professional author, I co-founded a publishing company, and I travel full-time, moving to a new country every four months or so, that country decided by the votes of my readers. I also blog. I''m originally from the Bay Area in California, but spent most of my life in central Missouri; a fairly stark contrast, but one I feel richer for having experienced. In an effort to pursue my world-traveling ambitions while still young enough to make a lot of mistakes and bounce back from them more or less intact, in 2009 I got rid of everything I owned that wouldnÆt fit into a carry-on bag, scaled my business so I could run it from the road, and started up a blog called Exile Lifestyle. I asked my readers to vote on where I would move, and they decided I would call Argentina home for four months. (Text taken from http://exilelifestyle.com/about/.)', 1413536992),
(6, 1, 'Bob', 'Robert', 'Slydell', 'robert@slydell.com', 'Z#T#H', '682d56dbcdacea7fe39dd7b15934d1d20df62609', '1977-06-06', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.   ', 1413537992),
(7, 1, 'Samir', 'Samir', 'Nagheenanajar', 'samir@nagheenanajar.com', '-og!Y', '24d4397b171697488c883a1df706f75c24ffac6a', '1988-07-07', 28, 'I am an Indian American. I was born on February 12, 1972 in Evanston, Illinois. My parents came from India to the United States in 1964. I attended Evanston Township High School. I trained with the American Repertory Theater''s Institute for Advanced Theater Training at Harvard University. I discovered minimalism in 1990 on a boat trip through China.', 1413539992),
(5, 1, 'Komal', 'Das', 'Nil', 'das@nil.com', '_H7DS', '794441b48f31da20c024ab98b10594226159c4cc', '1981-03-03', 7, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.   ', 1413576862);

-- --------------------------------------------------------

--
-- Table structure for table `user_avatars`
--

CREATE TABLE IF NOT EXISTS `user_avatars` (
  `userid` int(10) unsigned NOT NULL,
  `file_name` varchar(250) DEFAULT NULL,
  `file_type` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_avatars`
--

INSERT INTO `user_avatars` (`userid`, `file_name`, `file_type`) VALUES
(1, 'avatars/1.jpg', 'jpg'),
(2, 'avatars/2.jpg', 'jpg'),
(3, 'avatars/3.jpg', 'jpg'),
(4, 'avatars/4.jpg', 'jpg'),
(5, 'avatars/5.jpg', 'jpg'),
(6, 'avatars/6.jpg', 'jpg'),
(7, 'avatars/7.jpg', 'jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE IF NOT EXISTS `user_sessions` (
  `session_id` varchar(40) NOT NULL,
  `userid` int(10) unsigned NOT NULL,
  `nick_name` varchar(150) DEFAULT NULL,
  `securitytoken` varchar(12) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `user_agent` varchar(300) DEFAULT NULL,
  `session_date` int(10) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_things`
--

CREATE TABLE IF NOT EXISTS `user_things` (
  `userid` int(10) unsigned NOT NULL,
  `thingid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_things`
--

INSERT INTO `user_things` (`userid`, `thingid`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 25),
(2, 26),
(3, 43),
(3, 44),
(3, 45),
(3, 46),
(3, 47),
(3, 48),
(3, 49),
(3, 50),
(3, 51),
(3, 52),
(3, 53),
(3, 54),
(3, 55),
(3, 56),
(3, 57),
(3, 58),
(3, 59),
(3, 60),
(3, 61),
(3, 62),
(3, 63),
(3, 64),
(3, 65),
(3, 66),
(3, 67),
(3, 68),
(3, 69),
(3, 70),
(3, 71),
(3, 72),
(3, 73),
(3, 74),
(3, 75),
(3, 76),
(3, 77),
(3, 78),
(3, 79),
(3, 80),
(3, 81),
(3, 82),
(3, 83),
(3, 84),
(3, 85),
(3, 86),
(3, 87),
(3, 88),
(3, 89),
(3, 90),
(3, 91),
(3, 92),
(3, 93),
(3, 94),
(3, 95),
(3, 96),
(3, 97),
(3, 98),
(4, 34),
(4, 35),
(4, 36),
(4, 37),
(4, 38),
(4, 39),
(4, 40),
(4, 41),
(4, 42),
(5, 27),
(5, 28),
(5, 29),
(5, 30),
(5, 31),
(5, 32),
(5, 33),
(7, 99),
(7, 100),
(7, 101),
(7, 102),
(7, 103),
(7, 104),
(7, 105),
(7, 106),
(7, 107),
(7, 108),
(7, 109),
(7, 110),
(7, 111),
(7, 112),
(7, 113),
(7, 114),
(7, 115),
(7, 116),
(7, 117),
(7, 118),
(7, 119),
(7, 120),
(7, 121),
(7, 122),
(7, 123),
(7, 124),
(7, 125),
(7, 126);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `things`
--
ALTER TABLE `things`
 ADD PRIMARY KEY (`thingid`), ADD KEY `CONTAINER` (`container`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`userid`), ADD KEY `email` (`email`);

--
-- Indexes for table `user_avatars`
--
ALTER TABLE `user_avatars`
 ADD PRIMARY KEY (`userid`), ADD KEY `fk_user_avatars_users1_idx` (`userid`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
 ADD PRIMARY KEY (`session_id`,`userid`), ADD KEY `fk_user_sessions_users1_idx` (`userid`);

--
-- Indexes for table `user_things`
--
ALTER TABLE `user_things`
 ADD PRIMARY KEY (`userid`,`thingid`), ADD KEY `fk_user_things_users_idx` (`userid`), ADD KEY `fk_user_things_things1_idx` (`thingid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `things`
--
ALTER TABLE `things`
MODIFY `thingid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=127;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `userid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
