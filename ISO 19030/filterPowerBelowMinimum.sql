/* Create filter for values below the lowest value of power in the appropriate speed-power curve */

DROP PROCEDURE IF EXISTS filterPowerBelowMinimum;

delimiter //

CREATE PROCEDURE filterPowerBelowMinimum(imo INT)

BEGIN
	
    /* Get nearest displacements and trim FilterSPDispTrim*/
	/* UPDATE tempRawISO t
		JOIN SpeedPower p
		ON t.IMO_Vessel_Number = p.IMO_Vessel_Number AND
			t.NearestTrim = p.Trim AND
            t.NearestDisplacement = p.Displacement
		SET t.FilterSPBelow = t.Delivered_Power < MIN(p.Power)
        ; */
    
	/* Get the minimum power of the power curve corresponding to delivered power, then whether DeliveredPower is less than this value. */
	UPDATE tempRawISO y JOIN
		(SELECT q.id, q.BelowMin, q.Delivered_Power FROM
			(SELECT r.id, r.Delivered_Power, p.Power, r.Delivered_Power < p.Power AS 'BelowMin' FROM tempRawISO r
				JOIN SpeedPower p
					ON
					r.IMO_Vessel_Number = p.IMO_Vessel_Number AND
					r.NearestTrim = p.Trim AND
					r.NearestDisplacement = p.Displacement) AS q
		INNER JOIN
			(SELECT id, Delivered_Power, Power, MIN(Power) AS MinPower
			FROM
				(SELECT t.id, t.Delivered_Power, p.Power, t.Delivered_Power < p.Power AS 'BelowMin' FROM tempRawISO t
					JOIN SpeedPower p
						ON
						t.IMO_Vessel_Number = p.IMO_Vessel_Number AND
						t.NearestTrim = p.Trim AND
						t.NearestDisplacement = p.Displacement) AS w
			GROUP BY id) AS e
		ON
			q.id = e.id AND
			q.Power = e.Power
			GROUP BY q.id) u
	ON y.id = u.id
	SET y.FilterSPBelow = u.BelowMin
		;
END