-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 21 déc. 2025 à 17:48
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `transport_urbain`
--

-- --------------------------------------------------------

--
-- Structure de la table `arret`
--

CREATE TABLE `arret` (
  `arret_id` int(11) NOT NULL,
  `nom_arret` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `arret`
--

INSERT INTO `arret` (`arret_id`, `nom_arret`) VALUES
(2, 'Avenue Mohammed V'),
(14, 'Azzouzia'),
(5, 'Bab Doukkala'),
(16, 'Centre'),
(8, 'Daoudiate'),
(1, 'Guéliz'),
(4, 'Jamaa El Fna'),
(17, 'Massira'),
(3, 'Médina'),
(13, 'Mhamid'),
(7, 'Place des Ferblantiers'),
(12, 'Route d’Ourika'),
(9, 'Route de Casablanca'),
(10, 'Route de Safi'),
(11, 'Sidi Ghanem'),
(6, 'Sidi Youssef Ben Ali'),
(15, 'Targa');

-- --------------------------------------------------------

--
-- Structure de la table `avertissement`
--

CREATE TABLE `avertissement` (
  `avertissement_id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `type_avertissement` enum('embouteillage','accident','travaux','manifestation','panne','autre') NOT NULL,
  `titre` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `position_lat` decimal(10,8) DEFAULT NULL,
  `position_lon` decimal(11,8) DEFAULT NULL,
  `rue_affectee` varchar(200) DEFAULT NULL,
  `debut_avertissement` datetime NOT NULL,
  `fin_avertissement` datetime NOT NULL,
  `niveau` enum('faible','moyen','eleve','critique') DEFAULT 'moyen',
  `est_actif` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `avertissement`
--

INSERT INTO `avertissement` (`avertissement_id`, `bus_id`, `type_avertissement`, `titre`, `message`, `position_lat`, `position_lon`, `rue_affectee`, `debut_avertissement`, `fin_avertissement`, `niveau`, `est_actif`, `created_at`) VALUES
(1, 2, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.62750000, -8.02404000, 'Sidi Ghanem', '2025-12-19 01:24:51', '2025-12-19 02:19:51', 'eleve', 1, '2025-12-18 23:03:51'),
(2, 8, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.63433000, -7.98634000, 'Sidi Ghanem', '2025-12-19 06:03:51', '2025-12-19 06:43:51', 'faible', 1, '2025-12-18 23:03:51'),
(3, 9, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.60663000, -7.97588000, 'Avenue Mohammed V', '2025-12-19 05:16:51', '2025-12-19 05:44:51', 'critique', 1, '2025-12-18 23:03:51'),
(4, 5, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.61419000, -7.94198000, 'Avenue Mohammed V', '2025-12-19 02:53:51', '2025-12-19 03:51:51', 'faible', 1, '2025-12-18 23:03:51'),
(5, 11, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.61264000, -8.01432000, 'Guéliz', '2025-12-19 01:05:51', '2025-12-19 01:37:51', 'critique', 1, '2025-12-18 23:03:51'),
(6, 9, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.58090000, -8.02432000, 'Jamaa El Fna', '2025-12-19 03:41:51', '2025-12-19 04:19:51', 'moyen', 0, '2025-12-18 23:03:51'),
(7, 2, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.58152000, -7.98963000, 'Bab Doukkala', '2025-12-19 03:56:51', '2025-12-19 04:16:51', 'faible', 1, '2025-12-18 23:03:51'),
(8, 3, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.65163000, -7.95924000, 'Guéliz', '2025-12-19 04:52:51', '2025-12-19 05:38:51', 'moyen', 1, '2025-12-18 23:03:51'),
(9, 8, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.63783000, -7.99142000, 'Jamaa El Fna', '2025-12-19 05:10:51', '2025-12-19 05:57:51', 'critique', 1, '2025-12-18 23:03:51'),
(10, 2, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.66333000, -7.94246000, 'Sidi Ghanem', '2025-12-19 03:37:51', '2025-12-19 04:18:51', 'critique', 1, '2025-12-18 23:03:51'),
(11, 11, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.66829000, -7.97495000, 'Avenue Mohammed V', '2025-12-19 00:31:51', '2025-12-19 01:15:51', 'critique', 0, '2025-12-18 23:03:51'),
(12, 8, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.59423000, -8.01937000, 'Route d’Ourika', '2025-12-19 03:27:51', '2025-12-19 04:10:51', 'critique', 0, '2025-12-18 23:03:51'),
(13, 5, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.60677000, -7.96195000, 'Bab Doukkala', '2025-12-19 02:17:51', '2025-12-19 02:51:51', 'faible', 1, '2025-12-18 23:03:51'),
(14, 9, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.65844000, -7.95385000, 'Sidi Ghanem', '2025-12-19 05:34:51', '2025-12-19 06:27:51', 'critique', 1, '2025-12-18 23:03:51'),
(15, 2, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.66885000, -7.96572000, 'Jamaa El Fna', '2025-12-19 05:58:51', '2025-12-19 06:52:51', 'faible', 0, '2025-12-18 23:03:51'),
(16, 12, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.64538000, -7.97474000, 'Route d’Ourika', '2025-12-21 20:00:19', '2025-12-21 20:57:19', 'moyen', 1, '2025-12-21 13:03:19'),
(17, 11, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.67440000, -7.94671000, 'Bab Doukkala', '2025-12-21 15:12:19', '2025-12-21 16:03:19', 'eleve', 1, '2025-12-21 13:03:19'),
(18, 5, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.58679000, -7.98873000, 'Route de Casablanca', '2025-12-21 14:09:19', '2025-12-21 14:34:19', 'eleve', 0, '2025-12-21 13:03:19'),
(19, 12, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.60540000, -7.97913000, 'Bab Doukkala', '2025-12-21 17:26:19', '2025-12-21 18:19:19', 'faible', 1, '2025-12-21 13:03:19'),
(20, 2, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.60960000, -8.00852000, 'Sidi Ghanem', '2025-12-21 16:26:19', '2025-12-21 17:18:19', 'moyen', 1, '2025-12-21 13:03:19'),
(21, 8, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.61696000, -8.02705000, 'Jamaa El Fna', '2025-12-21 17:06:19', '2025-12-21 17:48:19', 'critique', 1, '2025-12-21 13:03:19'),
(22, 1, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.65310000, -8.01643000, 'Jamaa El Fna', '2025-12-21 14:45:19', '2025-12-21 15:15:19', 'eleve', 0, '2025-12-21 13:03:19'),
(23, 7, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.62682000, -7.94159000, 'Jamaa El Fna', '2025-12-21 17:34:19', '2025-12-21 17:56:19', 'eleve', 0, '2025-12-21 13:03:19'),
(24, 6, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.58492000, -7.98032000, 'Jamaa El Fna', '2025-12-21 19:26:19', '2025-12-21 19:40:19', 'eleve', 1, '2025-12-21 13:03:19'),
(25, 7, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.58539000, -7.95320000, 'Route d’Ourika', '2025-12-21 15:55:19', '2025-12-21 16:43:19', 'faible', 1, '2025-12-21 13:03:19'),
(26, 7, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.66342000, -8.03489000, 'Route de Casablanca', '2025-12-21 15:48:19', '2025-12-21 16:19:19', 'faible', 0, '2025-12-21 13:03:19'),
(27, 12, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.62919000, -7.94514000, 'Bab Doukkala', '2025-12-21 17:40:19', '2025-12-21 18:16:19', 'moyen', 0, '2025-12-21 13:03:19'),
(28, 3, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.60685000, -7.97663000, 'Sidi Ghanem', '2025-12-21 18:26:19', '2025-12-21 19:07:19', 'moyen', 0, '2025-12-21 13:03:19'),
(29, 7, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.62295000, -7.99977000, 'Guéliz', '2025-12-21 19:42:19', '2025-12-21 20:14:19', 'moyen', 1, '2025-12-21 13:03:19'),
(30, 10, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.67017000, -8.01821000, 'Guéliz', '2025-12-21 15:23:19', '2025-12-21 15:55:19', 'faible', 1, '2025-12-21 13:03:19'),
(31, 5, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.61895000, -8.02342000, 'Avenue Mohammed V', '2025-12-21 15:03:35', '2025-12-21 15:19:35', 'moyen', 0, '2025-12-21 13:09:35'),
(32, 2, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.65881000, -7.96780000, 'Bab Doukkala', '2025-12-21 14:25:35', '2025-12-21 15:11:35', 'critique', 0, '2025-12-21 13:09:35'),
(33, 2, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.59022000, -7.95415000, 'Route de Casablanca', '2025-12-21 16:00:35', '2025-12-21 16:13:35', 'faible', 0, '2025-12-21 13:09:35'),
(34, 12, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.61742000, -7.96971000, 'Jamaa El Fna', '2025-12-21 15:03:35', '2025-12-21 15:27:35', 'eleve', 1, '2025-12-21 13:09:35'),
(35, 7, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.63559000, -7.98347000, 'Route d’Ourika', '2025-12-21 19:38:35', '2025-12-21 19:51:35', 'moyen', 1, '2025-12-21 13:09:35'),
(36, 11, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.66282000, -7.98456000, 'Bab Doukkala', '2025-12-21 17:23:35', '2025-12-21 17:51:35', 'moyen', 0, '2025-12-21 13:09:35'),
(37, 7, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.58817000, -7.98141000, 'Route de Casablanca', '2025-12-21 15:23:35', '2025-12-21 15:58:35', 'moyen', 0, '2025-12-21 13:09:35'),
(38, 6, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.61429000, -7.99422000, 'Route d’Ourika', '2025-12-21 15:00:35', '2025-12-21 15:13:35', 'faible', 1, '2025-12-21 13:09:35'),
(39, 12, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.58135000, -7.97597000, 'Route de Casablanca', '2025-12-21 17:40:35', '2025-12-21 18:24:35', 'critique', 0, '2025-12-21 13:09:35'),
(40, 6, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.60408000, -8.03560000, 'Route d’Ourika', '2025-12-21 17:05:35', '2025-12-21 17:57:35', 'critique', 1, '2025-12-21 13:09:35'),
(41, 6, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.59029000, -8.01136000, 'Route d’Ourika', '2025-12-21 17:06:35', '2025-12-21 18:06:35', 'eleve', 0, '2025-12-21 13:09:35'),
(42, 9, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.66272000, -7.98859000, 'Route d’Ourika', '2025-12-21 17:10:35', '2025-12-21 17:22:35', 'eleve', 1, '2025-12-21 13:09:35'),
(43, 5, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.60822000, -7.97010000, 'Avenue Mohammed V', '2025-12-21 15:21:35', '2025-12-21 16:10:35', 'eleve', 1, '2025-12-21 13:09:35'),
(44, 3, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.65037000, -7.94329000, 'Guéliz', '2025-12-21 17:18:35', '2025-12-21 17:38:35', 'eleve', 1, '2025-12-21 13:09:35'),
(45, 6, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.61876000, -7.96672000, 'Guéliz', '2025-12-21 18:50:35', '2025-12-21 19:08:35', 'moyen', 1, '2025-12-21 13:09:35'),
(46, 12, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.64849000, -8.02716000, 'Jamaa El Fna', '2025-12-21 17:37:52', '2025-12-21 18:30:52', 'faible', 0, '2025-12-21 13:11:52'),
(47, 10, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.63224000, -8.01420000, 'Jamaa El Fna', '2025-12-21 16:55:52', '2025-12-21 17:15:52', 'moyen', 0, '2025-12-21 13:11:52'),
(48, 4, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.63653000, -7.96897000, 'Avenue Mohammed V', '2025-12-21 16:51:52', '2025-12-21 17:17:52', 'faible', 1, '2025-12-21 13:11:52'),
(49, 1, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.59529000, -7.98311000, 'Avenue Mohammed V', '2025-12-21 16:04:52', '2025-12-21 16:38:52', 'critique', 0, '2025-12-21 13:11:52'),
(50, 7, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.65192000, -7.97819000, 'Bab Doukkala', '2025-12-21 17:37:52', '2025-12-21 18:00:52', 'eleve', 0, '2025-12-21 13:11:52'),
(51, 9, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.62751000, -8.01601000, 'Route d’Ourika', '2025-12-21 15:15:52', '2025-12-21 15:37:52', 'eleve', 1, '2025-12-21 13:11:52'),
(52, 11, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.58118000, -7.96345000, 'Guéliz', '2025-12-21 14:59:52', '2025-12-21 15:24:52', 'critique', 0, '2025-12-21 13:11:52'),
(53, 12, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.65444000, -7.97504000, 'Guéliz', '2025-12-21 18:18:52', '2025-12-21 18:37:52', 'critique', 1, '2025-12-21 13:11:52'),
(54, 9, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.59418000, -7.97277000, 'Route d’Ourika', '2025-12-21 16:40:52', '2025-12-21 17:38:52', 'eleve', 1, '2025-12-21 13:11:52'),
(55, 2, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.66069000, -8.00531000, 'Guéliz', '2025-12-21 14:59:52', '2025-12-21 15:23:52', 'eleve', 0, '2025-12-21 13:11:52'),
(56, 2, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.62203000, -7.99328000, 'Bab Doukkala', '2025-12-21 16:36:52', '2025-12-21 17:18:52', 'faible', 0, '2025-12-21 13:11:52'),
(57, 4, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.59994000, -7.99177000, 'Jamaa El Fna', '2025-12-21 18:32:52', '2025-12-21 19:25:52', 'eleve', 0, '2025-12-21 13:11:52'),
(58, 12, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.62756000, -7.97175000, 'Route de Casablanca', '2025-12-21 17:43:52', '2025-12-21 18:11:52', 'critique', 1, '2025-12-21 13:11:52'),
(59, 7, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.61384000, -8.03736000, 'Bab Doukkala', '2025-12-21 16:08:52', '2025-12-21 16:51:52', 'faible', 0, '2025-12-21 13:11:52'),
(60, 2, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.59033000, -8.02224000, 'Bab Doukkala', '2025-12-21 16:54:52', '2025-12-21 17:06:52', 'critique', 1, '2025-12-21 13:11:52'),
(61, 10, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.61927000, -8.02498000, 'Sidi Ghanem', '2025-12-21 15:53:37', '2025-12-21 16:20:37', 'critique', 1, '2025-12-21 13:14:37'),
(62, 5, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.65565000, -8.01107000, 'Guéliz', '2025-12-21 18:41:37', '2025-12-21 19:01:37', 'faible', 0, '2025-12-21 13:14:37'),
(63, 8, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.64889000, -8.00366000, 'Route de Casablanca', '2025-12-21 16:12:37', '2025-12-21 16:46:37', 'eleve', 1, '2025-12-21 13:14:37'),
(64, 4, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.58876000, -7.94605000, 'Sidi Ghanem', '2025-12-21 17:34:37', '2025-12-21 17:49:37', 'faible', 0, '2025-12-21 13:14:37'),
(65, 6, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.61738000, -7.98250000, 'Sidi Ghanem', '2025-12-21 18:11:37', '2025-12-21 18:50:37', 'critique', 0, '2025-12-21 13:14:37'),
(66, 11, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.62003000, -7.97662000, 'Jamaa El Fna', '2025-12-21 19:04:37', '2025-12-21 19:41:37', 'eleve', 1, '2025-12-21 13:14:37'),
(67, 4, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.59671000, -7.97440000, 'Guéliz', '2025-12-21 17:06:37', '2025-12-21 17:16:37', 'faible', 1, '2025-12-21 13:14:37'),
(68, 7, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.61160000, -8.00093000, 'Guéliz', '2025-12-21 20:04:37', '2025-12-21 20:23:37', 'faible', 0, '2025-12-21 13:14:37'),
(69, 12, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.66910000, -7.97423000, 'Route d’Ourika', '2025-12-21 14:31:37', '2025-12-21 15:02:37', 'critique', 0, '2025-12-21 13:14:37'),
(70, 2, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.63657000, -8.00212000, 'Route d’Ourika', '2025-12-21 18:01:37', '2025-12-21 18:47:37', 'critique', 1, '2025-12-21 13:14:37'),
(71, 8, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.57803000, -8.02150000, 'Jamaa El Fna', '2025-12-21 14:32:37', '2025-12-21 15:22:37', 'critique', 0, '2025-12-21 13:14:37'),
(72, 2, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.62517000, -7.99007000, 'Bab Doukkala', '2025-12-21 17:41:37', '2025-12-21 18:30:37', 'moyen', 1, '2025-12-21 13:14:37'),
(73, 8, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.60294000, -8.00687000, 'Route d’Ourika', '2025-12-21 15:03:37', '2025-12-21 15:28:37', 'faible', 0, '2025-12-21 13:14:37'),
(74, 8, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.59227000, -8.01774000, 'Route d’Ourika', '2025-12-21 14:18:37', '2025-12-21 15:01:37', 'moyen', 0, '2025-12-21 13:14:37'),
(75, 10, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.62085000, -8.00092000, 'Bab Doukkala', '2025-12-21 16:41:37', '2025-12-21 17:07:37', 'critique', 0, '2025-12-21 13:14:37'),
(76, 9, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.60173000, -7.93924000, 'Route d’Ourika', '2025-12-21 14:30:44', '2025-12-21 15:00:44', 'faible', 0, '2025-12-21 13:14:44'),
(77, 12, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.65035000, -7.99116000, 'Jamaa El Fna', '2025-12-21 18:53:44', '2025-12-21 19:44:44', 'critique', 0, '2025-12-21 13:14:44'),
(78, 1, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.62822000, -8.01821000, 'Guéliz', '2025-12-21 14:47:44', '2025-12-21 15:12:44', 'faible', 1, '2025-12-21 13:14:44'),
(79, 9, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.59401000, -8.01026000, 'Route d’Ourika', '2025-12-21 15:27:44', '2025-12-21 15:52:44', 'faible', 0, '2025-12-21 13:14:44'),
(80, 2, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.63373000, -8.01608000, 'Avenue Mohammed V', '2025-12-21 17:21:44', '2025-12-21 18:16:44', 'moyen', 1, '2025-12-21 13:14:44'),
(81, 8, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.65114000, -7.97316000, 'Route de Casablanca', '2025-12-21 18:26:44', '2025-12-21 18:47:44', 'eleve', 0, '2025-12-21 13:14:44'),
(82, 3, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.65657000, -7.95748000, 'Jamaa El Fna', '2025-12-21 16:18:44', '2025-12-21 17:15:44', 'eleve', 1, '2025-12-21 13:14:44'),
(83, 6, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.62553000, -7.99446000, 'Bab Doukkala', '2025-12-21 14:33:44', '2025-12-21 15:01:44', 'faible', 1, '2025-12-21 13:14:44'),
(84, 1, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.67110000, -8.00942000, 'Route de Casablanca', '2025-12-21 16:28:44', '2025-12-21 17:23:44', 'eleve', 1, '2025-12-21 13:14:44'),
(85, 11, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.62352000, -7.99088000, 'Avenue Mohammed V', '2025-12-21 15:12:44', '2025-12-21 16:04:44', 'critique', 1, '2025-12-21 13:14:44'),
(86, 11, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.59985000, -8.03003000, 'Sidi Ghanem', '2025-12-21 14:33:44', '2025-12-21 15:28:44', 'moyen', 1, '2025-12-21 13:14:44'),
(87, 3, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.63620000, -7.93993000, 'Route d’Ourika', '2025-12-21 18:18:44', '2025-12-21 18:50:44', 'eleve', 0, '2025-12-21 13:14:44'),
(88, 4, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.60850000, -7.99297000, 'Sidi Ghanem', '2025-12-21 14:40:44', '2025-12-21 15:00:44', 'eleve', 0, '2025-12-21 13:14:44'),
(89, 11, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.65282000, -7.97020000, 'Guéliz', '2025-12-21 16:39:44', '2025-12-21 17:32:44', 'critique', 0, '2025-12-21 13:14:44'),
(90, 12, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.59046000, -7.99132000, 'Route d’Ourika', '2025-12-21 19:20:44', '2025-12-21 20:06:44', 'faible', 0, '2025-12-21 13:14:44'),
(91, 7, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.60884000, -7.98454000, 'Avenue Mohammed V', '2025-12-21 20:06:59', '2025-12-21 20:46:59', 'moyen', 1, '2025-12-21 13:16:59'),
(92, 7, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.65283000, -8.00145000, 'Guéliz', '2025-12-21 18:25:59', '2025-12-21 19:09:59', 'faible', 1, '2025-12-21 13:16:59'),
(93, 9, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.59938000, -8.03347000, 'Sidi Ghanem', '2025-12-21 16:22:59', '2025-12-21 17:00:59', 'critique', 0, '2025-12-21 13:16:59'),
(94, 4, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.64131000, -7.99280000, 'Guéliz', '2025-12-21 19:27:59', '2025-12-21 20:27:59', 'faible', 1, '2025-12-21 13:16:59'),
(95, 10, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.65524000, -8.02358000, 'Guéliz', '2025-12-21 17:13:59', '2025-12-21 18:00:59', 'faible', 1, '2025-12-21 13:16:59'),
(96, 3, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.59448000, -8.02339000, 'Route d’Ourika', '2025-12-21 14:23:59', '2025-12-21 14:57:59', 'critique', 0, '2025-12-21 13:16:59'),
(97, 9, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.63896000, -7.99998000, 'Bab Doukkala', '2025-12-21 18:41:59', '2025-12-21 19:32:59', 'eleve', 0, '2025-12-21 13:16:59'),
(98, 4, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.58889000, -7.95663000, 'Bab Doukkala', '2025-12-21 17:21:59', '2025-12-21 18:06:59', 'faible', 0, '2025-12-21 13:16:59'),
(99, 9, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.66768000, -8.00406000, 'Route d’Ourika', '2025-12-21 16:43:59', '2025-12-21 17:05:59', 'critique', 0, '2025-12-21 13:16:59'),
(100, 8, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.63645000, -7.99435000, 'Jamaa El Fna', '2025-12-21 15:15:59', '2025-12-21 15:42:59', 'eleve', 0, '2025-12-21 13:16:59'),
(101, 9, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.61946000, -8.02738000, 'Bab Doukkala', '2025-12-21 15:44:59', '2025-12-21 16:04:59', 'moyen', 1, '2025-12-21 13:16:59'),
(102, 10, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.63716000, -8.03705000, 'Route de Casablanca', '2025-12-21 14:49:59', '2025-12-21 15:12:59', 'eleve', 0, '2025-12-21 13:16:59'),
(103, 1, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.63621000, -8.02582000, 'Sidi Ghanem', '2025-12-21 18:37:59', '2025-12-21 18:50:59', 'critique', 0, '2025-12-21 13:16:59'),
(104, 2, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.60975000, -8.03897000, 'Route d’Ourika', '2025-12-21 17:10:59', '2025-12-21 17:40:59', 'eleve', 1, '2025-12-21 13:16:59'),
(105, 9, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.58430000, -7.94353000, 'Jamaa El Fna', '2025-12-21 17:01:59', '2025-12-21 17:47:59', 'faible', 1, '2025-12-21 13:16:59'),
(106, 7, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.65727000, -7.99466000, 'Route d’Ourika', '2025-12-21 18:18:00', '2025-12-21 18:35:00', 'eleve', 1, '2025-12-21 13:17:00'),
(107, 4, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.58519000, -8.01369000, 'Bab Doukkala', '2025-12-21 14:53:00', '2025-12-21 15:40:00', 'moyen', 0, '2025-12-21 13:17:00'),
(108, 4, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.59298000, -7.98480000, 'Route d’Ourika', '2025-12-21 16:21:00', '2025-12-21 17:07:00', 'moyen', 0, '2025-12-21 13:17:00'),
(109, 2, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.59822000, -7.96530000, 'Bab Doukkala', '2025-12-21 14:57:00', '2025-12-21 15:53:00', 'critique', 0, '2025-12-21 13:17:00'),
(110, 2, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.59272000, -8.00836000, 'Route de Casablanca', '2025-12-21 20:00:00', '2025-12-21 20:37:00', 'moyen', 1, '2025-12-21 13:17:00'),
(111, 6, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.60647000, -8.03036000, 'Jamaa El Fna', '2025-12-21 17:21:00', '2025-12-21 18:02:00', 'eleve', 1, '2025-12-21 13:17:00'),
(112, 2, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.57730000, -7.94970000, 'Guéliz', '2025-12-21 18:06:00', '2025-12-21 18:39:00', 'faible', 1, '2025-12-21 13:17:00'),
(113, 12, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.59288000, -7.95747000, 'Jamaa El Fna', '2025-12-21 15:36:00', '2025-12-21 15:55:00', 'moyen', 1, '2025-12-21 13:17:00'),
(114, 6, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.62751000, -7.99675000, 'Avenue Mohammed V', '2025-12-21 16:16:00', '2025-12-21 17:16:00', 'critique', 0, '2025-12-21 13:17:00'),
(115, 7, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.59451000, -7.97701000, 'Sidi Ghanem', '2025-12-21 14:54:00', '2025-12-21 15:41:00', 'moyen', 1, '2025-12-21 13:17:00'),
(116, 6, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.64630000, -8.01724000, 'Jamaa El Fna', '2025-12-21 18:40:00', '2025-12-21 19:12:00', 'moyen', 1, '2025-12-21 13:17:00'),
(117, 4, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.67056000, -7.94771000, 'Guéliz', '2025-12-21 16:07:00', '2025-12-21 16:58:00', 'faible', 1, '2025-12-21 13:17:00'),
(118, 12, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.60886000, -8.03790000, 'Avenue Mohammed V', '2025-12-21 15:54:00', '2025-12-21 16:48:00', 'eleve', 1, '2025-12-21 13:17:00'),
(119, 3, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.60056000, -7.95843000, 'Guéliz', '2025-12-21 15:33:00', '2025-12-21 15:56:00', 'moyen', 1, '2025-12-21 13:17:00'),
(120, 1, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.65348000, -8.02444000, 'Route de Casablanca', '2025-12-21 19:34:00', '2025-12-21 20:23:00', 'moyen', 1, '2025-12-21 13:17:00'),
(121, 8, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.58316000, -8.02383000, 'Route de Casablanca', '2025-12-21 19:13:02', '2025-12-21 19:38:02', 'critique', 0, '2025-12-21 13:17:02'),
(122, 8, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.59093000, -7.94422000, 'Sidi Ghanem', '2025-12-21 15:30:02', '2025-12-21 16:24:02', 'eleve', 0, '2025-12-21 13:17:02'),
(123, 7, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.65035000, -7.99993000, 'Avenue Mohammed V', '2025-12-21 19:15:02', '2025-12-21 19:49:02', 'eleve', 0, '2025-12-21 13:17:02'),
(124, 6, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.64294000, -7.94414000, 'Guéliz', '2025-12-21 19:44:02', '2025-12-21 20:01:02', 'eleve', 0, '2025-12-21 13:17:02'),
(125, 4, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.61303000, -7.98658000, 'Guéliz', '2025-12-21 18:28:02', '2025-12-21 19:13:02', 'eleve', 0, '2025-12-21 13:17:02'),
(126, 12, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.62698000, -7.95713000, 'Sidi Ghanem', '2025-12-21 16:07:02', '2025-12-21 16:24:02', 'faible', 0, '2025-12-21 13:17:02'),
(127, 2, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.62302000, -8.02478000, 'Sidi Ghanem', '2025-12-21 15:59:02', '2025-12-21 16:52:02', 'moyen', 1, '2025-12-21 13:17:02'),
(128, 9, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.59844000, -7.99034000, 'Jamaa El Fna', '2025-12-21 19:19:02', '2025-12-21 19:55:02', 'eleve', 0, '2025-12-21 13:17:02'),
(129, 2, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.58904000, -7.97928000, 'Bab Doukkala', '2025-12-21 17:38:02', '2025-12-21 18:37:02', 'faible', 0, '2025-12-21 13:17:02'),
(130, 7, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.65193000, -7.98776000, 'Guéliz', '2025-12-21 19:49:02', '2025-12-21 20:06:02', 'moyen', 1, '2025-12-21 13:17:02'),
(131, 7, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.59301000, -7.98550000, 'Sidi Ghanem', '2025-12-21 20:08:02', '2025-12-21 20:55:02', 'faible', 1, '2025-12-21 13:17:02'),
(132, 11, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.62279000, -8.00908000, 'Guéliz', '2025-12-21 16:49:02', '2025-12-21 17:31:02', 'eleve', 0, '2025-12-21 13:17:02'),
(133, 8, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.60424000, -7.96865000, 'Bab Doukkala', '2025-12-21 19:50:02', '2025-12-21 20:07:02', 'faible', 1, '2025-12-21 13:17:02'),
(134, 12, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.58042000, -8.02215000, 'Avenue Mohammed V', '2025-12-21 17:10:02', '2025-12-21 17:48:02', 'eleve', 1, '2025-12-21 13:17:02'),
(135, 8, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.65735000, -8.00523000, 'Jamaa El Fna', '2025-12-21 17:36:02', '2025-12-21 18:03:02', 'faible', 0, '2025-12-21 13:17:02'),
(136, 1, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.63963000, -7.97740000, 'Sidi Ghanem', '2025-12-21 15:40:58', '2025-12-21 16:09:58', 'critique', 0, '2025-12-21 13:23:58'),
(137, 3, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.63095000, -7.99078000, 'Avenue Mohammed V', '2025-12-21 19:57:58', '2025-12-21 20:18:58', 'moyen', 0, '2025-12-21 13:23:58'),
(138, 1, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.66057000, -8.02810000, 'Sidi Ghanem', '2025-12-21 15:58:58', '2025-12-21 16:57:58', 'faible', 1, '2025-12-21 13:23:58'),
(139, 2, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.65164000, -8.02648000, 'Guéliz', '2025-12-21 20:11:58', '2025-12-21 20:58:58', 'moyen', 1, '2025-12-21 13:23:58'),
(140, 3, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.66082000, -7.94689000, 'Avenue Mohammed V', '2025-12-21 16:20:58', '2025-12-21 17:04:58', 'moyen', 1, '2025-12-21 13:23:58'),
(141, 9, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.66806000, -7.94825000, 'Avenue Mohammed V', '2025-12-21 15:36:58', '2025-12-21 16:04:58', 'moyen', 1, '2025-12-21 13:23:58'),
(142, 10, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.59870000, -7.95779000, 'Bab Doukkala', '2025-12-21 16:33:58', '2025-12-21 16:48:58', 'faible', 0, '2025-12-21 13:23:58'),
(143, 8, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.64438000, -7.98020000, 'Guéliz', '2025-12-21 15:39:58', '2025-12-21 16:16:58', 'eleve', 1, '2025-12-21 13:23:58'),
(144, 1, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.60571000, -7.97636000, 'Bab Doukkala', '2025-12-21 19:13:58', '2025-12-21 19:54:58', 'moyen', 0, '2025-12-21 13:23:58'),
(145, 3, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.66650000, -8.00578000, 'Jamaa El Fna', '2025-12-21 14:56:58', '2025-12-21 15:47:58', 'critique', 1, '2025-12-21 13:23:58'),
(146, 11, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.64456000, -7.99362000, 'Guéliz', '2025-12-21 15:37:58', '2025-12-21 16:27:58', 'eleve', 0, '2025-12-21 13:23:58'),
(147, 1, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.57720000, -7.95131000, 'Guéliz', '2025-12-21 18:50:58', '2025-12-21 19:23:58', 'faible', 0, '2025-12-21 13:23:58'),
(148, 10, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.59647000, -8.02646000, 'Route de Casablanca', '2025-12-21 19:43:58', '2025-12-21 20:05:58', 'faible', 0, '2025-12-21 13:23:58'),
(149, 2, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.58934000, -7.98287000, 'Sidi Ghanem', '2025-12-21 17:29:58', '2025-12-21 17:46:58', 'faible', 1, '2025-12-21 13:23:58'),
(150, 10, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.59423000, -8.03468000, 'Route d’Ourika', '2025-12-21 18:02:58', '2025-12-21 18:13:58', 'eleve', 0, '2025-12-21 13:23:58'),
(151, 2, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.63825000, -8.02956000, 'Avenue Mohammed V', '2025-12-21 17:36:55', '2025-12-21 17:52:55', 'moyen', 1, '2025-12-21 13:24:55'),
(152, 9, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.60814000, -7.96695000, 'Jamaa El Fna', '2025-12-21 16:05:55', '2025-12-21 16:36:55', 'eleve', 0, '2025-12-21 13:24:55'),
(153, 2, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.66395000, -8.01176000, 'Jamaa El Fna', '2025-12-21 16:26:55', '2025-12-21 16:39:55', 'faible', 0, '2025-12-21 13:24:55'),
(154, 4, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.57802000, -7.98383000, 'Bab Doukkala', '2025-12-21 16:53:55', '2025-12-21 17:51:55', 'eleve', 0, '2025-12-21 13:24:55'),
(155, 11, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.62695000, -7.94242000, 'Route d’Ourika', '2025-12-21 15:41:55', '2025-12-21 16:36:55', 'critique', 0, '2025-12-21 13:24:55'),
(156, 5, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.64483000, -8.03092000, 'Bab Doukkala', '2025-12-21 14:46:55', '2025-12-21 15:25:55', 'moyen', 1, '2025-12-21 13:24:55'),
(157, 12, 'accident', 'Accident sur la ligne', 'Un accident est signalé, veuillez faire attention.', 31.65588000, -7.98376000, 'Guéliz', '2025-12-21 15:16:55', '2025-12-21 15:29:55', 'eleve', 0, '2025-12-21 13:24:55'),
(158, 7, 'travaux', 'Travaux sur la ligne', 'Un travaux est signalé, veuillez faire attention.', 31.66693000, -7.97330000, 'Guéliz', '2025-12-21 16:29:55', '2025-12-21 17:07:55', 'faible', 1, '2025-12-21 13:24:55'),
(159, 7, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.63844000, -8.00676000, 'Avenue Mohammed V', '2025-12-21 20:08:55', '2025-12-21 20:25:55', 'critique', 0, '2025-12-21 13:24:55'),
(160, 3, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.59554000, -8.01999000, 'Bab Doukkala', '2025-12-21 14:39:55', '2025-12-21 15:21:55', 'critique', 1, '2025-12-21 13:24:55'),
(161, 11, 'manifestation', 'Manifestation sur la ligne', 'Un manifestation est signalé, veuillez faire attention.', 31.66191000, -7.94286000, 'Route de Casablanca', '2025-12-21 15:54:55', '2025-12-21 16:08:55', 'moyen', 0, '2025-12-21 13:24:55'),
(162, 1, 'panne', 'Panne sur la ligne', 'Un panne est signalé, veuillez faire attention.', 31.60485000, -8.00685000, 'Route de Casablanca', '2025-12-21 16:47:55', '2025-12-21 17:01:55', 'critique', 0, '2025-12-21 13:24:55'),
(163, 8, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.60740000, -8.00461000, 'Bab Doukkala', '2025-12-21 18:08:55', '2025-12-21 18:19:55', 'moyen', 0, '2025-12-21 13:24:55'),
(164, 4, 'autre', 'Autre sur la ligne', 'Un autre est signalé, veuillez faire attention.', 31.61157000, -8.02445000, 'Avenue Mohammed V', '2025-12-21 14:43:55', '2025-12-21 15:27:55', 'eleve', 1, '2025-12-21 13:24:55'),
(165, 2, 'embouteillage', 'Embouteillage sur la ligne', 'Un embouteillage est signalé, veuillez faire attention.', 31.66871000, -7.94151000, 'Guéliz', '2025-12-21 18:13:55', '2025-12-21 19:02:55', 'moyen', 0, '2025-12-21 13:24:55');

-- --------------------------------------------------------

--
-- Structure de la table `bus`
--

CREATE TABLE `bus` (
  `bus_id` int(11) NOT NULL,
  `numero_bus` varchar(20) NOT NULL,
  `nom_ligne` varchar(100) NOT NULL,
  `statut` enum('en_service','hors_service','en_maintenance') DEFAULT 'en_service',
  `capacite` int(11) DEFAULT 50
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bus`
--

INSERT INTO `bus` (`bus_id`, `numero_bus`, `nom_ligne`, `statut`, `capacite`) VALUES
(1, 'Bus 1', 'Guéliz – Médina', 'en_service', 49),
(2, 'Bus 2', 'Bab Doukkala – Sidi Youssef Ben Ali', 'hors_service', 48),
(3, 'Bus 3', 'Massira – Jamaa El Fna', 'hors_service', 62),
(4, 'Bus 4', 'Daoudiate – Guéliz', 'en_maintenance', 60),
(5, 'Bus 5', 'Route de Casablanca – Centre', 'hors_service', 63),
(6, 'Bus 6', 'Route de Safi – Guéliz', 'en_service', 55),
(7, 'Bus 7', 'Guéliz – Jamaa El Fna', 'en_service', 57),
(8, 'Bus 8', 'Sidi Ghanem – Guéliz', 'en_maintenance', 65),
(9, 'Bus 10', 'Route d’Ourika – Jamaa El Fna', 'hors_service', 61),
(10, 'Bus 11', 'Mhamid – Bab Doukkala', 'hors_service', 52),
(11, 'Bus 12', 'Azzouzia – Centre', 'en_service', 62),
(12, 'Bus 14', 'Targa – Guéliz', 'hors_service', 72);

-- --------------------------------------------------------

--
-- Structure de la table `bus_arret`
--

CREATE TABLE `bus_arret` (
  `bus_id` int(11) NOT NULL,
  `arret_id` int(11) NOT NULL,
  `ordre_passage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bus_arret`
--

INSERT INTO `bus_arret` (`bus_id`, `arret_id`, `ordre_passage`) VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(1, 4, 4),
(2, 1, 4),
(2, 5, 1),
(2, 6, 2),
(2, 7, 3),
(3, 4, 3),
(3, 7, 2),
(3, 17, 1),
(4, 1, 2),
(4, 8, 1),
(5, 9, 1),
(5, 16, 2),
(6, 1, 2),
(6, 10, 1),
(7, 1, 1),
(7, 4, 2),
(8, 1, 2),
(8, 11, 1),
(9, 4, 2),
(9, 12, 1),
(10, 5, 2),
(10, 13, 1),
(11, 14, 1),
(11, 16, 2),
(12, 1, 2),
(12, 15, 1);

-- --------------------------------------------------------

--
-- Structure de la table `chauffeur`
--

CREATE TABLE `chauffeur` (
  `id_user` int(11) NOT NULL,
  `date_permis` date DEFAULT NULL,
  `id_ligne` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT 0,
  `medaille` varchar(50) DEFAULT NULL,
  `anciennete_permis` int(11) DEFAULT 0,
  `annee_vehicule` int(11) DEFAULT 0,
  `type_vehicule` varchar(50) NOT NULL,
  `ligne_bus` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `chauffeur`
--

INSERT INTO `chauffeur` (`id_user`, `date_permis`, `id_ligne`, `points`, `medaille`, `anciennete_permis`, `annee_vehicule`, `type_vehicule`, `ligne_bus`) VALUES
(27, '2005-01-12', 0, 0, NULL, 0, 2016, 'bus', ''),
(28, '2004-01-12', NULL, 0, NULL, 0, 2016, 'taxi', ''),
(30, '2005-01-12', NULL, 0, NULL, 0, 2016, 'taxi', ''),
(31, '0000-00-00', NULL, 12, '0', 18, 2020, 'taxi', ''),
(32, '0000-00-00', NULL, 15, '0', 14, 2021, 'taxi', ''),
(33, '0000-00-00', NULL, 10, '0', 24, 2019, 'taxi', ''),
(38, '0000-00-00', NULL, 14, '0', 20, 2022, 'personnel', ''),
(39, '0000-00-00', NULL, 16, '0', 12, 2023, 'personnel', ''),
(40, '0000-00-00', NULL, 15, '0', 16, 2021, 'personnel', '');

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id_user` int(11) NOT NULL,
  `date_inscription` date DEFAULT NULL,
  `nb_trajets` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id_user`, `date_inscription`, `nb_trajets`) VALUES
(2, '2023-01-01', 0),
(29, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `evaluation`
--

CREATE TABLE `evaluation` (
  `id_evaluation` int(11) NOT NULL,
  `date_heure` datetime DEFAULT NULL,
  `commentaire` text DEFAULT NULL,
  `note` int(11) DEFAULT NULL,
  `id_client` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `moto`
--

CREATE TABLE `moto` (
  `id_vehicule` int(11) NOT NULL,
  `cylindree` int(11) DEFAULT NULL,
  `type_moteur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `position_bus`
--

CREATE TABLE `position_bus` (
  `position_id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `vitesse` int(11) DEFAULT 0,
  `direction` int(11) DEFAULT NULL,
  `precision_gps` decimal(5,2) DEFAULT NULL,
  `batterie_level` int(11) DEFAULT NULL,
  `timestamp_position` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `position_bus`
--

INSERT INTO `position_bus` (`position_id`, `bus_id`, `latitude`, `longitude`, `vitesse`, `direction`, `precision_gps`, `batterie_level`, `timestamp_position`) VALUES
(1, 1, 31.62997000, -7.98471000, 7, 348, 6.00, 31, '2025-12-18 22:58:10'),
(2, 1, 31.62912000, -7.98105000, 39, 54, 8.00, 57, '2025-12-18 22:58:10'),
(3, 1, 31.63188000, -7.99094000, 29, 100, 8.00, 47, '2025-12-18 22:58:10'),
(4, 1, 31.62593000, -7.98874000, 15, 25, 7.00, 97, '2025-12-18 22:58:10'),
(5, 2, 31.63687000, -7.99169000, 46, 228, 9.00, 58, '2025-12-18 22:58:10'),
(6, 2, 31.62420000, -7.97702000, 10, 270, 2.00, 26, '2025-12-18 22:58:10'),
(7, 2, 31.63555000, -7.98849000, 29, 219, 8.00, 96, '2025-12-18 22:58:10'),
(8, 2, 31.62986000, -7.98511000, 19, 263, 5.00, 53, '2025-12-18 22:58:10'),
(9, 3, 31.63266000, -7.98684000, 5, 271, 10.00, 78, '2025-12-18 22:58:10'),
(10, 3, 31.63639000, -7.98760000, 28, 291, 9.00, 38, '2025-12-18 22:58:10'),
(11, 3, 31.62628000, -7.98918000, 39, 158, 9.00, 40, '2025-12-18 22:58:10'),
(12, 4, 31.63539000, -7.98342000, 0, 298, 8.00, 32, '2025-12-18 22:58:10'),
(13, 4, 31.63007000, -7.98495000, 17, 349, 3.00, 37, '2025-12-18 22:58:10'),
(14, 5, 31.63964000, -7.97994000, 28, 168, 1.00, 83, '2025-12-18 22:58:10'),
(15, 5, 31.63120000, -7.98005000, 37, 198, 1.00, 85, '2025-12-18 22:58:10'),
(16, 6, 31.64162000, -7.97457000, 2, 199, 8.00, 93, '2025-12-18 22:58:10'),
(17, 6, 31.62992000, -7.98470000, 18, 103, 5.00, 21, '2025-12-18 22:58:10'),
(18, 7, 31.63048000, -7.98487000, 10, 102, 9.00, 99, '2025-12-18 22:58:10'),
(19, 7, 31.62533000, -7.98893000, 21, 251, 2.00, 93, '2025-12-18 22:58:10'),
(20, 8, 31.62654000, -7.97834000, 43, 5, 2.00, 37, '2025-12-18 22:58:10'),
(21, 8, 31.62982000, -7.98463000, 7, 196, 7.00, 24, '2025-12-18 22:58:10'),
(22, 9, 31.61975000, -7.97048000, 14, 72, 1.00, 71, '2025-12-18 22:58:10'),
(23, 9, 31.62627000, -7.98855000, 24, 32, 2.00, 20, '2025-12-18 22:58:10'),
(24, 10, 31.63421000, -7.99338000, 20, 76, 2.00, 50, '2025-12-18 22:58:10'),
(25, 10, 31.63705000, -7.99152000, 26, 144, 4.00, 54, '2025-12-18 22:58:10'),
(26, 11, 31.63788000, -7.98078000, 1, 284, 1.00, 53, '2025-12-18 22:58:10'),
(27, 11, 31.63123000, -7.97957000, 49, 87, 3.00, 91, '2025-12-18 22:58:10'),
(28, 12, 31.63883000, -7.98390000, 12, 122, 4.00, 51, '2025-12-18 22:58:10'),
(29, 12, 31.62965000, -7.98502000, 23, 173, 5.00, 95, '2025-12-18 22:58:10'),
(30, 1, 31.62971000, -7.98468000, 13, 215, 4.00, 85, '2025-12-18 23:03:51'),
(31, 1, 31.62889000, -7.98079000, 20, 290, 6.00, 69, '2025-12-18 23:03:51'),
(32, 1, 31.63206000, -7.99088000, 0, 352, 10.00, 43, '2025-12-18 23:03:51'),
(33, 1, 31.62629000, -7.98873000, 21, 31, 3.00, 85, '2025-12-18 23:03:51'),
(34, 2, 31.63657000, -7.99194000, 7, 332, 1.00, 35, '2025-12-18 23:03:51'),
(35, 2, 31.62416000, -7.97699000, 15, 38, 9.00, 26, '2025-12-18 23:03:51'),
(36, 2, 31.63575000, -7.98800000, 48, 231, 9.00, 57, '2025-12-18 23:03:51'),
(37, 2, 31.63022000, -7.98544000, 42, 284, 8.00, 43, '2025-12-18 23:03:51'),
(38, 3, 31.63267000, -7.98709000, 2, 131, 4.00, 64, '2025-12-18 23:03:51'),
(39, 3, 31.63599000, -7.98834000, 30, 236, 7.00, 50, '2025-12-18 23:03:51'),
(40, 3, 31.62596000, -7.98896000, 9, 103, 5.00, 29, '2025-12-18 23:03:51'),
(41, 4, 31.63517000, -7.98322000, 43, 198, 4.00, 57, '2025-12-18 23:03:51'),
(42, 4, 31.63024000, -7.98473000, 32, 59, 5.00, 66, '2025-12-18 23:03:51'),
(43, 5, 31.63980000, -7.98004000, 50, 238, 2.00, 35, '2025-12-18 23:03:51'),
(44, 5, 31.63099000, -7.98010000, 44, 9, 10.00, 96, '2025-12-18 23:03:51'),
(45, 6, 31.64244000, -7.97476000, 26, 292, 10.00, 95, '2025-12-18 23:03:51'),
(46, 6, 31.62990000, -7.98529000, 4, 8, 10.00, 33, '2025-12-18 23:03:51'),
(47, 7, 31.62957000, -7.98473000, 30, 76, 10.00, 53, '2025-12-18 23:03:51'),
(48, 7, 31.62570000, -7.98852000, 5, 75, 8.00, 63, '2025-12-18 23:03:51'),
(49, 8, 31.62721000, -7.97752000, 3, 207, 4.00, 84, '2025-12-18 23:03:51'),
(50, 8, 31.62962000, -7.98453000, 27, 48, 2.00, 51, '2025-12-18 23:03:51'),
(51, 9, 31.62035000, -7.97048000, 29, 153, 2.00, 70, '2025-12-18 23:03:51'),
(52, 9, 31.62579000, -7.98923000, 6, 295, 10.00, 62, '2025-12-18 23:03:51'),
(53, 10, 31.63355000, -7.99349000, 8, 188, 8.00, 60, '2025-12-18 23:03:51'),
(54, 10, 31.63713000, -7.99196000, 36, 308, 9.00, 87, '2025-12-18 23:03:51'),
(55, 11, 31.63841000, -7.98077000, 46, 25, 6.00, 37, '2025-12-18 23:03:51'),
(56, 11, 31.63147000, -7.97951000, 16, 130, 9.00, 79, '2025-12-18 23:03:51'),
(57, 12, 31.63922000, -7.98435000, 11, 142, 2.00, 81, '2025-12-18 23:03:51'),
(58, 12, 31.63009000, -7.98532000, 2, 175, 8.00, 48, '2025-12-18 23:03:51'),
(59, 1, 31.62962000, -7.98467000, 48, 150, 3.00, 20, '2025-12-18 23:09:57'),
(60, 1, 31.62909000, -7.98090000, 40, 168, 1.00, 35, '2025-12-18 23:09:57'),
(61, 1, 31.63161000, -7.99137000, 1, 352, 5.00, 23, '2025-12-18 23:09:57'),
(62, 1, 31.62566000, -7.98909000, 21, 10, 4.00, 28, '2025-12-18 23:09:57'),
(63, 2, 31.63744000, -7.99231000, 21, 69, 8.00, 97, '2025-12-18 23:09:57'),
(64, 2, 31.62360000, -7.97738000, 10, 50, 6.00, 58, '2025-12-18 23:09:57'),
(65, 2, 31.63650000, -7.98839000, 4, 245, 2.00, 55, '2025-12-18 23:09:57'),
(66, 2, 31.63036000, -7.98535000, 47, 247, 5.00, 28, '2025-12-18 23:09:57'),
(67, 3, 31.63290000, -7.98730000, 16, 319, 6.00, 56, '2025-12-18 23:09:57'),
(68, 3, 31.63560000, -7.98750000, 44, 339, 2.00, 44, '2025-12-18 23:09:57'),
(69, 3, 31.62534000, -7.98946000, 47, 26, 5.00, 59, '2025-12-18 23:09:57'),
(70, 4, 31.63452000, -7.98321000, 20, 143, 1.00, 47, '2025-12-18 23:09:57'),
(71, 4, 31.63021000, -7.98499000, 37, 159, 10.00, 33, '2025-12-18 23:09:57'),
(72, 5, 31.63960000, -7.98004000, 30, 349, 5.00, 63, '2025-12-18 23:09:57'),
(73, 5, 31.63130000, -7.97954000, 16, 4, 9.00, 57, '2025-12-18 23:09:57'),
(74, 6, 31.64181000, -7.97460000, 10, 141, 4.00, 53, '2025-12-18 23:09:57'),
(75, 6, 31.63023000, -7.98459000, 6, 178, 4.00, 75, '2025-12-18 23:09:57'),
(76, 7, 31.63001000, -7.98469000, 12, 254, 3.00, 73, '2025-12-18 23:09:57'),
(77, 7, 31.62551000, -7.98885000, 8, 221, 1.00, 35, '2025-12-18 23:09:57'),
(78, 8, 31.62706000, -7.97756000, 13, 218, 2.00, 74, '2025-12-18 23:09:57'),
(79, 8, 31.62989000, -7.98537000, 33, 0, 4.00, 44, '2025-12-18 23:09:57'),
(80, 9, 31.62041000, -7.96989000, 3, 78, 4.00, 77, '2025-12-18 23:09:57'),
(81, 9, 31.62587000, -7.98913000, 1, 259, 5.00, 45, '2025-12-18 23:09:57'),
(82, 10, 31.63436000, -7.99340000, 14, 337, 6.00, 48, '2025-12-18 23:09:57'),
(83, 10, 31.63728000, -7.99172000, 39, 64, 7.00, 72, '2025-12-18 23:09:57'),
(84, 11, 31.63778000, -7.98082000, 46, 103, 8.00, 72, '2025-12-18 23:09:57'),
(85, 11, 31.63108000, -7.98041000, 10, 317, 6.00, 52, '2025-12-18 23:09:57'),
(86, 12, 31.63906000, -7.98382000, 9, 67, 7.00, 55, '2025-12-18 23:09:57'),
(87, 12, 31.62952000, -7.98511000, 28, 271, 4.00, 24, '2025-12-18 23:09:57'),
(88, 1, 31.63031000, -7.98459000, 37, 163, 5.00, 57, '2025-12-21 13:03:19'),
(89, 1, 31.62897000, -7.98139000, 39, 107, 3.00, 82, '2025-12-21 13:03:19'),
(90, 1, 31.63168000, -7.99117000, 45, 307, 10.00, 25, '2025-12-21 13:03:19'),
(91, 1, 31.62564000, -7.98922000, 42, 244, 5.00, 60, '2025-12-21 13:03:19'),
(92, 2, 31.63006000, -7.98543000, 38, 266, 8.00, 84, '2025-12-21 13:03:19'),
(93, 3, 31.62587000, -7.98851000, 14, 47, 8.00, 84, '2025-12-21 13:03:19'),
(94, 4, 31.63050000, -7.98544000, 50, 284, 10.00, 53, '2025-12-21 13:03:19'),
(95, 6, 31.63015000, -7.98526000, 50, 196, 1.00, 42, '2025-12-21 13:03:19'),
(96, 7, 31.62966000, -7.98500000, 44, 355, 8.00, 98, '2025-12-21 13:03:19'),
(97, 7, 31.62587000, -7.98887000, 3, 228, 7.00, 90, '2025-12-21 13:03:19'),
(98, 8, 31.63018000, -7.98493000, 18, 92, 6.00, 91, '2025-12-21 13:03:19'),
(99, 9, 31.62621000, -7.98866000, 20, 288, 10.00, 22, '2025-12-21 13:03:19'),
(100, 12, 31.62988000, -7.98520000, 38, 254, 4.00, 40, '2025-12-21 13:03:19'),
(101, 1, 31.63003000, -7.98549000, 38, 74, 1.00, 45, '2025-12-21 13:09:34'),
(102, 1, 31.62896000, -7.98061000, 4, 106, 10.00, 95, '2025-12-21 13:09:34'),
(103, 1, 31.63232000, -7.99106000, 16, 140, 8.00, 29, '2025-12-21 13:09:34'),
(104, 1, 31.62564000, -7.98857000, 6, 51, 7.00, 55, '2025-12-21 13:09:34'),
(105, 2, 31.63026000, -7.98487000, 20, 189, 4.00, 74, '2025-12-21 13:09:35'),
(106, 3, 31.62603000, -7.98936000, 50, 38, 7.00, 73, '2025-12-21 13:09:35'),
(107, 4, 31.62999000, -7.98522000, 22, 59, 8.00, 83, '2025-12-21 13:09:35'),
(108, 6, 31.63046000, -7.98523000, 47, 200, 2.00, 23, '2025-12-21 13:09:35'),
(109, 7, 31.63048000, -7.98501000, 42, 152, 5.00, 51, '2025-12-21 13:09:35'),
(110, 7, 31.62586000, -7.98892000, 23, 213, 10.00, 95, '2025-12-21 13:09:35'),
(111, 8, 31.62957000, -7.98452000, 7, 52, 9.00, 84, '2025-12-21 13:09:35'),
(112, 9, 31.62550000, -7.98859000, 28, 204, 1.00, 27, '2025-12-21 13:09:35'),
(113, 12, 31.62999000, -7.98542000, 40, 236, 4.00, 80, '2025-12-21 13:09:35'),
(114, 1, 31.63015000, -7.98521000, 33, 203, 6.00, 72, '2025-12-21 13:11:52'),
(115, 1, 31.62914000, -7.98128000, 44, 273, 8.00, 60, '2025-12-21 13:11:52'),
(116, 1, 31.63222000, -7.99105000, 23, 307, 8.00, 49, '2025-12-21 13:11:52'),
(117, 1, 31.62615000, -7.98928000, 15, 297, 3.00, 37, '2025-12-21 13:11:52'),
(118, 2, 31.63012000, -7.98544000, 4, 193, 4.00, 55, '2025-12-21 13:11:52'),
(119, 3, 31.62624000, -7.98868000, 50, 254, 10.00, 43, '2025-12-21 13:11:52'),
(120, 4, 31.62972000, -7.98532000, 9, 277, 4.00, 79, '2025-12-21 13:11:52'),
(121, 6, 31.63036000, -7.98474000, 3, 82, 3.00, 65, '2025-12-21 13:11:52'),
(122, 7, 31.63014000, -7.98522000, 39, 356, 3.00, 43, '2025-12-21 13:11:52'),
(123, 7, 31.62573000, -7.98869000, 17, 312, 8.00, 68, '2025-12-21 13:11:52'),
(124, 8, 31.62997000, -7.98513000, 9, 313, 8.00, 51, '2025-12-21 13:11:52'),
(125, 9, 31.62570000, -7.98872000, 24, 317, 8.00, 77, '2025-12-21 13:11:52'),
(126, 12, 31.62981000, -7.98460000, 37, 54, 3.00, 34, '2025-12-21 13:11:52'),
(127, 1, 31.62986000, -7.98550000, 4, 215, 9.00, 56, '2025-12-21 13:14:37'),
(128, 1, 31.62885000, -7.98085000, 11, 95, 3.00, 93, '2025-12-21 13:14:37'),
(129, 1, 31.63156000, -7.99084000, 6, 35, 3.00, 92, '2025-12-21 13:14:37'),
(130, 1, 31.62561000, -7.98929000, 0, 157, 3.00, 76, '2025-12-21 13:14:37'),
(131, 2, 31.62975000, -7.98479000, 14, 179, 10.00, 52, '2025-12-21 13:14:37'),
(132, 3, 31.62544000, -7.98897000, 35, 85, 5.00, 39, '2025-12-21 13:14:37'),
(133, 4, 31.63014000, -7.98540000, 15, 303, 1.00, 21, '2025-12-21 13:14:37'),
(134, 6, 31.63030000, -7.98528000, 15, 172, 3.00, 76, '2025-12-21 13:14:37'),
(135, 7, 31.62974000, -7.98488000, 19, 49, 9.00, 85, '2025-12-21 13:14:37'),
(136, 7, 31.62622000, -7.98871000, 45, 149, 6.00, 51, '2025-12-21 13:14:37'),
(137, 8, 31.62994000, -7.98519000, 17, 172, 9.00, 47, '2025-12-21 13:14:37'),
(138, 9, 31.62583000, -7.98944000, 15, 354, 5.00, 65, '2025-12-21 13:14:37'),
(139, 12, 31.62957000, -7.98509000, 15, 313, 1.00, 74, '2025-12-21 13:14:37'),
(140, 1, 31.63005000, -7.98490000, 46, 284, 5.00, 84, '2025-12-21 13:14:44'),
(141, 1, 31.62931000, -7.98087000, 13, 88, 3.00, 23, '2025-12-21 13:14:44'),
(142, 1, 31.63239000, -7.99104000, 49, 143, 3.00, 46, '2025-12-21 13:14:44'),
(143, 1, 31.62601000, -7.98876000, 18, 238, 7.00, 79, '2025-12-21 13:14:44'),
(144, 2, 31.62956000, -7.98521000, 24, 340, 7.00, 26, '2025-12-21 13:14:44'),
(145, 3, 31.62628000, -7.98862000, 8, 77, 3.00, 42, '2025-12-21 13:14:44'),
(146, 4, 31.63043000, -7.98529000, 42, 231, 1.00, 26, '2025-12-21 13:14:44'),
(147, 6, 31.62993000, -7.98532000, 6, 13, 6.00, 100, '2025-12-21 13:14:44'),
(148, 7, 31.63013000, -7.98522000, 19, 122, 8.00, 72, '2025-12-21 13:14:44'),
(149, 7, 31.62621000, -7.98903000, 24, 340, 2.00, 79, '2025-12-21 13:14:44'),
(150, 8, 31.62984000, -7.98450000, 49, 21, 10.00, 84, '2025-12-21 13:14:44'),
(151, 9, 31.62552000, -7.98941000, 12, 90, 5.00, 46, '2025-12-21 13:14:44'),
(152, 12, 31.62982000, -7.98506000, 4, 4, 5.00, 83, '2025-12-21 13:14:44'),
(153, 1, 31.63005000, -7.98542000, 18, 323, 10.00, 70, '2025-12-21 13:16:59'),
(154, 1, 31.62901000, -7.98103000, 47, 319, 4.00, 94, '2025-12-21 13:16:59'),
(155, 1, 31.63167000, -7.99071000, 12, 68, 3.00, 77, '2025-12-21 13:16:59'),
(156, 1, 31.62572000, -7.98859000, 41, 241, 1.00, 31, '2025-12-21 13:16:59'),
(157, 2, 31.62980000, -7.98535000, 39, 358, 1.00, 81, '2025-12-21 13:16:59'),
(158, 3, 31.62567000, -7.98866000, 4, 238, 6.00, 71, '2025-12-21 13:16:59'),
(159, 4, 31.63043000, -7.98486000, 2, 116, 4.00, 52, '2025-12-21 13:16:59'),
(160, 6, 31.63016000, -7.98539000, 27, 147, 1.00, 61, '2025-12-21 13:16:59'),
(161, 7, 31.62986000, -7.98533000, 7, 326, 3.00, 33, '2025-12-21 13:16:59'),
(162, 7, 31.62611000, -7.98868000, 47, 25, 5.00, 38, '2025-12-21 13:16:59'),
(163, 8, 31.63012000, -7.98502000, 4, 300, 10.00, 84, '2025-12-21 13:16:59'),
(164, 9, 31.62573000, -7.98944000, 22, 90, 2.00, 84, '2025-12-21 13:16:59'),
(165, 12, 31.62961000, -7.98541000, 25, 248, 7.00, 86, '2025-12-21 13:16:59'),
(166, 1, 31.63048000, -7.98463000, 48, 9, 2.00, 47, '2025-12-21 13:17:00'),
(167, 1, 31.62927000, -7.98137000, 39, 290, 6.00, 38, '2025-12-21 13:17:00'),
(168, 1, 31.63205000, -7.99138000, 31, 183, 7.00, 38, '2025-12-21 13:17:00'),
(169, 1, 31.62564000, -7.98938000, 49, 265, 10.00, 83, '2025-12-21 13:17:00'),
(170, 2, 31.63041000, -7.98473000, 34, 75, 3.00, 40, '2025-12-21 13:17:00'),
(171, 3, 31.62586000, -7.98921000, 50, 28, 10.00, 43, '2025-12-21 13:17:00'),
(172, 4, 31.63034000, -7.98540000, 48, 349, 2.00, 72, '2025-12-21 13:17:00'),
(173, 6, 31.62982000, -7.98454000, 5, 266, 9.00, 74, '2025-12-21 13:17:00'),
(174, 7, 31.62991000, -7.98548000, 19, 24, 1.00, 70, '2025-12-21 13:17:00'),
(175, 7, 31.62625000, -7.98940000, 36, 198, 10.00, 63, '2025-12-21 13:17:00'),
(176, 8, 31.62979000, -7.98491000, 7, 21, 2.00, 97, '2025-12-21 13:17:00'),
(177, 9, 31.62561000, -7.98869000, 22, 127, 4.00, 81, '2025-12-21 13:17:00'),
(178, 12, 31.62954000, -7.98497000, 3, 210, 9.00, 94, '2025-12-21 13:17:00'),
(179, 1, 31.62996000, -7.98527000, 12, 292, 1.00, 76, '2025-12-21 13:17:02'),
(180, 1, 31.62889000, -7.98150000, 10, 184, 4.00, 49, '2025-12-21 13:17:02'),
(181, 1, 31.63178000, -7.99070000, 37, 264, 9.00, 60, '2025-12-21 13:17:02'),
(182, 1, 31.62549000, -7.98933000, 12, 70, 7.00, 45, '2025-12-21 13:17:02'),
(183, 2, 31.63038000, -7.98479000, 29, 326, 10.00, 70, '2025-12-21 13:17:02'),
(184, 3, 31.62576000, -7.98917000, 35, 83, 7.00, 60, '2025-12-21 13:17:02'),
(185, 4, 31.63048000, -7.98547000, 6, 318, 10.00, 34, '2025-12-21 13:17:02'),
(186, 6, 31.63026000, -7.98464000, 37, 37, 10.00, 83, '2025-12-21 13:17:02'),
(187, 7, 31.63031000, -7.98451000, 29, 256, 4.00, 35, '2025-12-21 13:17:02'),
(188, 7, 31.62570000, -7.98887000, 8, 30, 3.00, 76, '2025-12-21 13:17:02'),
(189, 8, 31.62952000, -7.98529000, 32, 1, 3.00, 85, '2025-12-21 13:17:02'),
(190, 9, 31.62584000, -7.98850000, 29, 38, 2.00, 31, '2025-12-21 13:17:02'),
(191, 12, 31.62973000, -7.98528000, 4, 315, 9.00, 33, '2025-12-21 13:17:02'),
(192, 1, 31.62995000, -7.98508000, 6, 247, 5.00, 63, '2025-12-21 13:23:58'),
(193, 1, 31.62937000, -7.98074000, 17, 93, 4.00, 44, '2025-12-21 13:23:58'),
(194, 1, 31.63213000, -7.99057000, 0, 263, 4.00, 21, '2025-12-21 13:23:58'),
(195, 1, 31.62572000, -7.98907000, 41, 327, 7.00, 72, '2025-12-21 13:23:58'),
(196, 2, 31.62966000, -7.98544000, 44, 257, 2.00, 41, '2025-12-21 13:23:58'),
(197, 3, 31.62622000, -7.98926000, 25, 95, 2.00, 38, '2025-12-21 13:23:58'),
(198, 4, 31.63030000, -7.98536000, 26, 149, 8.00, 35, '2025-12-21 13:23:58'),
(199, 6, 31.62970000, -7.98540000, 37, 218, 1.00, 36, '2025-12-21 13:23:58'),
(200, 7, 31.63024000, -7.98473000, 39, 85, 4.00, 78, '2025-12-21 13:23:58'),
(201, 7, 31.62536000, -7.98870000, 23, 325, 9.00, 64, '2025-12-21 13:23:58'),
(202, 8, 31.62964000, -7.98502000, 17, 315, 6.00, 26, '2025-12-21 13:23:58'),
(203, 9, 31.62615000, -7.98946000, 13, 103, 2.00, 34, '2025-12-21 13:23:58'),
(204, 12, 31.62998000, -7.98528000, 35, 266, 2.00, 90, '2025-12-21 13:23:58'),
(205, 1, 31.62981000, -7.98510000, 9, 23, 10.00, 45, '2025-12-21 13:24:55'),
(206, 1, 31.62916000, -7.98132000, 36, 68, 9.00, 75, '2025-12-21 13:24:55'),
(207, 1, 31.63206000, -7.99111000, 41, 179, 10.00, 55, '2025-12-21 13:24:55'),
(208, 1, 31.62578000, -7.98926000, 26, 62, 1.00, 55, '2025-12-21 13:24:55'),
(209, 2, 31.63012000, -7.98538000, 6, 51, 1.00, 50, '2025-12-21 13:24:55'),
(210, 3, 31.62548000, -7.98917000, 19, 167, 1.00, 88, '2025-12-21 13:24:55'),
(211, 4, 31.62974000, -7.98476000, 14, 150, 6.00, 52, '2025-12-21 13:24:55'),
(212, 6, 31.62971000, -7.98457000, 33, 115, 7.00, 57, '2025-12-21 13:24:55'),
(213, 7, 31.63031000, -7.98542000, 28, 213, 7.00, 72, '2025-12-21 13:24:55'),
(214, 7, 31.62589000, -7.98920000, 2, 115, 3.00, 37, '2025-12-21 13:24:55'),
(215, 8, 31.63048000, -7.98504000, 28, 44, 9.00, 36, '2025-12-21 13:24:55'),
(216, 9, 31.62581000, -7.98878000, 45, 317, 9.00, 44, '2025-12-21 13:24:55'),
(217, 12, 31.63042000, -7.98541000, 11, 346, 9.00, 39, '2025-12-21 13:24:55');

-- --------------------------------------------------------

--
-- Structure de la table `taxi`
--

CREATE TABLE `taxi` (
  `id_vehicule` int(11) NOT NULL,
  `numero_licence` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `trajet`
--

CREATE TABLE `trajet` (
  `trajet_id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `arret_id` int(11) NOT NULL,
  `ordre_passage` int(11) NOT NULL,
  `horaire_theorique` time DEFAULT NULL,
  `temps_arret_min` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `trajet`
--

INSERT INTO `trajet` (`trajet_id`, `bus_id`, `arret_id`, `ordre_passage`, `horaire_theorique`, `temps_arret_min`) VALUES
(1, 1, 1, 1, '20:13:00', 5),
(2, 1, 2, 2, '20:19:00', 3),
(3, 1, 3, 3, '20:33:00', 2),
(4, 1, 4, 4, '20:46:00', 1),
(5, 2, 5, 1, '19:03:00', 5),
(6, 2, 6, 2, '19:11:00', 1),
(7, 2, 7, 3, '19:23:00', 2),
(8, 2, 1, 4, '19:30:00', 1),
(9, 3, 17, 1, '15:36:00', 4),
(10, 3, 7, 2, '15:45:00', 2),
(11, 3, 4, 3, '15:58:00', 2),
(12, 4, 8, 1, '06:45:00', 4),
(13, 4, 1, 2, '06:55:00', 2),
(14, 5, 9, 1, '20:57:00', 2),
(15, 5, 16, 2, '21:03:00', 2),
(16, 6, 10, 1, '14:47:00', 1),
(17, 6, 1, 2, '14:57:00', 4),
(18, 7, 1, 1, '20:58:00', 3),
(19, 7, 4, 2, '21:13:00', 5),
(20, 8, 11, 1, '18:47:00', 4),
(21, 8, 1, 2, '18:54:00', 4),
(22, 9, 12, 1, '08:49:00', 5),
(23, 9, 4, 2, '09:00:00', 5),
(24, 10, 13, 1, '17:13:00', 4),
(25, 10, 5, 2, '17:21:00', 5),
(26, 11, 14, 1, '07:30:00', 4),
(27, 11, 16, 2, '07:45:00', 4),
(28, 12, 15, 1, '20:32:00', 2),
(29, 12, 1, 2, '20:45:00', 4);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id_user` int(11) NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_user`, `nom`, `prenom`, `email`, `telephone`, `mot_de_passe`, `date_naissance`) VALUES
(1, 'Test', 'Chauffeur', 'chauffeur@test.com', NULL, '1234', NULL),
(2, 'Test', 'Client', 'client@test.com', NULL, '1234', NULL),
(27, 'zakaria', 'taha', 'TAHAzakaria2019@gmail.com', '0696230023', '$2y$10$QryazBSJrmxrD2hBDozvteu9tn4Hs.PUXMm/J3ULG4.IDPZwxfNuu', '2005-01-12'),
(28, 'el zahni', 'ilyass', 'ilyaszahni@gmail.com', '0661974333', '$2y$10$eSVOyfB38/bBJiVBDYbQR.VrGrQM8r13AM60CYIfw5NXGoWRyBP8K', '2004-01-12'),
(29, 'el hathout', 'saad', 'mohamedtaha.zakaria@emsi-edu.ma', '0666666', '$2y$10$blFSYCqH.5HvPfyg6pMaPOQraN//5TFfeeNy1O.zJGjagedqvS97a', '2000-01-01'),
(30, 'bounya', 'amine', 'istpzakaria@gmail.com', '0776543', '$2y$10$znWOCcelCGwqtyxnRVgSFekKlLahSdA1PNYWrh5NNy.GctEdLFoyC', '2005-01-12'),
(31, 'El Amrani', 'Youssef', 'youssef.elamrani@example.com', '0612345678', '$2y$10$dJ/tdQ4GGjbQ9meVI7VRVOashOcHO5Jbv2OOi/eMU25M1E8alUPpa', '1985-05-12'),
(32, 'Bennani', 'Karim', 'karim.bennani@example.com', '0623456789', '$2y$10$m2ZWhFizzxb.YBpA1yzm/eNIiy4XrEeq3NBgulECrtfz.XR8J.DjC', '1990-08-30'),
(33, 'Alaoui', 'Hamza', 'hamza.alaoui@example.com', '0634567890', '$2y$10$Nmzb7FJHVokiTQQTv6BOAOmj2ZbKQt6rzp9Kog.0YpspJRfO0AUlG', '1982-11-02'),
(38, 'Sahraoui', 'Rachid', 'rachid.sahraoui@example.com', '0641234567', '$2y$10$iFaKRIM/8Ke2H3mvFzLTlOD0GrpYkCuj5OyZQR5KnLTiE/Tsl00Zy', '1983-02-15'),
(39, 'Khalfi', 'Sara', 'sara.khalfi@example.com', '0652345678', '$2y$10$.biaK19VtNRQp1fZsfF/G.QvtObla8XkqfTWkzwJwrS4vMvKmApLO', '1991-07-10'),
(40, 'Bouhaddi', 'Yassine', 'yassine.bouhaddi@example.com', '0663456789', '$2y$10$wzCjn7Tq0aTRMflIdcYmw.tGnAvtWH1K0i38FSy1xdfELHmWIlW7e', '1987-11-25');

-- --------------------------------------------------------

--
-- Structure de la table `vehicule`
--

CREATE TABLE `vehicule` (
  `id_vehicule` int(11) NOT NULL,
  `marque` varchar(100) DEFAULT NULL,
  `modele` varchar(100) DEFAULT NULL,
  `annee` int(11) DEFAULT NULL,
  `id_chauffeur` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `voiture_confort`
--

CREATE TABLE `voiture_confort` (
  `id_vehicule` int(11) NOT NULL,
  `climatisation` tinyint(1) DEFAULT NULL,
  `siege_confort` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `voiture_normale`
--

CREATE TABLE `voiture_normale` (
  `id_vehicule` int(11) NOT NULL,
  `eco_level` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `arret`
--
ALTER TABLE `arret`
  ADD PRIMARY KEY (`arret_id`),
  ADD UNIQUE KEY `nom_arret` (`nom_arret`);

--
-- Index pour la table `avertissement`
--
ALTER TABLE `avertissement`
  ADD PRIMARY KEY (`avertissement_id`),
  ADD KEY `idx_bus_actif` (`bus_id`,`est_actif`),
  ADD KEY `idx_periode` (`debut_avertissement`,`fin_avertissement`);

--
-- Index pour la table `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`bus_id`),
  ADD UNIQUE KEY `numero_bus` (`numero_bus`);

--
-- Index pour la table `bus_arret`
--
ALTER TABLE `bus_arret`
  ADD PRIMARY KEY (`bus_id`,`arret_id`),
  ADD KEY `arret_id` (`arret_id`);

--
-- Index pour la table `chauffeur`
--
ALTER TABLE `chauffeur`
  ADD PRIMARY KEY (`id_user`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_user`);

--
-- Index pour la table `evaluation`
--
ALTER TABLE `evaluation`
  ADD PRIMARY KEY (`id_evaluation`),
  ADD KEY `id_client` (`id_client`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `moto`
--
ALTER TABLE `moto`
  ADD PRIMARY KEY (`id_vehicule`);

--
-- Index pour la table `position_bus`
--
ALTER TABLE `position_bus`
  ADD PRIMARY KEY (`position_id`),
  ADD KEY `idx_bus_timestamp` (`bus_id`,`timestamp_position`),
  ADD KEY `idx_timestamp` (`timestamp_position`);

--
-- Index pour la table `taxi`
--
ALTER TABLE `taxi`
  ADD PRIMARY KEY (`id_vehicule`);

--
-- Index pour la table `trajet`
--
ALTER TABLE `trajet`
  ADD PRIMARY KEY (`trajet_id`),
  ADD UNIQUE KEY `unique_bus_ordre` (`bus_id`,`ordre_passage`),
  ADD UNIQUE KEY `unique_bus_arret` (`bus_id`,`arret_id`),
  ADD KEY `arret_id` (`arret_id`),
  ADD KEY `idx_bus_ordre` (`bus_id`,`ordre_passage`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `vehicule`
--
ALTER TABLE `vehicule`
  ADD PRIMARY KEY (`id_vehicule`),
  ADD KEY `id_chauffeur` (`id_chauffeur`);

--
-- Index pour la table `voiture_confort`
--
ALTER TABLE `voiture_confort`
  ADD PRIMARY KEY (`id_vehicule`);

--
-- Index pour la table `voiture_normale`
--
ALTER TABLE `voiture_normale`
  ADD PRIMARY KEY (`id_vehicule`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `arret`
--
ALTER TABLE `arret`
  MODIFY `arret_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=273;

--
-- AUTO_INCREMENT pour la table `avertissement`
--
ALTER TABLE `avertissement`
  MODIFY `avertissement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- AUTO_INCREMENT pour la table `bus`
--
ALTER TABLE `bus`
  MODIFY `bus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=361;

--
-- AUTO_INCREMENT pour la table `evaluation`
--
ALTER TABLE `evaluation`
  MODIFY `id_evaluation` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `position_bus`
--
ALTER TABLE `position_bus`
  MODIFY `position_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=218;

--
-- AUTO_INCREMENT pour la table `trajet`
--
ALTER TABLE `trajet`
  MODIFY `trajet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=581;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pour la table `vehicule`
--
ALTER TABLE `vehicule`
  MODIFY `id_vehicule` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `avertissement`
--
ALTER TABLE `avertissement`
  ADD CONSTRAINT `avertissement_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`bus_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bus_arret`
--
ALTER TABLE `bus_arret`
  ADD CONSTRAINT `bus_arret_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`bus_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bus_arret_ibfk_2` FOREIGN KEY (`arret_id`) REFERENCES `arret` (`arret_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `chauffeur`
--
ALTER TABLE `chauffeur`
  ADD CONSTRAINT `chauffeur_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `utilisateur` (`id_user`);

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `utilisateur` (`id_user`);

--
-- Contraintes pour la table `evaluation`
--
ALTER TABLE `evaluation`
  ADD CONSTRAINT `evaluation_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_user`),
  ADD CONSTRAINT `evaluation_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `utilisateur` (`id_user`);

--
-- Contraintes pour la table `moto`
--
ALTER TABLE `moto`
  ADD CONSTRAINT `moto_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicule` (`id_vehicule`);

--
-- Contraintes pour la table `position_bus`
--
ALTER TABLE `position_bus`
  ADD CONSTRAINT `position_bus_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`bus_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `taxi`
--
ALTER TABLE `taxi`
  ADD CONSTRAINT `taxi_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicule` (`id_vehicule`);

--
-- Contraintes pour la table `trajet`
--
ALTER TABLE `trajet`
  ADD CONSTRAINT `trajet_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`bus_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trajet_ibfk_2` FOREIGN KEY (`arret_id`) REFERENCES `arret` (`arret_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `vehicule`
--
ALTER TABLE `vehicule`
  ADD CONSTRAINT `vehicule_ibfk_1` FOREIGN KEY (`id_chauffeur`) REFERENCES `chauffeur` (`id_user`);

--
-- Contraintes pour la table `voiture_confort`
--
ALTER TABLE `voiture_confort`
  ADD CONSTRAINT `voiture_confort_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicule` (`id_vehicule`);

--
-- Contraintes pour la table `voiture_normale`
--
ALTER TABLE `voiture_normale`
  ADD CONSTRAINT `voiture_normale_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicule` (`id_vehicule`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
