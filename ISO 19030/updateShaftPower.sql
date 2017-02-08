/* Calculate shaft power from torque and revolutions */

USE hull_performance;


delimiter //

CREATE PROCEDURE updateShaftPower(IMO INT)
BEGIN
	
	UPDATE tempRawISO SET Shaft_Power = Shaft_Torque * Shaft_Revolutions * (2 * PI() / 60);
    
END