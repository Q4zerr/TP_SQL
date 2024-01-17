-- Affichez les expéditions en transit qui ont été initiées par un entrepôt situé en Europe et à destination d'un entrepôt situé en Asie.
SELECT *
FROM expeditions AS e
INNER JOIN entrepots AS source_entrepot
    ON e.id_entrepot_source = source_entrepot.id
INNER JOIN entrepots AS destination_entrepot
    ON e.id_entrepot_destination = destination_entrepot.id
WHERE e.statut = 'En transit'
AND (source_entrepot.ville = 'Lyon' AND source_entrepot.pays = 'France')
AND (destination_entrepot.ville = 'Pekin' AND destination_entrepot.pays = 'Chine');

-- Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans le même pays.
SELECT DISTINCT source_entrepot.id,
                source_entrepot.nom_entrepot,
                source_entrepot.ville,
                source_entrepot.pays
FROM expeditions AS e
INNER JOIN entrepots AS source_entrepot ON e.id_entrepot_source = source_entrepot.id
INNER JOIN entrepots AS destination_entrepot ON e.id_entrepot_destination = destination_entrepot.id
WHERE source_entrepot.pays = destination_entrepot.pays;

-- Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans un pays différent
SELECT DISTINCT source_entrepot.id,
                source_entrepot.nom_entrepot,
                source_entrepot.ville,
                source_entrepot.pays
FROM expeditions AS e
INNER JOIN entrepots AS source_entrepot ON e.id_entrepot_source = source_entrepot.id
INNER JOIN entrepots AS destination_entrepot ON e.id_entrepot_destination = destination_entrepot.id
WHERE source_entrepot.pays <> destination_entrepot.pays;

--  Affichez les expéditions en transit qui ont été initiées par un entrepôt situé dans un pays dont le nom commence par la lettre "F" et qui pèsent plus de 500 kg.
-- Ici je fais dabord un update de ma ligne car la seul expedition avec un pays commencant par un F n'avais pas un poids supérieur à 500
UPDATE expeditions
SET poids = '550'
WHERE id = 11
AND id_entrepot_source = 1
AND id_entrepot_destination = 6;

SELECT e.id AS id_entrepot_source, e.nom_entrepot AS entrepot_source, e.pays AS pays_source,
       ex.id AS id_expedition, ex.date_expedition, ex.statut, ex.poids,
       ed.id AS id_entrepot_destination, ed.nom_entrepot AS entrepot_destination, ed.pays AS pays_destination
FROM expeditions ex
JOIN entrepots e ON ex.id_entrepot_source = e.id
JOIN entrepots ed ON ex.id_entrepot_destination = ed.id
WHERE ex.statut = 'En transit'
AND e.pays LIKE 'F%'
AND ex.poids > 500;

-- Affichez le nombre total d'expéditions pour chaque combinaison de pays d'origine et de destination.
SELECT 
    e1.pays AS pays_origine, 
    e1.ville AS ville_origine,
    e2.pays AS pays_destination, 
    e2.ville AS ville_destination,
    COUNT(*) AS nombre_expeditions
FROM expeditions AS exp
INNER JOIN entrepots AS e1 
    ON exp.id_entrepot_source = e1.id
INNER JOIN entrepots AS e2 
    ON exp.id_entrepot_destination = e2.id
WHERE e1.pays = e2.pays
GROUP BY e1.pays, e1.ville,e2.pays, e2.ville;

-- Affichez les entrepôts qui ont envoyé des expéditions au cours des 30
-- derniers jours et dont le poids total des expéditions est supérieur à 1000 kg.
-- Ici j'update en premier lieu ma ligne pour avoir un retour à ma requête car aucune données n'allait etre retourné
UPDATE expeditions
SET poids = '1300'
WHERE id = 1 AND date_expedition = '2023-11-02';

SELECT 
    e.id AS id_entrepot,
    e.nom_entrepot,
    e.ville,
    e.pays,
    SUM(exp.poids) AS poids_total
FROM entrepots AS e
INNER JOIN expeditions AS exp
    ON exp.id_entrepot_source = e.id
WHERE exp.date_expedition >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY e.id, e.nom_entrepot,e.ville,e.pays
HAVING poids_total > 1000;

--  Affichez les expéditions qui ont été livrées avec un retard de plus de 2 jours ouvrables.
SELECT *
FROM expeditions
WHERE statut = 'Livré'
AND DATEDIFF(NOW(), date_expedition) > 2;

-- Affichez le nombre total d'expéditions pour chaque jour du mois en cours, trié par ordre décroissant
SELECT 
    DAY(exp.date_expedition) AS jour,
    COUNT(*) AS nombre_expeditions
FROM expeditions AS exp
WHERE MONTH(exp.date_expedition) = MONTH(CURDATE()) 
AND YEAR(exp.date_expedition) = YEAR(CURDATE())
GROUP BY DAY(exp.date_expedition)
ORDER BY nombre_expeditions DESC;
