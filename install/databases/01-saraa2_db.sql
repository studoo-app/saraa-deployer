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

--
-- Structure de la table `admins`
--

DROP TABLE IF EXISTS `admins`;
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

DROP TABLE IF EXISTS `assignments`;
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
    ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Structure de la table `classrooms`
--

DROP TABLE IF EXISTS `classrooms`;
CREATE TABLE IF NOT EXISTS `classrooms` (
                                            `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `classrooms`
--

INSERT INTO `classrooms` (`id`, `name`) VALUES
                                            (1, 'SIO 1 INIT'),
                                            (2, 'SIO 1 ALT'),
                                            (3, 'SIO 2 SLAM INIT'),
                                            (4, 'SIO 2 SLAM ALT');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
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
    ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



-- --------------------------------------------------------

--
-- Structure de la table `reports`
--

DROP TABLE IF EXISTS `reports`;
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
    ) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Structure de la table `students`
--

DROP TABLE IF EXISTS `students`;
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
                                                                                                  ('1646a3ae4aa34dbf84ee1477683c3fd7', 1, 'Student 2', 'Test', 'std2@mail.dev', '$2a$14$qiwHZik33kVbhqV5g95bS.rucAWuT7YgRM52VDvC.hlLAWxRO1dbu'),
                                                                                                  ('95c9b718b34749cdaccbef2514a48396', 2, 'student 1', 'Test', 'std1@mail.dev', '$2a$14$KQy/1cvl4r9KgXvmOyYMkOBW8Rnl3ggybhVIyfGsIu4eUncJL6qUu');
-- --------------------------------------------------------

--
-- Structure de la table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
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
