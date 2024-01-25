-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 25 jan. 2024 à 09:46
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

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `MiseAJourDateFinProjet`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MiseAJourDateFinProjet` (IN `employe_id` INT, IN `projet_id` INT)   BEGIN
  DECLARE projet_id INT;
  DECLARE nb_employes INT;

  -- Récupération de l'ID du projet lié à l'employé
  SELECT projet_id INTO projet_id
  FROM employe
  JOIN travailler ON employe.id = employe_id
  JOIN etablissement ON etablissement.id = travailler.etablissement_id
  JOIN comporter ON etablissement.id = comporter.etablissement_id
  JOIN projet ON projet.id = projet_id ;

  -- Nombre total d'employés associés à ce projet
  SELECT COUNT(*) INTO nb_employes  FROM employe JOIN travailler ON employe.id = employe_id
  JOIN etablissement ON etablissement.id = travailler.etablissement_id
  JOIN comporter ON etablissement.id = comporter.etablissement_id
  JOIN projet ON projet.id = projet_id ;

  -- Si l'employé supprimé est le seul employé associé à ce projet, mise à jour de la date de fin du projet
  IF nb_employes = 0 THEN
    UPDATE Projet
    SET date_fin_prevue = CURRENT_DATE
    WHERE id = projet_id;
  END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_rue` int NOT NULL,
  `code_postal` int NOT NULL,
  `nom_rue` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`id`, `numero_rue`, `code_postal`, `nom_rue`) VALUES
(1, 12, 13300, 'Rue des Robino'),
(2, 29, 13300, 'Rue des Colos'),
(3, 32, 13300, 'Rue Maréchal Juin'),
(4, 8, 13400, 'Rue de Rivoli'),
(5, 15, 13400, 'Quai des Célestins'),
(6, 45, 13300, 'Avenue du Prado'),
(7, 18, 13300, 'Rue de la Paix'),
(8, 5, 13400, 'Cours Julien'),
(9, 22, 13400, 'Avenue Montaigne');

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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `comporter`
--

INSERT INTO `comporter` (`id`, `projet_id`, `etablissement_id`) VALUES
(1, 1, 1),
(2, 3, 2),
(3, 4, 3),
(4, 5, 4),
(5, 6, 5),
(6, 9, 6);

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personne_id` int NOT NULL,
  `fonction` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date_embauche` date NOT NULL,
  `date_fin` date DEFAULT NULL,
  `domaine` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`,`personne_id`),
  KEY `idx_personne_id_employe` (`personne_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `employe`
--

INSERT INTO `employe` (`id`, `personne_id`, `fonction`, `date_embauche`, `date_fin`, `domaine`) VALUES
(1, 2, 'Institutrice', '2024-01-30', NULL, 'Ecole Primaire'),
(2, 7, 'Bibliothécaire', '2024-01-30', NULL, 'Culture'),
(3, 3, 'Architecte Paysagist', '2021-09-01', '2023-05-13', 'Urbanisme'),
(4, 4, 'Responsable des Spor', '2022-02-10', NULL, 'Sports'),
(5, 8, 'Directeur Culturel', '2021-11-20', '2032-12-29', 'Culture'),
(7, 5, 'Gérant d\'une boulang', '2024-01-02', '2024-01-31', 'Commerce');

-- --------------------------------------------------------

--
-- Structure de la table `etablissement`
--

DROP TABLE IF EXISTS `etablissement`;
CREATE TABLE IF NOT EXISTS `etablissement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `superficie` int NOT NULL,
  `adresse_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_adresse_id_etablissement` (`adresse_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `etablissement`
--

INSERT INTO `etablissement` (`id`, `nom`, `description`, `superficie`, `adresse_id`) VALUES
(1, 'Ecole Primaire', 'Ecole accueillant de', 2100, 3),
(2, 'Bibliothèque Central', 'Bibliothèque municip', 1200, 1),
(3, 'Parc Municipal', 'Espace vert ouvert a', 5000, 4),
(4, 'Centre Sportif Munic', 'Installations sporti', 3000, 5),
(5, 'Espace Culturel Poly', 'Salle de spectacle e', 2000, 2),
(6, 'Boulangerie', 'Boulangerie Pâtisser', 1000, 9);

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `prenom` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `situation` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sexe` tinyint(1) NOT NULL,
  `ville_naissance` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date_naissance` date NOT NULL,
  `nationalite` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ville_naissance_personne` (`ville_naissance`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`id`, `nom`, `prenom`, `situation`, `sexe`, `ville_naissance`, `date_naissance`, `nationalite`) VALUES
(1, 'Murienne', 'Vincent', 'célibataire', 1, 'Paris 14', '2003-02-14', 'Française'),
(2, 'Ouakkouche', 'Hadil', 'célibataire', 0, 'Bejaia', '2001-08-29', 'Algérienne'),
(3, 'Dupont', 'Jean', 'marié', 1, 'Lyon', '1980-05-22', 'Française'),
(4, 'Martin', 'Sophie', 'mariée', 0, 'Marseille', '1995-10-10', 'Française'),
(6, 'Garcia', 'Carlos', 'célibataire', 1, 'Barcelone', '1990-04-25', 'Espagnole'),
(7, 'Delpeche', 'Antoine', 'célibataire', 1, 'Havre', '1982-08-12', 'Française'),
(8, 'Gonzalez', 'Riccardo', 'marié', 1, 'Braga', '1995-02-25', 'Portugal');

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

DROP TABLE IF EXISTS `projet`;
CREATE TABLE IF NOT EXISTS `projet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin_prevue` date NOT NULL,
  `montant_budget` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_nom_projet` (`nom`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `projet`
--

INSERT INTO `projet` (`id`, `nom`, `description`, `date_debut`, `date_fin_prevue`, `montant_budget`) VALUES
(1, 'Rénovation Gymnase', 'Rénovation du matéri', '2025-02-14', '2025-08-12', 110000),
(2, 'Rénovation Mairie', 'Rénovation de la toi', '2029-01-09', '2029-06-14', 100000),
(3, 'Extension Bibliothèq', 'Ajout de nouvelles s', '2022-06-01', '2026-01-01', 24000),
(4, 'Réaménagement Parc', 'Modernisation des ai', '2029-03-15', '2029-08-31', 12000),
(5, 'Réhabilitation Centr', 'Modernisation des pi', '2022-03-01', '2025-09-30', 28000),
(6, 'Création Espace Cult', 'Construction salle p', '2023-01-15', '2030-08-31', 34400),
(9, 'Rénovation de la Bou', 'Modernisation de la ', '2024-01-17', '2024-01-31', 8000);

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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `travailler`
--

INSERT INTO `travailler` (`id`, `employe_id`, `etablissement_id`) VALUES
(1, 1, 1),
(2, 4, 4),
(3, 2, 2),
(4, 5, 5),
(6, 7, 6);

--
-- Déclencheurs `travailler`
--
DROP TRIGGER IF EXISTS `ApresSuppressionEmploye`;
DELIMITER $$
CREATE TRIGGER `ApresSuppressionEmploye` AFTER DELETE ON `travailler` FOR EACH ROW BEGIN
  -- Appel de la procédure stockée pour mettre à jour la date de fin du projet
  CALL MiseAJourDateFinProjet(OLD.employe_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vueemployeetablissement`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vueemployeetablissement`;
CREATE TABLE IF NOT EXISTS `vueemployeetablissement` (
`travailler_id` int
,`nom` varchar(20)
,`prenom` varchar(20)
,`sexe` tinyint(1)
,`date_naissance` date
,`ville_naissance` varchar(20)
,`nationalite` varchar(20)
,`fonction` varchar(20)
,`date_embauche` date
,`date_fin` date
,`domaine` varchar(20)
,`etablissement_id` int
,`etablissement_nom` varchar(20)
,`etablissement_description` varchar(20)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vuepersonneadresse`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vuepersonneadresse`;
CREATE TABLE IF NOT EXISTS `vuepersonneadresse` (
`rattacher_id` int
,`nom` varchar(20)
,`prenom` varchar(20)
,`sexe` tinyint(1)
,`date_naissance` date
,`ville_naissance` varchar(20)
,`nationalite` varchar(20)
,`numero_rue` int
,`nom_rue` varchar(20)
,`code_postal` int
);

-- --------------------------------------------------------

--
-- Structure de la vue `vueemployeetablissement`
--
DROP TABLE IF EXISTS `vueemployeetablissement`;

DROP VIEW IF EXISTS `vueemployeetablissement`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vueemployeetablissement`  AS SELECT `t`.`id` AS `travailler_id`, `p`.`nom` AS `nom`, `p`.`prenom` AS `prenom`, `p`.`sexe` AS `sexe`, `p`.`date_naissance` AS `date_naissance`, `p`.`ville_naissance` AS `ville_naissance`, `p`.`nationalite` AS `nationalite`, `e`.`fonction` AS `fonction`, `e`.`date_embauche` AS `date_embauche`, `e`.`date_fin` AS `date_fin`, `e`.`domaine` AS `domaine`, `t`.`etablissement_id` AS `etablissement_id`, `et`.`nom` AS `etablissement_nom`, `et`.`description` AS `etablissement_description` FROM (((`travailler` `t` join `employe` `e` on((`t`.`employe_id` = `e`.`id`))) join `personne` `p` on((`e`.`personne_id` = `p`.`id`))) join `etablissement` `et` on((`t`.`etablissement_id` = `et`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `vuepersonneadresse`
--
DROP TABLE IF EXISTS `vuepersonneadresse`;

DROP VIEW IF EXISTS `vuepersonneadresse`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vuepersonneadresse`  AS SELECT DISTINCT `r`.`id` AS `rattacher_id`, `p`.`nom` AS `nom`, `p`.`prenom` AS `prenom`, `p`.`sexe` AS `sexe`, `p`.`date_naissance` AS `date_naissance`, `p`.`ville_naissance` AS `ville_naissance`, `p`.`nationalite` AS `nationalite`, `a`.`numero_rue` AS `numero_rue`, `a`.`nom_rue` AS `nom_rue`, `a`.`code_postal` AS `code_postal` FROM ((`rattacher` `r` join `personne` `p` on((`r`.`personne_id` = `p`.`id`))) join `adresse` `a` on((`r`.`adresse_id` = `a`.`id`))) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
