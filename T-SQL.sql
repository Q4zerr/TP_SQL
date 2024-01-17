-- Créez une vue qui affiche les informations suivantes pour chaque entrepôt :
-- nom de l'entrepôt, adresse complète, nombre d'expéditions envoyées au
-- cours des 30 derniers jours
CREATE VIEW Vue_Entrepot_Informations AS
SELECT 
    e.nom_entrepot,
    CONCAT(e.adresse, ', ', e.ville, ', ', e.pays) AS adresse_complete,
    COUNT(exp.id) AS nombre_expeditions
FROM entrepots AS e
LEFT JOIN expeditions AS exp ON exp.id_entrepot_source = e.id
WHERE exp.date_expedition >= CURDATE() - INTERVAL 30 DAY
GROUP BY e.id, e.nom_entrepot, e.adresse, e.ville, e.pays;

SELECT * FROM Vue_Entrepot_Informations

-- Créez une procédure stockée qui prend en entrée l'ID d'un entrepôt et
-- renvoie le nombre total d'expéditions envoyées par cet entrepôt au cours du
-- dernier mois.
DELIMITER //
CREATE PROCEDURE GetTotalExpeditionsByEntrepot(
    IN entrepot_id INT
)
BEGIN
    DECLARE total_expeditions INT;
    DECLARE entrepot_nom VARCHAR(140);
    DECLARE entrepot_ville VARCHAR(120);
    DECLARE entrepot_pays VARCHAR(120);

    DECLARE last_month_start DATE;
    DECLARE last_month_end DATE;
    
    -- Calculer le début et la fin du mois dernier
    SET last_month_start = DATE_SUB(LAST_DAY(NOW() - INTERVAL 2 MONTH), INTERVAL DAY(LAST_DAY(NOW() - INTERVAL 2 MONTH)) - 1 DAY);
    SET last_month_end = LAST_DAY(NOW() - INTERVAL 1 MONTH);
    
    -- Sélectionner le nom, la ville et le pays de l'entrepôt
    SELECT nom_entrepot, ville, pays INTO entrepot_nom, entrepot_ville, entrepot_pays
    FROM entrepots
    WHERE id = entrepot_id;
    
    -- Sélectionner le nombre total d'expéditions pour l'entrepôt donné et le mois dernier
    SELECT COUNT(*) INTO total_expeditions
    FROM expeditions
    WHERE id_entrepot_source = entrepot_id
    AND date_expedition BETWEEN last_month_start AND last_month_end;
    
    -- Retourner le résultat
    SELECT entrepot_nom AS nomEntrepot, entrepot_ville AS villeEntrepot, entrepot_pays AS paysEntrepot, total_expeditions AS totalExpeditions;
END //
DELIMITER ;

CALL GetTotalExpeditionsByEntrepot(1)

-- Créez une fonction qui prend en entrée une date et renvoie le nombre total
-- d'expéditions livrées ce jour-là.
DELIMITER //
CREATE FUNCTION GetTotalDeliveredShipments(dateToCheck DATE)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalDelivered INT;
    
    -- Sélectionner le nombre total d'expéditions livrées pour la date donnée
    SELECT COUNT(*) INTO totalDelivered
    FROM expeditions
    WHERE date_expedition = dateToCheck
    AND statut = 'Livré';
    
    -- Retourner le nombre total d'expéditions livrées
    RETURN totalDelivered;
END //
DELIMITER ;

SELECT GetTotalDeliveredShipments('2023-11-02')
