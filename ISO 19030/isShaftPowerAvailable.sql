/* Check if shaft power is available */

delimiter //

CREATE PROCEDURE isShaftPowerAvailable(imo INT, OUT isAvailable BOOLEAN)
BEGIN
	
    SET isAvailable = FALSE;
    
    /* Check if torque and rpm are both not all NULL */
    IF (SELECT COUNT(*) FROM tempRawISO WHERE Shaft_Torque IS NOT NULL AND Shaft_Revolutions IS NOT NULL) > 0 THEN
    
		SET isAvailable = TRUE;
        
    END IF;
    
END;