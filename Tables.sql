-- Création de la base de données
CREATE DATABASE transport_logistique

-- Création de la table entrepots
CREATE TABLE entrepots (
 id INT PRIMARY KEY AUTO_INCREMENT,
 nom_entrepot VARCHAR(140),
 adresse VARCHAR(200),
 ville VARCHAR(120),
 pays VARCHAR(120)
);

-- Création de la table expéditions avec attribution des clés étrangères
CREATE TABLE expeditions (
 id INT PRIMARY KEY AUTO_INCREMENT,
 date_expedition DATE,
 id_entrepot_source INT,
 id_entrepot_destination INT,
 poids DECIMAL,
 statut VARCHAR(40),
 FOREIGN KEY (id_entrepot_source) REFERENCES entrepots(id),
 FOREIGN KEY (id_entrepot_destination) REFERENCES entrepots(id)
);