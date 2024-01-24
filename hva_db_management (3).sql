-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 24 jan. 2024 à 14:42
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hva_db_management`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_rue` int NOT NULL,
  `code_postal` int NOT NULL,
  `nom_rue` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`id`, `numero_rue`, `code_postal`, `nom_rue`) VALUES
(1, 12, 94600, 'Rue des Robino'),
(2, 29, 94600, 'Rue des Colos'),
(3, 32, 94600, 'Rue Maréchal Juin'),
(4, 8, 94602, 'Rue de Rivoli'),
(5, 15, 94601, 'Quai des Célestins'),
(6, 45, 94603, 'Avenue du Prado'),
(7, 18, 59000, 'Rue de la Paix'),
(8, 5, 13001, 'Cours Julien'),
(9, 22, 75008, 'Avenue Montaigne'),
(10, 18, 59000, 'Rue de la Paix'),
(11, 5, 13001, 'Cours Julien'),
(12, 22, 75008, 'Avenue Montaigne');

-- --------------------------------------------------------

--
-- Structure de la table `budget`
--

DROP TABLE IF EXISTS `budget`;
CREATE TABLE IF NOT EXISTS `budget` (
  `id` int NOT NULL AUTO_INCREMENT,
  `montant` int NOT NULL,
  `annee` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `budget`
--

INSERT INTO `budget` (`id`, `montant`, `annee`) VALUES
(1, 32600, 2025),
(2, 74900, 2029),
(3, 50000, 2025),
(4, 100000, 2029),
(5, 80000, 2025),
(6, 120000, 2030),
(7, 80000, 2025),
(8, 120000, 2030);

-- --------------------------------------------------------

--
-- Structure de la table `comporter`
--

DROP TABLE IF EXISTS `comporter`;
CREATE TABLE IF NOT EXISTS `comporter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projet_id` int NOT NULL,
  `etablissement_id` int NOT NULL,
  PRIMARY KEY (`id`,`projet_id`,`etablissement_id`),
  KEY `projet_id` (`projet_id`),
  KEY `etablissement_id` (`etablissement_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `comporter`
--

INSERT INTO `comporter` (`id`, `projet_id`, `etablissement_id`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 2),
(4, 1, 1),
(5, 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personne_id` int NOT NULL,
  `fonction` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date_embauche` date NOT NULL,
  `date_fin` date DEFAULT NULL,
  `domaine` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`,`personne_id`),
  KEY `personne_id` (`personne_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `employe`
--

INSERT INTO `employe` (`id`, `personne_id`, `fonction`, `date_embauche`, `date_fin`, `domaine`) VALUES
(1, 2, 'Institutrice', '2022-03-14', NULL, 'Ecole Primaire'),
(2, 6, 'Bibliothécaire', '2022-01-15', NULL, 'Culture'),
(3, 3, 'Architecte Paysagist', '2021-09-01', '2023-05-13', 'Urbanisme'),
(4, 4, 'Responsable des Spor', '2022-02-10', NULL, 'Sports'),
(5, 5, 'Directeur Culturel', '2021-11-20', '2032-12-29', 'Culture');

-- --------------------------------------------------------

--
-- Structure de la table `etablissement`
--

DROP TABLE IF EXISTS `etablissement`;
CREATE TABLE IF NOT EXISTS `etablissement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `superficie` int NOT NULL,
  `id_adresse` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adresse_id` (`id_adresse`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `etablissement`
--

INSERT INTO `etablissement` (`id`, `nom`, `description`, `superficie`, `id_adresse`) VALUES
(1, 'Ecole Primaire', 'Ecole accueillant de', 2300, 3),
(2, 'Bibliothèque Central', 'Bibliothèque municip', 1200, 1),
(3, 'Parc Municipal', 'Espace vert ouvert a', 5000, 3),
(4, 'Centre Sportif Munic', 'Installations sporti', 3000, 1),
(5, 'Espace Culturel Poly', 'Salle de spectacle e', 2000, 3);

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prenom` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `situation` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sexe` tinyint(1) NOT NULL,
  `ville_naissance` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date_naissance` date NOT NULL,
  `nationalite` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`id`, `nom`, `prenom`, `situation`, `sexe`, `ville_naissance`, `date_naissance`, `nationalite`) VALUES
(1, 'Murienne', 'Vincent', 'célibataire', 1, 'Paris 14', '2003-02-14', 'Française'),
(2, 'Ouakkouche', 'Hadil', 'célibataire', 0, 'Bejaia', '2001-08-29', 'Algérienne'),
(3, 'Dupont', 'Jean', 'marié', 1, 'Lyon', '1980-05-22', 'Française'),
(4, 'Martin', 'Sophie', 'célibataire', 0, 'Marseille', '1995-10-10', 'Française'),
(5, 'Lefevre', 'Marie', 'mariée', 0, 'Lille', '1985-08-12', 'Française'),
(6, 'Garcia', 'Carlos', 'célibataire', 1, 'Barcelone', '1990-04-25', 'Espagnole'),
(7, 'Lefevre', 'Marie', 'mariée', 0, 'Lille', '1985-08-12', 'Française'),
(8, 'Garcia', 'Carlos', 'célibataire', 1, 'Barcelone', '1990-04-25', 'Espagnole');

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

DROP TABLE IF EXISTS `projet`;
CREATE TABLE IF NOT EXISTS `projet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) NOT NULL,
  `description` varchar(20) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin_prevue` date NOT NULL,
  `id_budget` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_budget` (`id_budget`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `projet`
--

INSERT INTO `projet` (`id`, `nom`, `description`, `date_debut`, `date_fin_prevue`, `id_budget`) VALUES
(1, 'Rénovation Gymnase', 'Rénovation du matéri', '2025-02-14', '2025-08-12', 1),
(2, 'Rénovation Mairie', 'Rénovation de la toi', '2029-01-09', '2029-06-14', 2),
(3, 'Extension Bibliothèq', 'Ajout de nouvelles s', '2025-06-01', '2026-01-01', 1),
(4, 'Réaménagement Parc', 'Modernisation des ai', '2029-03-15', '2029-08-31', 2),
(5, 'Réhabilitation Centr', 'Modernisation des in', '2025-03-01', '2025-09-30', 1),
(6, 'Création Espace Cult', 'Construction salle p', '2030-01-15', '2030-08-31', 2);

-- --------------------------------------------------------

--
-- Structure de la table `rattacher`
--

DROP TABLE IF EXISTS `rattacher`;
CREATE TABLE IF NOT EXISTS `rattacher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `adresse_id` int NOT NULL,
  `personne_id` int NOT NULL,
  PRIMARY KEY (`id`,`adresse_id`,`personne_id`),
  KEY `personne_id` (`personne_id`),
  KEY `adresse_id` (`adresse_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `rattacher`
--

INSERT INTO `rattacher` (`id`, `adresse_id`, `personne_id`) VALUES
(1, 2, 1),
(2, 1, 1),
(3, 3, 2),
(4, 1, 1),
(5, 3, 2);

-- --------------------------------------------------------

--
-- Structure de la table `travailler`
--

DROP TABLE IF EXISTS `travailler`;
CREATE TABLE IF NOT EXISTS `travailler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employe_id` int NOT NULL,
  `etablissement_id` int NOT NULL,
  PRIMARY KEY (`id`,`employe_id`,`etablissement_id`),
  KEY `employe_id` (`employe_id`),
  KEY `etablissement_id` (`etablissement_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `travailler`
--

INSERT INTO `travailler` (`id`, `employe_id`, `etablissement_id`) VALUES
(1, 1, 1),
(2, 4, 4),
(3, 2, 2),
(4, 5, 5);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
