-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : database:3306
-- Généré le : lun. 20 mai 2024 à 12:56
-- Version du serveur : 11.3.2-MariaDB-1:11.3.2+maria~ubu2204
-- Version de PHP : 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `saraa2_db`
--
CREATE DATABASE IF NOT EXISTS `saraa2_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `saraa2_db`;

-- --------------------------------------------------------

--
-- Structure de la table `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `id` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(180) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_admins_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `admins`
--

INSERT INTO `admins` (`id`, `first_name`, `last_name`, `email`, `password`) VALUES
('5031535a1b034504868f124b45136031', 'Admin', 'Saraa', 'admin@mail.dev', '$2a$14$UN4iKEZlEXF1rCzQQDfmWOyux0XtSuomzzRZYYXePUHszz3mdT3KO');

-- --------------------------------------------------------

--
-- Structure de la table `assignments`
--

CREATE TABLE IF NOT EXISTS `assignments` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `created_by_id` varchar(255) DEFAULT NULL,
  `classroom_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `project_type` varchar(255) DEFAULT NULL,
  `tests_repository_name` varchar(255) DEFAULT NULL,
  `due_at` datetime DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_assignments_deleted_at` (`deleted_at`),
  KEY `idx_assignments_classroom_id` (`classroom_id`),
  KEY `fk_teachers_assignments` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `assignments`
--

INSERT INTO `assignments` (`id`, `created_at`, `updated_at`, `deleted_at`, `created_by_id`, `classroom_id`, `title`, `description`, `project_type`, `tests_repository_name`, `due_at`, `slug`) VALUES
(1, '2024-05-03 08:43:37.844', '2024-05-03 08:43:37.844', NULL, 'd96d6c3808514905a4b5bc6dd65c59d8', 2, 'Project Test 1', 'Lorem ipsum , description des attendus du projet', 'symfony', 'Studoo-SARAA/tests-suite-std-project', '2024-05-06 12:30:00', 'pechberty-sio-1-alt-symfony-project-test-1');

-- --------------------------------------------------------

--
-- Structure de la table `classrooms`
--

CREATE TABLE IF NOT EXISTS `classrooms` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `classrooms`
--

INSERT INTO `classrooms` (`id`, `name`) VALUES
(1, 'SIO 1 INIT'),
(2, 'SIO 1 ALT'),
(3, 'SIO 2 SLAM INIT'),
(4, 'SIO 2 SLAM ALT'),
(5, 'SIO 1 INIT'),
(6, 'SIO 1 ALT'),
(7, 'SIO 2 SLAM INIT'),
(8, 'SIO 2 SLAM ALT');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `student_id` varchar(255) DEFAULT NULL,
  `assignment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `source_repository_name` varchar(255) DEFAULT NULL,
  `fork_repository_name` varchar(255) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_jobs_student_id` (`student_id`),
  KEY `idx_jobs_assignment_id` (`assignment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`id`, `student_id`, `assignment_id`, `status`, `source_repository_name`, `fork_repository_name`, `started_at`, `ended_at`) VALUES
(5, '95c9b718b34749cdaccbef2514a48396', 1, 'completed', 'JPechberty/sf-std-project', 'Studoo-SARAA/sf-std-project-936ba855', '2024-05-20 11:52:00', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) UNSIGNED DEFAULT NULL,
  `source_repository_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `score` bigint(20) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  `details` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_reports_job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reports`
--

INSERT INTO `reports` (`id`, `job_id`, `source_repository_name`, `status`, `score`, `started_at`, `ended_at`, `details`) VALUES
(16, 5, 'Studoo-SARAA/sf-std-project-936ba855', 'Done', 100, '2024-05-20 11:52:50', NULL, '[{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testIdIsAutoGenerated\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Id is auto generated\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testIdIsInt\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Id is int\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testDateIsAutoGenerated\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Date is auto generated\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testDateIsDateTime\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Date is date time\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testGetNom\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Get nom\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testSetNom\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Set nom\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testSetWrongTypeNom\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Set wrong type nom\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testGetQuantite\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Get quantite\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testSetQuantite\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Set quantite\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testSetWrongTypeQuantite\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Set wrong type quantite\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testGetDescription\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Get description\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testSetDescription\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Set description\"},{\"ClassName\":\"ProductUnitTest\",\"MethodName\":\"testSetWrongTypeDescription\",\"Status\":\"0\",\"PrettifiedMethodName\":\"Set wrong type description\"}]');

-- --------------------------------------------------------

--
-- Structure de la table `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `id` varchar(255) NOT NULL,
  `classroom_id` bigint(20) UNSIGNED DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(180) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_students_email` (`email`),
  KEY `idx_students_classroom_id` (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `students`
--

INSERT INTO `students` (`id`, `classroom_id`, `first_name`, `last_name`, `email`, `password`) VALUES
('95c9b718b34749cdaccbef2514a48396', 2, 'student 1', 'Test', 'std1@mail.dev', '$2a$14$KQy/1cvl4r9KgXvmOyYMkOBW8Rnl3ggybhVIyfGsIu4eUncJL6qUu');

-- --------------------------------------------------------

--
-- Structure de la table `teachers`
--

CREATE TABLE IF NOT EXISTS `teachers` (
  `id` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(180) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_teachers_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `teachers`
--

INSERT INTO `teachers` (`id`, `first_name`, `last_name`, `email`, `password`) VALUES
('bce54fa7531647f3bce79f5ff8214187', 'Benoit', 'Foujols', 'bf@mail.dev', '$2a$14$qeW2iclfksATdJwqpPHtre6E2PXZ3U2xtoc3lWYzLlsuTwcoBHHWO'),
('d96d6c3808514905a4b5bc6dd65c59d8', 'Julien', 'Pechberty', 'jp@mail.dev', '$2a$14$lbeY13AgutVAdf5eGnBLEeKuxbSKXFE1ttj2TOvzmJMGkpMQ/Ommi');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `fk_classrooms_assignments` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`),
  ADD CONSTRAINT `fk_teachers_assignments` FOREIGN KEY (`created_by_id`) REFERENCES `teachers` (`id`);

--
-- Contraintes pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `fk_assignments_jobs` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`),
  ADD CONSTRAINT `fk_students_jobs` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

--
-- Contraintes pour la table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_jobs_report` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`);

--
-- Contraintes pour la table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_classrooms_students` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
