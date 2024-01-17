-- Insertion jeu de données entrepots
INSERT INTO entrepots(nom_entrepot, adresse, ville, pays) VALUES ('Entrepot1', 'Adresse entrepot1', 'Lyon', 'France');

INSERT INTO entrepots(nom_entrepot, adresse, ville, pays) VALUES ('Entrepot2', 'Adresse entrepot2', 'Pekin', 'Chine');

INSERT INTO entrepots(nom_entrepot, adresse, ville, pays) VALUES ('Entrepot3', 'Adresse entrepot3', 'Barcelone', 'Espagne');

INSERT INTO entrepots(nom_entrepot, adresse, ville, pays) VALUES ('Entrepot4', 'Adresse entrepot4', 'Lisbonne', 'Portugal');

INSERT INTO entrepots(nom_entrepot, adresse, ville, pays) VALUES ('Entrepot5', 'Adresse entrepot5', 'Rome', 'Italie');

INSERT INTO entrepots(nom_entrepot, adresse, ville, pays) VALUES('Entrepot6', 'Adresse entrepot6', 'Paris', 'France');
-- Insertion jeu de données entrepots

-- Insertion jeu de données expéditions
INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2023-11-02', 1, 1, 64, 'En transit');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2023-10-16', 2, 2, 102, 'Livré');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2023-12-21', 3, 3, 118, 'En transit');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2023-09-12', 4, 4, 32, 'Livré');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2023-11-01', 5, 5, 74, 'En transit');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2023-10-13', 1, 1, 91, 'Livré');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2024-01-10', 2, 2, 13, 'En transit');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2022-02-18', 3, 3, 273, 'Livré');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2023-10-08', 4, 4, 548, 'En transit');

INSERT INTO expeditions(date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut) VALUES ('2023-09-22', 5, 5, 195, 'Livré');
-- Insertion jeu de données expéditions