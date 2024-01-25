README - Mise en place de la Base de Données avec phpMyAdmin
Ce guide détaille les étapes pour mettre en place la base de données décrite dans le contexte d'une petite mairie en utilisant phpMyAdmin.

HVA DB Management, entreprise spécialisée dans la création / gestion de BDD pour particulier ou entreprise. 
Contexte : de plus en plus de mairie on besoin d'un SGBD pour mieux gérer leurs communes (finance, population, services -> Ecole / Librairie ...) 
surtout dans les petits villages de campagnes. Jérôme D maire du village 'Verratti' à besoin de nos services.

Prérequis
Un serveur web (par exemple, Apache) installé et configuré.
phpMyAdmin installé sur le serveur.

Étapes
Connexion à phpMyAdmin :

Ouvrez votre navigateur web et accédez à phpMyAdmin en entrant l'URL correspondante (ex: http://localhost/phpmyadmin).

Création de la base de données :

Cliquez sur l'onglet "Bases de données".
Saisissez un nom pour la nouvelle base de données (hva_db_management) dans le champ "Créer une base de données" et sélectionnez le jeu de caractères approprié (utf8mb4_bin).
Cliquez sur le bouton "Créer".

Importation des Tables :

Sélectionnez la base de données que vous venez de créer.
Cliquez sur l'onglet "Importation" dans la barre de navigation supérieure.
Choisissez le fichier SQL contenant les définitions de table (hva_db_management.sql).
Cliquez sur le bouton "Exécuter".

Vérification :
Accédez à l'onglet "Bases de données".
Cliquez sur le nom de la base de données (mairie_db).
Vérifiez que les tables, les vues, les index, la procédure et le trigger ont été créées avec succès.
