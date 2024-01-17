--Affichez les entrepôts qui ont envoyé au moins une expédition en transit
SELECT e.id, e.nom_entrepot
FROM entrepots e
WHERE EXISTS (
  SELECT 1
  FROM expeditions ex
  WHERE ex.id_entrepot_source = e.id
  AND ex.statut = 'En transit'  
);

--Affichez les entrepôts qui ont reçu au moins une expédition en transit
SELECT e.id, e.nom_entrepot
FROM entrepots e
WHERE EXISTS (
  SELECT 1
  FROM expeditions ex
  WHERE ex.id_entrepot_destination = e.id
  AND ex.statut = 'En transit'  
);

-- Affichez les expéditions qui ont un poids supérieur à 100 kg et qui sont en transit.
SELECT *
FROM expeditions
WHERE poids > 100 AND statut = 'En transit';

-- Affichez le nombre d'expéditions envoyées par chaque entrepôt.
SELECT e.id AS id_entrepot, e.nom_entrepot, COUNT(ex.id) AS nombre_expeditions_envoyees
FROM entrepots e
LEFT JOIN expeditions ex ON e.id = ex.id_entrepot_source
GROUP BY e.id, e.nom_entrepot;

-- Affichez le nombre total d'expéditions en transit.
SELECT COUNT(statut)
FROM expeditions
WHERE statut = 'En transit';

-- Affichez le nombre total d'expéditions livrées.
SELECT COUNT(statut)
FROM expeditions
WHERE statut = 'Livré';

-- Affichez le nombre total d'expéditions pour chaque mois de l'année en cours
SELECT MONTH(date_expedition) AS mois, COUNT(*) AS nombre_expéditions
FROM expeditions
WHERE YEAR(date_expedition) = YEAR(CURDATE())
GROUP BY mois
ORDER BY mois;

-- Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours.
SELECT e.nom_entrepot, exp.date_expedition
FROM entrepots e
INNER JOIN expeditions exp
ON e.id = exp.id_entrepot_source
WHERE exp.date_expedition BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE();

-- Affichez les entrepôts qui ont reçu des expéditions au cours des 30 derniers jours.
SELECT e.nom_entrepot, exp.date_expedition
FROM entrepots e
INNER JOIN expeditions exp
ON e.id = exp.id_entrepot_destination
WHERE exp.date_expedition BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE();

-- Affichez les expéditions qui ont été livrées dans un délai de moins de 5 jours ouvrables.
SELECT *
FROM expeditions
WHERE statut = 'Livré'
AND DATEDIFF(NOW(), date_expedition) <= 5;