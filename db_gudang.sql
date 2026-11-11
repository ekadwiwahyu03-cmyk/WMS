-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2026 at 10:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12
DROP DATABASE IF EXISTS db_gudang;
CREATE DATABASE db_gudang;
USE db_gudang;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_gudang`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `customer_code` varchar(20) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_code`, `customer_name`, `contact_person`, `phone`, `email`, `address`, `created_at`) VALUES
(1, 'CUST-001', 'PT Maju Jaya Otomotif', 'Andi Pratama', '089876543210', NULL, 'Jakarta Timur', '2026-10-02 02:21:49'),
(2, 'CUST-002', 'CV Sukses Motor Parts', 'Dewi Lestari', '081345678901', NULL, 'Bandung, Jawa Barat', '2026-10-02 02:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `inbound_shipments`
--

CREATE TABLE `inbound_shipments` (
  `inbound_id` int(11) NOT NULL,
  `inbound_number` varchar(50) NOT NULL,
  `po_id` int(11) NOT NULL,
  `expedition_name` varchar(100) DEFAULT NULL,
  `vehicle_number` varchar(30) DEFAULT NULL,
  `driver_name` varchar(100) DEFAULT NULL,
  `shipping_date` date DEFAULT NULL,
  `estimated_arrival` date DEFAULT NULL,
  `actual_arrival` date DEFAULT NULL,
  `status` enum('PREPARING','IN_TRANSIT','ARRIVED','RECEIVED','CANCELLED') NOT NULL DEFAULT 'PREPARING',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inbound_shipments`
--

INSERT INTO `inbound_shipments` (`inbound_id`, `inbound_number`, `po_id`, `expedition_name`, `vehicle_number`, `driver_name`, `shipping_date`, `estimated_arrival`, `actual_arrival`, `status`, `notes`, `created_at`) VALUES
(1, 'INB-202610-001', 1, 'PT Ekspedisi Cepat', 'B 1234 ABC', 'Joko', '2026-10-02', '2026-10-07', NULL, 'IN_TRANSIT', 'Regulator 24V dalam perjalanan', '2026-10-02 02:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `material_requests`
--

CREATE TABLE `material_requests` (
  `request_id` int(11) NOT NULL,
  `request_number` varchar(50) NOT NULL,
  `production_id` int(11) DEFAULT NULL,
  `request_date` date NOT NULL,
  `required_date` date DEFAULT NULL,
  `requested_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `status` enum('DRAFT','SUBMITTED','APPROVED','PARTIALLY_ISSUED','ISSUED','REJECTED','CANCELLED') NOT NULL DEFAULT 'SUBMITTED',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `material_requests`
--

INSERT INTO `material_requests` (`request_id`, `request_number`, `production_id`, `request_date`, `required_date`, `requested_by`, `approved_by`, `approved_at`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'MR-20261002-3209', NULL, '2026-10-02', '2026-10-02', 2, NULL, '2026-10-02 09:42:10', 'ISSUED', 'alternator', '2026-10-02 02:38:16', '2026-10-02 02:42:10');

-- --------------------------------------------------------

--
-- Table structure for table `material_request_details`
--

CREATE TABLE `material_request_details` (
  `request_detail_id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `source_location_id` int(11) DEFAULT NULL,
  `qty_requested` decimal(15,2) NOT NULL,
  `qty_approved` decimal(15,2) NOT NULL DEFAULT 0.00,
  `qty_issued` decimal(15,2) NOT NULL DEFAULT 0.00,
  `unit` varchar(20) NOT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `material_request_details`
--

INSERT INTO `material_request_details` (`request_detail_id`, `request_id`, `product_id`, `source_location_id`, `qty_requested`, `qty_approved`, `qty_issued`, `unit`, `notes`) VALUES
(1, 1, 19, 1, 100.00, 100.00, 100.00, 'PCS', '');

-- --------------------------------------------------------

--
-- Table structure for table `outbound_shipments`
--

CREATE TABLE `outbound_shipments` (
  `outbound_id` int(11) NOT NULL,
  `delivery_number` varchar(50) NOT NULL,
  `sales_order_id` int(11) NOT NULL,
  `expedition_name` varchar(100) DEFAULT NULL,
  `vehicle_number` varchar(30) DEFAULT NULL,
  `driver_name` varchar(100) DEFAULT NULL,
  `shipping_date` date DEFAULT NULL,
  `estimated_arrival` date DEFAULT NULL,
  `delivered_date` date DEFAULT NULL,
  `status` enum('READY_TO_SHIP','SHIPPED','IN_TRANSIT','DELIVERED','RETURNED','CANCELLED') NOT NULL DEFAULT 'READY_TO_SHIP',
  `delivery_address` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `outbound_shipment_details`
--

CREATE TABLE `outbound_shipment_details` (
  `outbound_detail_id` int(11) NOT NULL,
  `outbound_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `source_location_id` int(11) NOT NULL,
  `quantity` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `production_orders`
--

CREATE TABLE `production_orders` (
  `production_id` int(11) NOT NULL,
  `production_number` varchar(50) NOT NULL,
  `product_id` int(11) NOT NULL,
  `target_location_id` int(11) NOT NULL,
  `production_date` date NOT NULL,
  `completed_date` date DEFAULT NULL,
  `qty_plan` decimal(15,2) NOT NULL,
  `qty_result` decimal(15,2) NOT NULL DEFAULT 0.00,
  `qty_reject` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` enum('PLANNED','IN_PROGRESS','QUALITY_CHECK','COMPLETED','REJECTED','CANCELLED') NOT NULL DEFAULT 'PLANNED',
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `sku` varchar(30) NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `product_type` enum('RAW_MATERIAL','FINISHED_GOOD','SUPPORTING_MATERIAL') NOT NULL DEFAULT 'RAW_MATERIAL',
  `unit` varchar(20) NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `selling_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `minimum_stock` decimal(15,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `sku`, `product_name`, `product_type`, `unit`, `purchase_price`, `selling_price`, `minimum_stock`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'RM-CU-001', 'Kawat Tembaga Email 0.90 mm', 'RAW_MATERIAL', 'KG', 0.00, 0.00, 300.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(2, 'RM-CU-002', 'Kawat Tembaga Email 1.00 mm', 'RAW_MATERIAL', 'KG', 0.00, 0.00, 250.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(3, 'RM-CU-003', 'Kawat Tembaga Email 1.10 mm', 'RAW_MATERIAL', 'KG', 0.00, 0.00, 200.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(4, 'RM-CU-004', 'Kawat Tembaga Email 1.20 mm', 'RAW_MATERIAL', 'KG', 0.00, 0.00, 180.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(5, 'RM-FE-001', 'Plat Baja Silikon Laminasi Stator', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 800.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(6, 'RM-FE-002', 'Plat Baja Silikon Laminasi Rotor', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 700.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(7, 'RM-FE-003', 'Claw Pole Rotor', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 600.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(8, 'RM-ME-001', 'Poros Rotor', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 500.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(9, 'RM-ME-002', 'Pulley V-Belt 6PK', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 450.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(10, 'RM-ME-003', 'Pulley Serpentine 7PK', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 300.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(11, 'RM-ME-004', 'Rumah Depan Alternator Aluminium', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 400.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(12, 'RM-ME-005', 'Rumah Belakang Alternator Aluminium', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 400.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(13, 'RM-ME-006', 'Kipas Pendingin Alternator', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 450.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(14, 'RM-ME-007', 'Spacer Rotor', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 350.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(15, 'RM-ME-008', 'Baut Flange M6 x 20', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 3000.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(16, 'RM-ME-009', 'Baut Flange M8 x 25', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 2500.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(17, 'RM-ME-010', 'Mur Flange M6', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 3000.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(18, 'RM-ME-011', 'Mur Flange M8', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 2500.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(19, 'RM-ME-012', 'Washer M6', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 3500.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(20, 'RM-ME-013', 'Washer M8', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 3000.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(21, 'RM-BR-001', 'Bearing Depan 6303', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 400.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(22, 'RM-BR-002', 'Bearing Belakang 6202', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 400.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(23, 'RM-EL-001', 'Dioda Positif 50A', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 1000.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(24, 'RM-EL-002', 'Dioda Negatif 50A', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 1000.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(25, 'RM-EL-003', 'Dioda Trio', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 600.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(26, 'RM-EL-004', 'IC Voltage Regulator 12V', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 300.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(27, 'RM-EL-005', 'IC Voltage Regulator 24V', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 250.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(28, 'RM-EL-006', 'Brush Holder Assy', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 350.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(29, 'RM-EL-007', 'Carbon Brush Set', 'RAW_MATERIAL', 'SET', 0.00, 0.00, 400.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(30, 'RM-EL-008', 'Slip Ring Rotor', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 300.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(31, 'RM-EL-009', 'Terminal B+', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 500.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(32, 'RM-EL-010', 'Terminal IG / L', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 500.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(33, 'RM-EL-011', 'Konektor 2 Pin', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 600.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(34, 'RM-EL-012', 'Konektor 3 Pin', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 200.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(35, 'RM-EL-013', 'Kabel Output B+ 8 AWG', 'RAW_MATERIAL', 'METER', 0.00, 0.00, 150.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(36, 'RM-EL-014', 'Kabel Field Coil 18 AWG', 'RAW_MATERIAL', 'METER', 0.00, 0.00, 150.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(37, 'RM-IN-001', 'Varnish Isolasi Kumparan', 'RAW_MATERIAL', 'LITER', 0.00, 0.00, 80.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(38, 'RM-IN-002', 'Kertas Isolasi Slot', 'RAW_MATERIAL', 'METER', 0.00, 0.00, 200.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(39, 'RM-IN-003', 'Sleeve Isolasi', 'RAW_MATERIAL', 'METER', 0.00, 0.00, 180.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(40, 'RM-IN-004', 'Resin Epoxy', 'RAW_MATERIAL', 'KG', 0.00, 0.00, 100.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(41, 'RM-IN-005', 'Heat Shrink Tube', 'RAW_MATERIAL', 'METER', 0.00, 0.00, 150.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(42, 'RM-PK-001', 'Kardus Alternator Kecil', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 400.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(43, 'RM-PK-002', 'Kardus Alternator Sedang', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 350.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(44, 'RM-PK-003', 'Kardus Alternator Besar', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 250.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(45, 'RM-PK-004', 'Bubble Wrap', 'RAW_MATERIAL', 'METER', 0.00, 0.00, 300.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(46, 'RM-PK-005', 'Label Barcode Produk', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 1200.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(47, 'RM-CH-001', 'Gemuk Bearing', 'RAW_MATERIAL', 'KG', 0.00, 0.00, 30.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(48, 'RM-CH-002', 'Thread Locker', 'RAW_MATERIAL', 'LITER', 0.00, 0.00, 20.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(49, 'RM-QC-001', 'Seal QC / Stiker Lulus Uji', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 1000.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(50, 'RM-QC-002', 'Terminal Uji Output Alternator', 'RAW_MATERIAL', 'PCS', 0.00, 0.00, 300.00, 'Data contoh part produksi alternator mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(51, 'FG-ALT-12-45', 'Alternator 12V 45A Compact', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(52, 'FG-ALT-12-55', 'Alternator 12V 55A Standard', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(53, 'FG-ALT-12-60', 'Alternator 12V 60A MPV', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(54, 'FG-ALT-12-65', 'Alternator 12V 65A Sedan', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(55, 'FG-ALT-12-70', 'Alternator 12V 70A SUV', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(56, 'FG-ALT-12-75', 'Alternator 12V 75A Diesel', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(57, 'FG-ALT-12-80', 'Alternator 12V 80A Van', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(58, 'FG-ALT-12-90', 'Alternator 12V 90A Pickup', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(59, 'FG-ALT-12-100', 'Alternator 12V 100A Premium', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(60, 'FG-ALT-12-110', 'Alternator 12V 110A Heavy Duty', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(61, 'FG-ALT-12-120', 'Alternator 12V 120A Fleet', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(62, 'FG-ALT-12-130', 'Alternator 12V 130A SUV Premium', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(63, 'FG-ALT-12-150', 'Alternator 12V 150A Commercial', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 50.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(64, 'FG-ALT-24-35', 'Alternator 24V 35A Light Truck', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 30.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(65, 'FG-ALT-24-50', 'Alternator 24V 50A Light Truck', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 30.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(66, 'FG-ALT-24-60', 'Alternator 24V 60A Bus', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 30.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(67, 'FG-ALT-24-70', 'Alternator 24V 70A Bus', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 30.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(68, 'FG-ALT-24-80', 'Alternator 24V 80A Truck', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 30.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(69, 'FG-ALT-24-100', 'Alternator 24V 100A Truck Heavy', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 30.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49'),
(70, 'FG-ALT-24-120', 'Alternator 24V 120A Bus Heavy', 'FINISHED_GOOD', 'PCS', 0.00, 0.00, 30.00, 'Produk jadi alternator/dinamo mobil', 1, '2026-10-02 02:21:49', '2026-10-02 02:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `product_bom`
--

CREATE TABLE `product_bom` (
  `bom_id` int(11) NOT NULL,
  `finished_product_id` int(11) NOT NULL,
  `component_product_id` int(11) NOT NULL,
  `qty_required` decimal(15,2) NOT NULL,
  `unit` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_bom`
--

INSERT INTO `product_bom` (`bom_id`, `finished_product_id`, `component_product_id`, `qty_required`, `unit`) VALUES
(1, 51, 21, 1.00, 'PCS'),
(2, 51, 22, 1.00, 'PCS'),
(3, 51, 1, 1.20, 'KG'),
(4, 51, 26, 1.00, 'PCS'),
(5, 51, 27, 0.00, 'PCS'),
(6, 51, 28, 1.00, 'PCS'),
(7, 51, 29, 1.00, 'PCS'),
(8, 51, 5, 1.00, 'PCS'),
(9, 51, 6, 1.00, 'PCS'),
(10, 51, 8, 1.00, 'PCS'),
(11, 52, 21, 1.00, 'PCS'),
(12, 52, 22, 1.00, 'PCS'),
(13, 52, 1, 1.20, 'KG'),
(14, 52, 26, 1.00, 'PCS'),
(15, 52, 27, 0.00, 'PCS'),
(16, 52, 28, 1.00, 'PCS'),
(17, 52, 29, 1.00, 'PCS'),
(18, 52, 5, 1.00, 'PCS'),
(19, 52, 6, 1.00, 'PCS'),
(20, 52, 8, 1.00, 'PCS'),
(21, 53, 21, 1.00, 'PCS'),
(22, 53, 22, 1.00, 'PCS'),
(23, 53, 1, 1.20, 'KG'),
(24, 53, 26, 1.00, 'PCS'),
(25, 53, 27, 0.00, 'PCS'),
(26, 53, 28, 1.00, 'PCS'),
(27, 53, 29, 1.00, 'PCS'),
(28, 53, 5, 1.00, 'PCS'),
(29, 53, 6, 1.00, 'PCS'),
(30, 53, 8, 1.00, 'PCS'),
(31, 54, 21, 1.00, 'PCS'),
(32, 54, 22, 1.00, 'PCS'),
(33, 54, 1, 1.20, 'KG'),
(34, 54, 26, 1.00, 'PCS'),
(35, 54, 27, 0.00, 'PCS'),
(36, 54, 28, 1.00, 'PCS'),
(37, 54, 29, 1.00, 'PCS'),
(38, 54, 5, 1.00, 'PCS'),
(39, 54, 6, 1.00, 'PCS'),
(40, 54, 8, 1.00, 'PCS'),
(41, 55, 21, 1.00, 'PCS'),
(42, 55, 22, 1.00, 'PCS'),
(43, 55, 1, 1.20, 'KG'),
(44, 55, 26, 1.00, 'PCS'),
(45, 55, 27, 0.00, 'PCS'),
(46, 55, 28, 1.00, 'PCS'),
(47, 55, 29, 1.00, 'PCS'),
(48, 55, 5, 1.00, 'PCS'),
(49, 55, 6, 1.00, 'PCS'),
(50, 55, 8, 1.00, 'PCS'),
(51, 56, 21, 1.00, 'PCS'),
(52, 56, 22, 1.00, 'PCS'),
(53, 56, 1, 1.20, 'KG'),
(54, 56, 26, 1.00, 'PCS'),
(55, 56, 27, 0.00, 'PCS'),
(56, 56, 28, 1.00, 'PCS'),
(57, 56, 29, 1.00, 'PCS'),
(58, 56, 5, 1.00, 'PCS'),
(59, 56, 6, 1.00, 'PCS'),
(60, 56, 8, 1.00, 'PCS'),
(61, 57, 21, 1.00, 'PCS'),
(62, 57, 22, 1.00, 'PCS'),
(63, 57, 1, 1.20, 'KG'),
(64, 57, 26, 1.00, 'PCS'),
(65, 57, 27, 0.00, 'PCS'),
(66, 57, 28, 1.00, 'PCS'),
(67, 57, 29, 1.00, 'PCS'),
(68, 57, 5, 1.00, 'PCS'),
(69, 57, 6, 1.00, 'PCS'),
(70, 57, 8, 1.00, 'PCS'),
(71, 58, 21, 1.00, 'PCS'),
(72, 58, 22, 1.00, 'PCS'),
(73, 58, 1, 1.20, 'KG'),
(74, 58, 26, 1.00, 'PCS'),
(75, 58, 27, 0.00, 'PCS'),
(76, 58, 28, 1.00, 'PCS'),
(77, 58, 29, 1.00, 'PCS'),
(78, 58, 5, 1.00, 'PCS'),
(79, 58, 6, 1.00, 'PCS'),
(80, 58, 8, 1.00, 'PCS'),
(81, 59, 21, 1.00, 'PCS'),
(82, 59, 22, 1.00, 'PCS'),
(83, 59, 1, 1.20, 'KG'),
(84, 59, 26, 1.00, 'PCS'),
(85, 59, 27, 0.00, 'PCS'),
(86, 59, 28, 1.00, 'PCS'),
(87, 59, 29, 1.00, 'PCS'),
(88, 59, 5, 1.00, 'PCS'),
(89, 59, 6, 1.00, 'PCS'),
(90, 59, 8, 1.00, 'PCS'),
(91, 60, 21, 1.00, 'PCS'),
(92, 60, 22, 1.00, 'PCS'),
(93, 60, 1, 1.20, 'KG'),
(94, 60, 26, 1.00, 'PCS'),
(95, 60, 27, 0.00, 'PCS'),
(96, 60, 28, 1.00, 'PCS'),
(97, 60, 29, 1.00, 'PCS'),
(98, 60, 5, 1.00, 'PCS'),
(99, 60, 6, 1.00, 'PCS'),
(100, 60, 8, 1.00, 'PCS'),
(101, 61, 21, 1.00, 'PCS'),
(102, 61, 22, 1.00, 'PCS'),
(103, 61, 1, 1.20, 'KG'),
(104, 61, 26, 1.00, 'PCS'),
(105, 61, 27, 0.00, 'PCS'),
(106, 61, 28, 1.00, 'PCS'),
(107, 61, 29, 1.00, 'PCS'),
(108, 61, 5, 1.00, 'PCS'),
(109, 61, 6, 1.00, 'PCS'),
(110, 61, 8, 1.00, 'PCS'),
(111, 62, 21, 1.00, 'PCS'),
(112, 62, 22, 1.00, 'PCS'),
(113, 62, 1, 1.20, 'KG'),
(114, 62, 26, 1.00, 'PCS'),
(115, 62, 27, 0.00, 'PCS'),
(116, 62, 28, 1.00, 'PCS'),
(117, 62, 29, 1.00, 'PCS'),
(118, 62, 5, 1.00, 'PCS'),
(119, 62, 6, 1.00, 'PCS'),
(120, 62, 8, 1.00, 'PCS'),
(121, 63, 21, 1.00, 'PCS'),
(122, 63, 22, 1.00, 'PCS'),
(123, 63, 1, 1.20, 'KG'),
(124, 63, 26, 1.00, 'PCS'),
(125, 63, 27, 0.00, 'PCS'),
(126, 63, 28, 1.00, 'PCS'),
(127, 63, 29, 1.00, 'PCS'),
(128, 63, 5, 1.00, 'PCS'),
(129, 63, 6, 1.00, 'PCS'),
(130, 63, 8, 1.00, 'PCS'),
(131, 64, 21, 1.00, 'PCS'),
(132, 64, 22, 1.00, 'PCS'),
(133, 64, 1, 1.20, 'KG'),
(134, 64, 26, 0.00, 'PCS'),
(135, 64, 27, 1.00, 'PCS'),
(136, 64, 28, 1.00, 'PCS'),
(137, 64, 29, 1.00, 'PCS'),
(138, 64, 5, 1.00, 'PCS'),
(139, 64, 6, 1.00, 'PCS'),
(140, 64, 8, 1.00, 'PCS'),
(141, 65, 21, 1.00, 'PCS'),
(142, 65, 22, 1.00, 'PCS'),
(143, 65, 1, 1.20, 'KG'),
(144, 65, 26, 0.00, 'PCS'),
(145, 65, 27, 1.00, 'PCS'),
(146, 65, 28, 1.00, 'PCS'),
(147, 65, 29, 1.00, 'PCS'),
(148, 65, 5, 1.00, 'PCS'),
(149, 65, 6, 1.00, 'PCS'),
(150, 65, 8, 1.00, 'PCS'),
(151, 66, 21, 1.00, 'PCS'),
(152, 66, 22, 1.00, 'PCS'),
(153, 66, 1, 1.20, 'KG'),
(154, 66, 26, 0.00, 'PCS'),
(155, 66, 27, 1.00, 'PCS'),
(156, 66, 28, 1.00, 'PCS'),
(157, 66, 29, 1.00, 'PCS'),
(158, 66, 5, 1.00, 'PCS'),
(159, 66, 6, 1.00, 'PCS'),
(160, 66, 8, 1.00, 'PCS'),
(161, 67, 21, 1.00, 'PCS'),
(162, 67, 22, 1.00, 'PCS'),
(163, 67, 1, 1.20, 'KG'),
(164, 67, 26, 0.00, 'PCS'),
(165, 67, 27, 1.00, 'PCS'),
(166, 67, 28, 1.00, 'PCS'),
(167, 67, 29, 1.00, 'PCS'),
(168, 67, 5, 1.00, 'PCS'),
(169, 67, 6, 1.00, 'PCS'),
(170, 67, 8, 1.00, 'PCS'),
(171, 68, 21, 1.00, 'PCS'),
(172, 68, 22, 1.00, 'PCS'),
(173, 68, 1, 1.20, 'KG'),
(174, 68, 26, 0.00, 'PCS'),
(175, 68, 27, 1.00, 'PCS'),
(176, 68, 28, 1.00, 'PCS'),
(177, 68, 29, 1.00, 'PCS'),
(178, 68, 5, 1.00, 'PCS'),
(179, 68, 6, 1.00, 'PCS'),
(180, 68, 8, 1.00, 'PCS'),
(181, 69, 21, 1.00, 'PCS'),
(182, 69, 22, 1.00, 'PCS'),
(183, 69, 1, 1.20, 'KG'),
(184, 69, 26, 0.00, 'PCS'),
(185, 69, 27, 1.00, 'PCS'),
(186, 69, 28, 1.00, 'PCS'),
(187, 69, 29, 1.00, 'PCS'),
(188, 69, 5, 1.00, 'PCS'),
(189, 69, 6, 1.00, 'PCS'),
(190, 69, 8, 1.00, 'PCS'),
(191, 70, 21, 1.00, 'PCS'),
(192, 70, 22, 1.00, 'PCS'),
(193, 70, 1, 1.20, 'KG'),
(194, 70, 26, 0.00, 'PCS'),
(195, 70, 27, 1.00, 'PCS'),
(196, 70, 28, 1.00, 'PCS'),
(197, 70, 29, 1.00, 'PCS'),
(198, 70, 5, 1.00, 'PCS'),
(199, 70, 6, 1.00, 'PCS'),
(200, 70, 8, 1.00, 'PCS');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `po_id` int(11) NOT NULL,
  `po_number` varchar(50) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `expected_arrival` date DEFAULT NULL,
  `status` enum('DRAFT','APPROVED','ORDERED','PARTIAL_RECEIVED','RECEIVED','CANCELLED') NOT NULL DEFAULT 'DRAFT',
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` (`po_id`, `po_number`, `supplier_id`, `order_date`, `expected_arrival`, `status`, `notes`, `created_by`, `created_at`) VALUES
(1, 'PO-202610-001', 1, '2026-10-02', '2026-10-07', 'ORDERED', 'Pengadaan material produksi alternator', NULL, '2026-10-02 02:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_details`
--

CREATE TABLE `purchase_order_details` (
  `po_detail_id` int(11) NOT NULL,
  `po_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty_ordered` decimal(15,2) NOT NULL,
  `qty_received` decimal(15,2) NOT NULL DEFAULT 0.00,
  `unit_price` decimal(15,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_order_details`
--

INSERT INTO `purchase_order_details` (`po_detail_id`, `po_id`, `product_id`, `qty_ordered`, `qty_received`, `unit_price`) VALUES
(1, 1, 27, 500.00, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `sales_orders`
--

CREATE TABLE `sales_orders` (
  `sales_order_id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `required_date` date DEFAULT NULL,
  `status` enum('DRAFT','CONFIRMED','ALLOCATED','PACKING','SHIPPED','DELIVERED','CANCELLED') NOT NULL DEFAULT 'DRAFT',
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_details`
--

CREATE TABLE `sales_order_details` (
  `sales_order_detail_id` int(11) NOT NULL,
  `sales_order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty_ordered` decimal(15,2) NOT NULL,
  `qty_delivered` decimal(15,2) NOT NULL DEFAULT 0.00,
  `unit_price` decimal(15,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_balances`
--

CREATE TABLE `stock_balances` (
  `stock_id` bigint(20) NOT NULL,
  `product_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `qty_on_hand` decimal(15,2) NOT NULL DEFAULT 0.00,
  `qty_reserved` decimal(15,2) NOT NULL DEFAULT 0.00,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_balances`
--

INSERT INTO `stock_balances` (`stock_id`, `product_id`, `location_id`, `qty_on_hand`, `qty_reserved`, `updated_at`) VALUES
(1, 1, 1, 1200.00, 0.00, '2026-10-02 02:21:49'),
(2, 2, 1, 980.00, 0.00, '2026-10-02 02:21:49'),
(3, 3, 1, 740.00, 0.00, '2026-10-02 02:21:49'),
(4, 4, 1, 620.00, 0.00, '2026-10-02 02:21:49'),
(5, 5, 1, 3200.00, 0.00, '2026-10-02 02:21:49'),
(6, 6, 1, 2800.00, 0.00, '2026-10-02 02:21:49'),
(7, 7, 1, 2500.00, 0.00, '2026-10-02 02:21:49'),
(8, 8, 1, 2100.00, 0.00, '2026-10-02 02:21:49'),
(9, 9, 1, 1850.00, 0.00, '2026-10-02 02:21:49'),
(10, 10, 1, 900.00, 0.00, '2026-10-02 02:21:49'),
(11, 11, 1, 1500.00, 0.00, '2026-10-02 02:21:49'),
(12, 12, 1, 1420.00, 0.00, '2026-10-02 02:21:49'),
(13, 13, 1, 1800.00, 0.00, '2026-10-02 02:21:49'),
(14, 14, 1, 1350.00, 0.00, '2026-10-02 02:21:49'),
(15, 15, 1, 15000.00, 0.00, '2026-10-02 02:21:49'),
(16, 16, 1, 12000.00, 0.00, '2026-10-02 02:21:49'),
(17, 17, 1, 14000.00, 0.00, '2026-10-02 02:21:49'),
(18, 18, 1, 11000.00, 0.00, '2026-10-02 02:21:49'),
(19, 19, 1, 17900.00, 0.00, '2026-10-02 02:42:10'),
(20, 20, 1, 15000.00, 0.00, '2026-10-02 02:21:49'),
(21, 21, 1, 1800.00, 0.00, '2026-10-02 02:21:49'),
(22, 22, 1, 1700.00, 0.00, '2026-10-02 02:21:49'),
(23, 23, 1, 4200.00, 0.00, '2026-10-02 02:21:49'),
(24, 24, 1, 4200.00, 0.00, '2026-10-02 02:21:49'),
(25, 25, 1, 2500.00, 0.00, '2026-10-02 02:21:49'),
(26, 26, 1, 900.00, 0.00, '2026-10-02 02:21:49'),
(27, 27, 1, 90.00, 0.00, '2026-10-02 02:21:49'),
(28, 28, 1, 1100.00, 0.00, '2026-10-02 02:21:49'),
(29, 29, 1, 1300.00, 0.00, '2026-10-02 02:21:49'),
(30, 30, 1, 1000.00, 0.00, '2026-10-02 02:21:49'),
(31, 31, 1, 2200.00, 0.00, '2026-10-02 02:21:49'),
(32, 32, 1, 2000.00, 0.00, '2026-10-02 02:21:49'),
(33, 33, 1, 2500.00, 0.00, '2026-10-02 02:21:49'),
(34, 34, 1, 55.00, 0.00, '2026-10-02 02:21:49'),
(35, 35, 1, 600.00, 0.00, '2026-10-02 02:21:49'),
(36, 36, 1, 500.00, 0.00, '2026-10-02 02:21:49'),
(37, 37, 1, 280.00, 0.00, '2026-10-02 02:21:49'),
(38, 38, 1, 850.00, 0.00, '2026-10-02 02:21:49'),
(39, 39, 1, 650.00, 0.00, '2026-10-02 02:21:49'),
(40, 40, 1, 320.00, 0.00, '2026-10-02 02:21:49'),
(41, 41, 1, 500.00, 0.00, '2026-10-02 02:21:49'),
(42, 42, 1, 1500.00, 0.00, '2026-10-02 02:21:49'),
(43, 43, 1, 1200.00, 0.00, '2026-10-02 02:21:49'),
(44, 44, 1, 750.00, 0.00, '2026-10-02 02:21:49'),
(45, 45, 1, 1000.00, 0.00, '2026-10-02 02:21:49'),
(46, 46, 1, 5000.00, 0.00, '2026-10-02 02:21:49'),
(47, 47, 1, 75.00, 0.00, '2026-10-02 02:21:49'),
(48, 48, 1, 40.00, 0.00, '2026-10-02 02:21:49'),
(49, 49, 1, 5000.00, 0.00, '2026-10-02 02:21:49'),
(50, 50, 1, 450.00, 0.00, '2026-10-02 02:21:49'),
(64, 51, 3, 500.00, 30.00, '2026-10-02 02:21:49'),
(65, 52, 3, 420.00, 0.00, '2026-10-02 02:21:49'),
(66, 53, 3, 380.00, 0.00, '2026-10-02 02:21:49'),
(67, 54, 3, 350.00, 0.00, '2026-10-02 02:21:49'),
(68, 55, 3, 280.00, 0.00, '2026-10-02 02:21:49'),
(69, 56, 3, 240.00, 0.00, '2026-10-02 02:21:49'),
(70, 57, 3, 210.00, 0.00, '2026-10-02 02:21:49'),
(71, 58, 3, 190.00, 0.00, '2026-10-02 02:21:49'),
(72, 59, 3, 160.00, 0.00, '2026-10-02 02:21:49'),
(73, 60, 3, 130.00, 0.00, '2026-10-02 02:21:49'),
(74, 61, 3, 110.00, 0.00, '2026-10-02 02:21:49'),
(75, 62, 3, 90.00, 0.00, '2026-10-02 02:21:49'),
(76, 63, 3, 70.00, 0.00, '2026-10-02 02:21:49'),
(77, 64, 3, 65.00, 0.00, '2026-10-02 02:21:49'),
(78, 65, 3, 55.00, 0.00, '2026-10-02 02:21:49'),
(79, 66, 3, 45.00, 0.00, '2026-10-02 02:21:49'),
(80, 67, 3, 35.00, 0.00, '2026-10-02 02:21:49'),
(81, 68, 3, 28.00, 0.00, '2026-10-02 02:21:49'),
(82, 69, 3, 18.00, 0.00, '2026-10-02 02:21:49'),
(83, 70, 3, 12.00, 5.00, '2026-10-02 02:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `stock_transactions`
--

CREATE TABLE `stock_transactions` (
  `transaction_id` bigint(20) NOT NULL,
  `transaction_number` varchar(50) NOT NULL,
  `product_id` int(11) NOT NULL,
  `from_location_id` int(11) DEFAULT NULL,
  `to_location_id` int(11) DEFAULT NULL,
  `transaction_type` enum('PURCHASE_RECEIPT','PRODUCTION_RECEIPT','PRODUCTION_ISSUE','SALES_ISSUE','TRANSFER_OUT','TRANSFER_IN','ADJUSTMENT_IN','ADJUSTMENT_OUT','RETURN_CUSTOMER','RETURN_SUPPLIER') NOT NULL,
  `quantity` decimal(15,2) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `transaction_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_transactions`
--

INSERT INTO `stock_transactions` (`transaction_id`, `transaction_number`, `product_id`, `from_location_id`, `to_location_id`, `transaction_type`, `quantity`, `reference_no`, `notes`, `created_by`, `transaction_date`) VALUES
(1, 'TRX-PRD-20261002044210-132', 19, 1, NULL, 'PRODUCTION_ISSUE', 100.00, 'MR-20261002-3209', 'Material dikeluarkan untuk produksi', NULL, '2026-10-02 09:42:10');

-- --------------------------------------------------------

--
-- Table structure for table `storage_locations`
--

CREATE TABLE `storage_locations` (
  `location_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `zone` varchar(20) DEFAULT NULL,
  `rack` varchar(20) DEFAULT NULL,
  `bin_code` varchar(30) NOT NULL,
  `location_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `storage_locations`
--

INSERT INTO `storage_locations` (`location_id`, `warehouse_id`, `zone`, `rack`, `bin_code`, `location_name`, `created_at`) VALUES
(1, 1, 'RM', '01', 'RM-01-01', 'Gudang Bahan Baku', '2026-10-02 02:21:49'),
(2, 1, 'WIP', '01', 'WIP-01-01', 'Area Work In Process', '2026-10-02 02:21:49'),
(3, 1, 'FG', '01', 'FG-01-01', 'Gudang Barang Jadi', '2026-10-02 02:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_code` varchar(20) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_code`, `supplier_name`, `contact_person`, `phone`, `email`, `address`, `created_at`) VALUES
(1, 'SUP-001', 'PT Sumber Material Indonesia', 'Budi Santoso', '081234567890', NULL, 'Karawang, Jawa Barat', '2026-10-02 02:21:49'),
(2, 'SUP-002', 'PT Elektronik Otomotif Nusantara', 'Rina Kusuma', '081298765432', NULL, 'Tangerang, Banten', '2026-10-02 02:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('ADMIN','WAREHOUSE','PURCHASING','PRODUCTION','SALES','VIEWER') NOT NULL DEFAULT 'VIEWER',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `username`, `password_hash`, `role`, `is_active`, `created_at`, `updated_at`) VALUES
(2, 'Andi', 'AndiOP', '$2y$10$RONCxibWJAYoEnwniIK34OCjyA3zHOxXLqlVa3vClNzyYA6Vk6NXy', 'PRODUCTION', 1, '2026-10-02 02:35:02', '2026-10-02 02:36:12'),
(3, 'Muhamad Khoirul Anam', 'ekadwiwahyu03@gmail.com', '$2y$10$9zBHK8b75Zj2JpZdo6IVVuf5U7Jp519p8Q7EQ3Th/PSMIhOnPLCZS', 'PRODUCTION', 1, '2026-10-24 20:17:43', '2026-10-24 20:17:43');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_material_requests`
-- (See below for the actual view)
--
CREATE TABLE `vw_material_requests` (
`request_id` int(11)
,`request_number` varchar(50)
,`request_date` date
,`required_date` date
,`status` enum('DRAFT','SUBMITTED','APPROVED','PARTIALLY_ISSUED','ISSUED','REJECTED','CANCELLED')
,`notes` text
,`pemohon` varchar(100)
,`penyetuju` varchar(100)
,`jumlah_jenis_material` bigint(21)
,`total_diminta` decimal(37,2)
,`total_dikeluarkan` decimal(37,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_stock_report`
-- (See below for the actual view)
--
CREATE TABLE `vw_stock_report` (
`product_id` int(11)
,`sku` varchar(30)
,`product_name` varchar(150)
,`product_type` enum('RAW_MATERIAL','FINISHED_GOOD','SUPPORTING_MATERIAL')
,`unit` varchar(20)
,`warehouse_name` varchar(100)
,`bin_code` varchar(30)
,`stok_fisik` decimal(15,2)
,`stok_dipesan` decimal(15,2)
,`stok_tersedia` decimal(16,2)
,`minimum_stock` decimal(15,2)
,`status_stok` varchar(22)
);

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `warehouse_id` int(11) NOT NULL,
  `warehouse_code` varchar(20) NOT NULL,
  `warehouse_name` varchar(100) NOT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`warehouse_id`, `warehouse_code`, `warehouse_name`, `address`, `created_at`) VALUES
(1, 'GDG-01', 'Gudang Utama BD Gudang', 'Bekasi, Jawa Barat', '2026-10-02 02:21:49');

-- --------------------------------------------------------

--
-- Structure for view `vw_material_requests`
--
DROP TABLE IF EXISTS `vw_material_requests`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_material_requests`  AS SELECT `mr`.`request_id` AS `request_id`, `mr`.`request_number` AS `request_number`, `mr`.`request_date` AS `request_date`, `mr`.`required_date` AS `required_date`, `mr`.`status` AS `status`, `mr`.`notes` AS `notes`, `requester`.`full_name` AS `pemohon`, `approver`.`full_name` AS `penyetuju`, count(`mrd`.`request_detail_id`) AS `jumlah_jenis_material`, coalesce(sum(`mrd`.`qty_requested`),0) AS `total_diminta`, coalesce(sum(`mrd`.`qty_issued`),0) AS `total_dikeluarkan` FROM (((`material_requests` `mr` join `users` `requester` on(`requester`.`user_id` = `mr`.`requested_by`)) left join `users` `approver` on(`approver`.`user_id` = `mr`.`approved_by`)) left join `material_request_details` `mrd` on(`mrd`.`request_id` = `mr`.`request_id`)) GROUP BY `mr`.`request_id` ;

-- --------------------------------------------------------

--
-- Structure for view `vw_stock_report`
--
DROP TABLE IF EXISTS `vw_stock_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_stock_report`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`sku` AS `sku`, `p`.`product_name` AS `product_name`, `p`.`product_type` AS `product_type`, `p`.`unit` AS `unit`, `w`.`warehouse_name` AS `warehouse_name`, `l`.`bin_code` AS `bin_code`, `s`.`qty_on_hand` AS `stok_fisik`, `s`.`qty_reserved` AS `stok_dipesan`, `s`.`qty_on_hand`- `s`.`qty_reserved` AS `stok_tersedia`, `p`.`minimum_stock` AS `minimum_stock`, CASE WHEN `s`.`qty_on_hand` - `s`.`qty_reserved` <= `p`.`minimum_stock` THEN 'HAMPIR HABIS / REORDER' WHEN `s`.`qty_on_hand` - `s`.`qty_reserved` <= `p`.`minimum_stock` * 2 THEN 'PERLU DIPANTAU' ELSE 'AMAN' END AS `status_stok` FROM (((`stock_balances` `s` join `products` `p` on(`p`.`product_id` = `s`.`product_id`)) join `storage_locations` `l` on(`l`.`location_id` = `s`.`location_id`)) join `warehouses` `w` on(`w`.`warehouse_id` = `l`.`warehouse_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `customer_code` (`customer_code`);

--
-- Indexes for table `inbound_shipments`
--
ALTER TABLE `inbound_shipments`
  ADD PRIMARY KEY (`inbound_id`),
  ADD UNIQUE KEY `inbound_number` (`inbound_number`),
  ADD KEY `fk_inbound_po` (`po_id`);

--
-- Indexes for table `material_requests`
--
ALTER TABLE `material_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD UNIQUE KEY `request_number` (`request_number`),
  ADD KEY `fk_mr_production` (`production_id`),
  ADD KEY `fk_mr_requester` (`requested_by`),
  ADD KEY `fk_mr_approver` (`approved_by`),
  ADD KEY `idx_mr_status` (`status`),
  ADD KEY `idx_mr_date` (`request_date`);

--
-- Indexes for table `material_request_details`
--
ALTER TABLE `material_request_details`
  ADD PRIMARY KEY (`request_detail_id`),
  ADD UNIQUE KEY `uq_request_product` (`request_id`,`product_id`),
  ADD KEY `fk_mrd_product` (`product_id`),
  ADD KEY `fk_mrd_location` (`source_location_id`);

--
-- Indexes for table `outbound_shipments`
--
ALTER TABLE `outbound_shipments`
  ADD PRIMARY KEY (`outbound_id`),
  ADD UNIQUE KEY `delivery_number` (`delivery_number`),
  ADD KEY `fk_outbound_so` (`sales_order_id`);

--
-- Indexes for table `outbound_shipment_details`
--
ALTER TABLE `outbound_shipment_details`
  ADD PRIMARY KEY (`outbound_detail_id`),
  ADD KEY `fk_outdetail_outbound` (`outbound_id`),
  ADD KEY `fk_outdetail_product` (`product_id`),
  ADD KEY `fk_outdetail_location` (`source_location_id`);

--
-- Indexes for table `production_orders`
--
ALTER TABLE `production_orders`
  ADD PRIMARY KEY (`production_id`),
  ADD UNIQUE KEY `production_number` (`production_number`),
  ADD KEY `fk_production_product` (`product_id`),
  ADD KEY `fk_production_location` (`target_location_id`),
  ADD KEY `fk_production_user` (`created_by`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Indexes for table `product_bom`
--
ALTER TABLE `product_bom`
  ADD PRIMARY KEY (`bom_id`),
  ADD UNIQUE KEY `uq_bom` (`finished_product_id`,`component_product_id`),
  ADD KEY `fk_bom_component` (`component_product_id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`po_id`),
  ADD UNIQUE KEY `po_number` (`po_number`),
  ADD KEY `fk_po_supplier` (`supplier_id`),
  ADD KEY `fk_po_user` (`created_by`);

--
-- Indexes for table `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  ADD PRIMARY KEY (`po_detail_id`),
  ADD KEY `fk_pod_po` (`po_id`),
  ADD KEY `fk_pod_product` (`product_id`);

--
-- Indexes for table `sales_orders`
--
ALTER TABLE `sales_orders`
  ADD PRIMARY KEY (`sales_order_id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `fk_so_customer` (`customer_id`),
  ADD KEY `fk_so_user` (`created_by`);

--
-- Indexes for table `sales_order_details`
--
ALTER TABLE `sales_order_details`
  ADD PRIMARY KEY (`sales_order_detail_id`),
  ADD KEY `fk_sod_so` (`sales_order_id`),
  ADD KEY `fk_sod_product` (`product_id`);

--
-- Indexes for table `stock_balances`
--
ALTER TABLE `stock_balances`
  ADD PRIMARY KEY (`stock_id`),
  ADD UNIQUE KEY `uq_product_location` (`product_id`,`location_id`),
  ADD KEY `fk_stock_location` (`location_id`);

--
-- Indexes for table `stock_transactions`
--
ALTER TABLE `stock_transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD UNIQUE KEY `transaction_number` (`transaction_number`),
  ADD KEY `fk_transaction_from` (`from_location_id`),
  ADD KEY `fk_transaction_to` (`to_location_id`),
  ADD KEY `fk_transaction_user` (`created_by`),
  ADD KEY `idx_transaction_date` (`transaction_date`),
  ADD KEY `idx_transaction_product` (`product_id`);

--
-- Indexes for table `storage_locations`
--
ALTER TABLE `storage_locations`
  ADD PRIMARY KEY (`location_id`),
  ADD UNIQUE KEY `uq_warehouse_bin` (`warehouse_id`,`bin_code`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `supplier_code` (`supplier_code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`warehouse_id`),
  ADD UNIQUE KEY `warehouse_code` (`warehouse_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inbound_shipments`
--
ALTER TABLE `inbound_shipments`
  MODIFY `inbound_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `material_requests`
--
ALTER TABLE `material_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `material_request_details`
--
ALTER TABLE `material_request_details`
  MODIFY `request_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `outbound_shipments`
--
ALTER TABLE `outbound_shipments`
  MODIFY `outbound_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `outbound_shipment_details`
--
ALTER TABLE `outbound_shipment_details`
  MODIFY `outbound_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `production_orders`
--
ALTER TABLE `production_orders`
  MODIFY `production_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `product_bom`
--
ALTER TABLE `product_bom`
  MODIFY `bom_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `po_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  MODIFY `po_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sales_orders`
--
ALTER TABLE `sales_orders`
  MODIFY `sales_order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_order_details`
--
ALTER TABLE `sales_order_details`
  MODIFY `sales_order_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_balances`
--
ALTER TABLE `stock_balances`
  MODIFY `stock_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `stock_transactions`
--
ALTER TABLE `stock_transactions`
  MODIFY `transaction_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `storage_locations`
--
ALTER TABLE `storage_locations`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `warehouse_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inbound_shipments`
--
ALTER TABLE `inbound_shipments`
  ADD CONSTRAINT `fk_inbound_po` FOREIGN KEY (`po_id`) REFERENCES `purchase_orders` (`po_id`) ON UPDATE CASCADE;

--
-- Constraints for table `material_requests`
--
ALTER TABLE `material_requests`
  ADD CONSTRAINT `fk_mr_approver` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mr_production` FOREIGN KEY (`production_id`) REFERENCES `production_orders` (`production_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mr_requester` FOREIGN KEY (`requested_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `material_request_details`
--
ALTER TABLE `material_request_details`
  ADD CONSTRAINT `fk_mrd_location` FOREIGN KEY (`source_location_id`) REFERENCES `storage_locations` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mrd_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mrd_request` FOREIGN KEY (`request_id`) REFERENCES `material_requests` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `outbound_shipments`
--
ALTER TABLE `outbound_shipments`
  ADD CONSTRAINT `fk_outbound_so` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`sales_order_id`) ON UPDATE CASCADE;

--
-- Constraints for table `outbound_shipment_details`
--
ALTER TABLE `outbound_shipment_details`
  ADD CONSTRAINT `fk_outdetail_location` FOREIGN KEY (`source_location_id`) REFERENCES `storage_locations` (`location_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_outdetail_outbound` FOREIGN KEY (`outbound_id`) REFERENCES `outbound_shipments` (`outbound_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_outdetail_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE;

--
-- Constraints for table `production_orders`
--
ALTER TABLE `production_orders`
  ADD CONSTRAINT `fk_production_location` FOREIGN KEY (`target_location_id`) REFERENCES `storage_locations` (`location_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_production_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_production_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `product_bom`
--
ALTER TABLE `product_bom`
  ADD CONSTRAINT `fk_bom_component` FOREIGN KEY (`component_product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bom_finished` FOREIGN KEY (`finished_product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `fk_po_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_po_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  ADD CONSTRAINT `fk_pod_po` FOREIGN KEY (`po_id`) REFERENCES `purchase_orders` (`po_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pod_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE;

--
-- Constraints for table `sales_orders`
--
ALTER TABLE `sales_orders`
  ADD CONSTRAINT `fk_so_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_so_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sales_order_details`
--
ALTER TABLE `sales_order_details`
  ADD CONSTRAINT `fk_sod_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sod_so` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`sales_order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stock_balances`
--
ALTER TABLE `stock_balances`
  ADD CONSTRAINT `fk_stock_location` FOREIGN KEY (`location_id`) REFERENCES `storage_locations` (`location_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE;

--
-- Constraints for table `stock_transactions`
--
ALTER TABLE `stock_transactions`
  ADD CONSTRAINT `fk_transaction_from` FOREIGN KEY (`from_location_id`) REFERENCES `storage_locations` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_to` FOREIGN KEY (`to_location_id`) REFERENCES `storage_locations` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `storage_locations`
--
ALTER TABLE `storage_locations`
  ADD CONSTRAINT `fk_location_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
