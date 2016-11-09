/* Create Bunker Delivery Note Table for Vessels */

delimiter //

CREATE PROCEDURE createBunkerDeliveryNote()
BEGIN

CREATE TABLE BunkerDeliveryNote (id INT PRIMARY KEY AUTO_INCREMENT,
								IMO_Vessel_Number INT,
								BDN_Number VARCHAR(100),
								Bunker_Delivery_Date DATE,
								Fuel_Type VARCHAR(100),
								Mass DOUBLE(10, 3),
								Sulphur_Content DOUBLE(2, 1),
								Density_At_15dg DOUBLE(5, 4),
								Lower_Heating_Value DOUBLE(5, 3));
END