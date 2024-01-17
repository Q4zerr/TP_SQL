-- Ajoutez une table "clients" contenant les colonnes suivantes :
CREATE TABLE clients(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(120),
    adresse VARCHAR(200),
    ville VARCHAR(160),
    pays VARCHAR(80)
);

--  Ajoutez une table de jointure "expeditions_clients" contenant les colonnes suivantes :
CREATE TABLE expeditions_clients(
    id_expedition INT,
    id_client INT,
    FOREIGN KEY (id_expedition) REFERENCES expeditions(id),
    FOREIGN KEY (id_client) REFERENCES clients(id)
);

-- Modifiez la table "expeditions" pour y ajouter une colonne "id_client" (entier, clé étrangèrefaisant référence à la table "clients")
ALTER TABLE expeditions
ADD COLUMN id_client INT,
ADD FOREIGN KEY (id_client) REFERENCES clients(id);

-- Ajoutez des données aux tables "clients" et "expeditions_clients".
-- Clients
INSERT INTO clients(nom, adresse, ville, pays) VALUES ('Dupont', '21 rue des Lys', 'Lyon', 'France');
INSERT INTO clients(nom, adresse, ville, pays) VALUES ('Guang', 'rue du Général Ailleret', 'Pekin', 'Chine');
INSERT INTO clients(nom, adresse, ville, pays) VALUES ('Alfonsino', 'Via Valpantena, 15', 'Barcelone', 'Espagne');
INSERT INTO clients(nom, adresse, ville, pays) VALUES ('Costa', 'R Nuno Álvares 73', 'Lisbonne', 'Portugal');
INSERT INTO clients(nom, adresse, ville, pays) VALUES ('Galdino', 'Corso Porta Nuova, 21', 'Rome', 'Italie');
INSERT INTO clients(nom, adresse, ville, pays) VALUES ('Vernadeau', '49, rue du Faubourg National', 'Paris', 'France');

-- Expéditions Clients
INSERT INTO expeditions_clients(id_expedition, id_client) VALUES (1, 1);
INSERT INTO expeditions_clients(id_expedition, id_client) VALUES (4, 4);
INSERT INTO expeditions_clients(id_expedition, id_client) VALUES (2, 2);
INSERT INTO expeditions_clients(id_expedition, id_client) VALUES (6, 6);
INSERT INTO expeditions_clients(id_expedition, id_client) VALUES (3, 3);
INSERT INTO expeditions_clients(id_expedition, id_client) VALUES (5, 5);

-- Pour chaque client, affichez son nom, son adresse complète, le
-- nombre total d'expéditions qu'il a envoyées et le nombre total
-- d'expéditions qu'il a reçues
-- En premier lieu j'update tout mes id client pour les faires correspondrent avec les id expedition auquel je les ai attribué
UPDATE expeditions
SET id_client = 
    CASE 
        WHEN id IN (1) THEN 1
        WHEN id IN (2) THEN 2
        WHEN id IN (3) THEN 3
        WHEN id IN (4) THEN 4
        WHEN id IN (5) THEN 5
        WHEN id IN (6) THEN 6
        ELSE id_client
    END
WHERE id IN (1, 2, 3, 4, 5, 6);

SELECT
    c.nom AS Nom_Client,
    c.adresse AS Adresse_Client,
    COUNT(DISTINCT ec.id_expedition) AS Nombre_Expéditions_Envoyées,
    COUNT(DISTINCT e.id) AS Nombre_Expéditions_Reçues
FROM
    clients c
LEFT JOIN
    expeditions_clients ec ON c.id = ec.id_client
LEFT JOIN
    expeditions e ON c.id = e.id_client
GROUP BY
    c.id, c.nom, c.adresse;

-- Pour chaque expédition, affichez son ID, son poids, le nom du client
-- qui l'a envoyée, le nom du client qui l'a reçue et le statut
