/* Create tempRaw table, a temporary table used to insert data from DNVGLRaw to RawData */

DROP PROCEDURE IF EXISTS createTempRaw;

delimiter //

CREATE PROCEDURE createTempRaw(imo INT)

BEGIN

DROP TABLE IF EXISTS `dnvgl`.tempRaw;
/* CREATE TABLE tempRaw LIKE dnvglraw; */

CREATE TABLE `dnvgl`.tempRaw LIKE `dnvgl`.DNVGLRaw;

ALTER TABLE `dnvgl`.tempRaw ADD COLUMN Seawater_Temperature DOUBLE (20, 5), 
ADD COLUMN Displacement DOUBLE (20, 5), 
ADD COLUMN Air_Temperature DOUBLE (20, 5), 
ADD COLUMN Mass_Consumed_Fuel_Oil DOUBLE (20, 5), 
ADD COLUMN Air_Pressure DOUBLE (20, 5),
ADD COLUMN Relative_Wind_Speed DOUBLE (20, 5), 
ADD COLUMN Relative_Wind_Direction DOUBLE (20, 5),
ADD COLUMN Shaft_Revolutions DOUBLE (20, 5),
ADD COLUMN Static_Draught_Fore DOUBLE (20, 5),
ADD COLUMN Static_Draught_Aft DOUBLE (20, 5),
ADD COLUMN Lower_Caloirifc_Value_Fuel_Oil DOUBLE (20, 5),
ADD COLUMN Density_Fuel_Oil_15C DOUBLE (20, 5),
ADD COLUMN Speed_Over_Ground DOUBLE (20, 5)
;

/* Seawater_Temperature, Displacement, Air_Temperature, Mass_Consumed_Fuel_Oil, Air_Pressure, Relative_Wind_Speed, Relative_Wind_Direction, Speed_Over_Ground, Shaft_Revolutions, Static_Draught_Fore, Static_Draught_Aft, */

INSERT INTO `dnvgl`.tempRaw (IMO_Vessel_Number, DateTime_UTC, Date_UTC, Time_UTC, Date_Local, Time_Local, Reporting_Time, Voyage_From, Voyage_To, ETA, RTA, Reason_For_Schedule_Deviation, No_Of_Tugs, Voyage_Number, Voyage_Type, Service, System_Condition, Travel_Condition, Voyage_Stage, Voyage_Leg, Voyage_Leg_Type, Port_To_Port_Id, Area_From, Area_To, Position, Latitude_Degree, Latitude_Minutes, Latitude_North_South, Longitude_Degree, Longitude_Minutes, Longitude_East_West, Wind_Dir, Wind_Dir_Degree, Wind_Force_Kn, Wind_Force_Bft, Sea_state_Dir, Sea_state_Dir_Degree, Sea_state_Force_Douglas, Period_Of_Wind_Waves, Swell_Dir, Swell_Dir_Degree, Swell_Force, Period_Of_Primary_Swell_Waves, Current_Dir, Current_Dir_Degree, Current_Speed, Temperature_Ambient, Temperature_Water, Water_Depth, Draft_Actual_Fore, Draft_Actual_Aft, Draft_Recommended_Fore, Draft_Recommended_Aft, Draft_Ballast_Actual, Draft_Ballast_Optimum, Draft_Displacement_Actual, Event, Time_Since_Previous_Report, Time_Elapsed_Sailing, Time_Elapsed_Maneuvering, Time_Elapsed_Waiting, Time_Elapsed_Loading_Unloading, Distance, Distance_To_Go, Average_Speed_GPS, Average_Speed_Through_Water, Average_Propeller_Speed, Intended_Speed_Next_24Hrs, Nominal_Slip, Apparent_Slip, Cargo_Mt, Cargo_Total_TEU, Cargo_Total_Full_TEU, Cargo_Reefer_TEU, Reefer_20_Chilled, Reefer_40_Chilled, Reefer_20_Frozen, Reefer_40_Frozen, Cargo_CEU, Crew, Passengers, ME_Fuel_BDN, ME_Fuel_BDN_2, ME_Fuel_BDN_3, ME_Fuel_BDN_4, ME_Consumption, ME_Consumption_BDN_2, ME_Consumption_BDN_3, ME_Consumption_BDN_4, ME_Projected_Consumption, ME_Cylinder_Oil_Consumption, ME_System_Oil_Consumption, ME_1_Running_Hours, ME_1_Consumption, ME_1_Cylinder_Oil_Consumption, ME_1_System_Oil_Consumption, ME_1_Work, ME_1_Shaft_Gen_Work, ME_1_Shaft_Gen_Running_Hours, ME_2_Running_Hours, ME_2_Consumption, ME_2_Cylinder_Oil_Consumption, ME_2_System_Oil_Consumption, ME_2_Work, ME_2_Shaft_Gen_Work, ME_2_Shaft_Gen_Running_Hours, ME_3_Running_Hours, ME_3_Consumption, ME_3_Cylinder_Oil_Consumption, ME_3_System_Oil_Consumption, ME_3_Work, ME_3_Shaft_Gen_Work, ME_3_Shaft_Gen_Running_Hours, ME_4_Running_Hours, ME_4_Consumption, ME_4_Cylinder_Oil_Consumption, ME_4_System_Oil_Consumption, ME_4_Work, ME_4_Shaft_Gen_Work, ME_4_Shaft_Gen_Running_Hours, AE_Fuel_BDN, AE_Fuel_BDN_2, AE_Fuel_BDN_3, AE_Fuel_BDN_4, AE_Consumption, AE_Consumption_BDN_2, AE_Consumption_BDN_3, AE_Consumption_BDN_4, AE_Projected_Consumption, AE_System_Oil_Consumption, AE_1_Running_Hours, AE_1_Consumption, AE_1_System_Oil_Consumption, AE_1_Work, AE_2_Running_Hours, AE_2_Consumption, AE_2_System_Oil_Consumption, AE_2_Work, AE_3_Running_Hours, AE_3_Consumption, AE_3_System_Oil_Consumption, AE_3_Work, AE_4_Running_Hours, AE_4_Consumption, AE_4_System_Oil_Consumption, AE_4_Work, AE_5_Running_Hours, AE_5_Consumption, AE_5_System_Oil_Consumption, AE_5_Work, AE_6_Running_Hours, AE_6_Consumption, AE_6_System_Oil_Consumption, AE_6_Work, Boiler_Consumption, Boiler_Consumption_BDN_2, Boiler_Consumption_BDN_3, Boiler_Consumption_BDN_4, Boiler_1_Running_Hours, Boiler_1_Consumption, Boiler_2_Running_Hours, Boiler_2_Consumption, Air_Compr_1_Running_Time, Air_Compr_2_Running_Time, Thruster_1_Running_Time, Thruster_2_Running_Time, Thruster_3_Running_Time, Fresh_Water_Bunkered, Fresh_Water_Consumption_Drinking, Fresh_Water_Consumption_Technical, Fresh_Water_Consumption_Washing, Fresh_Water_Produced, Fresh_Water_ROB, Duration_Fresh_Water, Sludge_ROB, HFO_HS_ROB, HFO_LS_ROB, MDO_MGO_HS_ROB, MDO_MGO_LS_ROB, ME_Cylinder_Oil_ROB, ME_System_Oil_ROB, AE_System_Oil_ROB, Cleaning_Event, Mode, Speed_GPS, Speed_Through_Water, Speed_Projected_From_Charter_Party, Course, True_Heading, ME_Barometric_Pressure, ME_Charge_Air_Coolant_Inlet_Temp, ME_Air_Intake_Temp, ME_1_Load, ME_1_Speed_RPM, Prop_1_Pitch, ME_1_Aux_Blower, ME_1_Shaft_Gen_Power, ME_1_Charge_Air_Inlet_Temp, ME_1_Charge_Air_Pressure, ME_1_Pressure_Drop_Over_Charge_Air_Cooler, ME_1_TC_Speed, ME_1_Exh_Temp_Before_TC, ME_1_Exh_Temp_After_TC, ME_1_Current_Consumption, ME_1_SFOC_ISO_Corrected, ME_1_SFOC, ME_1_Pmax, ME_1_Pcomp, ME_2_Load, ME_2_Speed_RPM, Prop_2_Pitch, ME_2_Aux_Blower, ME_2_Shaft_Gen_Power, ME_2_Charge_Air_Inlet_Temp, ME_2_Charge_Air_Pressure, ME_2_Pressure_Drop_Over_Charge_Air_Cooler, ME_2_TC_Speed, ME_2_Exh_Temp_Before_TC, ME_2_Exh_Temp_After_TC, ME_2_Current_Consumption, ME_2_SFOC_ISO_Corrected, ME_2_SFOC, ME_2_Pmax, ME_2_Pcomp, ME_3_Load, ME_3_Speed_RPM, Prop_3_Pitch, ME_3_Aux_Blower, ME_3_Shaft_Gen_Power, ME_3_Charge_Air_Inlet_Temp, ME_3_Charge_Air_Pressure, ME_3_Pressure_Drop_Over_Charge_Air_Cooler, ME_3_TC_Speed, ME_3_Exh_Temp_Before_TC, ME_3_Exh_Temp_After_TC, ME_3_Current_Consumption, ME_3_SFOC, ME_3_SFOC_ISO_Corrected, ME_3_Pmax, ME_3_Pcomp, ME_4_Load, ME_4_Speed_RPM, Prop_4_Pitch, ME_4_Aux_Blower, ME_4_Shaft_Gen_Power, ME_4_Charge_Air_Inlet_Temp, ME_4_Charge_Air_Pressure, ME_4_Pressure_Drop_Over_Charge_Air_Cooler, ME_4_TC_Speed, ME_4_Exh_Temp_Before_TC, ME_4_Exh_Temp_After_TC, ME_4_Current_Consumption, ME_4_SFOC, ME_4_SFOC_ISO_Corrected, ME_4_Pmax, ME_4_Pcomp, AE_Barometric_Pressure, AE_Charge_Air_Coolant_Inlet_Temp, AE_Air_Intake_Temp, AE_1_Load, AE_1_Charge_Air_Inlet_Temp, AE_1_Charge_Air_Pressure, AE_1_Pressure_Drop_Over_Charge_Air_Cooler, AE_1_TC_Speed, AE_1_Exh_Temp_Before_TC, AE_1_Exh_Temp_After_TC, AE_1_Current_Consumption, AE_1_SFOC_ISO_Corrected, AE_1_SFOC, AE_1_Pmax, AE_1_Pcomp, AE_2_Load, AE_2_Charge_Air_Inlet_Temp, AE_2_Charge_Air_Pressure, AE_2_Pressure_Drop_Over_Charge_Air_Cooler, AE_2_TC_Speed, AE_2_Exh_Temp_Before_TC, AE_2_Exh_Temp_After_TC, AE_2_Current_Consumption, AE_2_SFOC_ISO_Corrected, AE_2_SFOC, AE_2_Pmax, AE_2_Pcomp, AE_3_Load, AE_3_Charge_Air_Inlet_Temp, AE_3_Charge_Air_Pressure, AE_3_Pressure_Drop_Over_Charge_Air_Cooler, AE_3_TC_Speed, AE_3_Exh_Temp_Before_TC, AE_3_Exh_Temp_After_TC, AE_3_Current_Consumption, AE_3_SFOC_ISO_Corrected, AE_3_SFOC, AE_3_Pmax, AE_3_Pcomp, AE_4_Load, AE_4_Charge_Air_Inlet_Temp, AE_4_Charge_Air_Pressure, AE_4_Pressure_Drop_Over_Charge_Air_Cooler, AE_4_TC_Speed, AE_4_Exh_Temp_Before_TC, AE_4_Exh_Temp_After_TC, AE_4_Current_Consumption, AE_4_SFOC_ISO_Corrected, AE_4_SFOC, AE_4_Pmax, AE_4_Pcomp, AE_5_Load, AE_5_Charge_Air_Inlet_Temp, AE_5_Charge_Air_Pressure, AE_5_Pressure_Drop_Over_Charge_Air_Cooler, AE_5_TC_Speed, AE_5_Exh_Temp_Before_TC, AE_5_Exh_Temp_After_TC, AE_5_Current_Consumption, AE_5_SFOC_ISO_Corrected, AE_5_SFOC, AE_5_Pmax, AE_5_Pcomp, AE_6_Load, AE_6_Charge_Air_Inlet_Temp, AE_6_Charge_Air_Pressure, AE_6_Pressure_Drop_Over_Charge_Air_Cooler, AE_6_TC_Speed, AE_6_Exh_Temp_Before_TC, AE_6_Exh_Temp_After_TC, AE_6_Current_Consumption, AE_6_SFOC_ISO_Corrected, AE_6_SFOC, AE_6_Pmax, AE_6_Pcomp, Boiler_1_Operation_Mode, Boiler_1_Feed_Water_Flow, Boiler_1_Steam_Pressure, Boiler_2_Operation_Mode, Boiler_2_Feed_Water_Flow, Boiler_2_Steam_Pressure, Cooling_Water_System_SW_Pumps_In_Service, Cooling_Water_System_SW_Inlet_Temp, Cooling_Water_System_SW_Outlet_Temp, Cooling_Water_System_Pressure_Drop_Over_Heat_Exchanger, Cooling_Water_System_Pump_Pressure, ER_Ventilation_Fans_In_Service, ER_Ventilation_Waste_Air_Temp, Remarks, Entry_Made_By_1, Entry_Made_By_2)
	(SELECT IMO_Vessel_Number, DateTime_UTC, Date_UTC, Time_UTC, Date_Local, Time_Local, Reporting_Time, Voyage_From, Voyage_To, ETA, RTA, Reason_For_Schedule_Deviation, No_Of_Tugs, Voyage_Number, Voyage_Type, Service, System_Condition, Travel_Condition, Voyage_Stage, Voyage_Leg, Voyage_Leg_Type, Port_To_Port_Id, Area_From, Area_To, Position, Latitude_Degree, Latitude_Minutes, Latitude_North_South, Longitude_Degree, Longitude_Minutes, Longitude_East_West, Wind_Dir, Wind_Dir_Degree, Wind_Force_Kn, Wind_Force_Bft, Sea_state_Dir, Sea_state_Dir_Degree, Sea_state_Force_Douglas, Period_Of_Wind_Waves, Swell_Dir, Swell_Dir_Degree, Swell_Force, Period_Of_Primary_Swell_Waves, Current_Dir, Current_Dir_Degree, Current_Speed, Temperature_Ambient, Temperature_Water, Water_Depth, Draft_Actual_Fore, Draft_Actual_Aft, Draft_Recommended_Fore, Draft_Recommended_Aft, Draft_Ballast_Actual, Draft_Ballast_Optimum, Draft_Displacement_Actual, Event, Time_Since_Previous_Report, Time_Elapsed_Sailing, Time_Elapsed_Maneuvering, Time_Elapsed_Waiting, Time_Elapsed_Loading_Unloading, Distance, Distance_To_Go, Average_Speed_GPS, Average_Speed_Through_Water, Average_Propeller_Speed, Intended_Speed_Next_24Hrs, Nominal_Slip, Apparent_Slip, Cargo_Mt, Cargo_Total_TEU, Cargo_Total_Full_TEU, Cargo_Reefer_TEU, Reefer_20_Chilled, Reefer_40_Chilled, Reefer_20_Frozen, Reefer_40_Frozen, Cargo_CEU, Crew, Passengers, ME_Fuel_BDN, ME_Fuel_BDN_2, ME_Fuel_BDN_3, ME_Fuel_BDN_4, ME_Consumption, ME_Consumption_BDN_2, ME_Consumption_BDN_3, ME_Consumption_BDN_4, ME_Projected_Consumption, ME_Cylinder_Oil_Consumption, ME_System_Oil_Consumption, ME_1_Running_Hours, ME_1_Consumption, ME_1_Cylinder_Oil_Consumption, ME_1_System_Oil_Consumption, ME_1_Work, ME_1_Shaft_Gen_Work, ME_1_Shaft_Gen_Running_Hours, ME_2_Running_Hours, ME_2_Consumption, ME_2_Cylinder_Oil_Consumption, ME_2_System_Oil_Consumption, ME_2_Work, ME_2_Shaft_Gen_Work, ME_2_Shaft_Gen_Running_Hours, ME_3_Running_Hours, ME_3_Consumption, ME_3_Cylinder_Oil_Consumption, ME_3_System_Oil_Consumption, ME_3_Work, ME_3_Shaft_Gen_Work, ME_3_Shaft_Gen_Running_Hours, ME_4_Running_Hours, ME_4_Consumption, ME_4_Cylinder_Oil_Consumption, ME_4_System_Oil_Consumption, ME_4_Work, ME_4_Shaft_Gen_Work, ME_4_Shaft_Gen_Running_Hours, AE_Fuel_BDN, AE_Fuel_BDN_2, AE_Fuel_BDN_3, AE_Fuel_BDN_4, AE_Consumption, AE_Consumption_BDN_2, AE_Consumption_BDN_3, AE_Consumption_BDN_4, AE_Projected_Consumption, AE_System_Oil_Consumption, AE_1_Running_Hours, AE_1_Consumption, AE_1_System_Oil_Consumption, AE_1_Work, AE_2_Running_Hours, AE_2_Consumption, AE_2_System_Oil_Consumption, AE_2_Work, AE_3_Running_Hours, AE_3_Consumption, AE_3_System_Oil_Consumption, AE_3_Work, AE_4_Running_Hours, AE_4_Consumption, AE_4_System_Oil_Consumption, AE_4_Work, AE_5_Running_Hours, AE_5_Consumption, AE_5_System_Oil_Consumption, AE_5_Work, AE_6_Running_Hours, AE_6_Consumption, AE_6_System_Oil_Consumption, AE_6_Work, Boiler_Consumption, Boiler_Consumption_BDN_2, Boiler_Consumption_BDN_3, Boiler_Consumption_BDN_4, Boiler_1_Running_Hours, Boiler_1_Consumption, Boiler_2_Running_Hours, Boiler_2_Consumption, Air_Compr_1_Running_Time, Air_Compr_2_Running_Time, Thruster_1_Running_Time, Thruster_2_Running_Time, Thruster_3_Running_Time, Fresh_Water_Bunkered, Fresh_Water_Consumption_Drinking, Fresh_Water_Consumption_Technical, Fresh_Water_Consumption_Washing, Fresh_Water_Produced, Fresh_Water_ROB, Duration_Fresh_Water, Sludge_ROB, HFO_HS_ROB, HFO_LS_ROB, MDO_MGO_HS_ROB, MDO_MGO_LS_ROB, ME_Cylinder_Oil_ROB, ME_System_Oil_ROB, AE_System_Oil_ROB, Cleaning_Event, Mode, Speed_GPS, Speed_Through_Water, Speed_Projected_From_Charter_Party, Course, True_Heading, ME_Barometric_Pressure, ME_Charge_Air_Coolant_Inlet_Temp, ME_Air_Intake_Temp, ME_1_Load, ME_1_Speed_RPM, Prop_1_Pitch, ME_1_Aux_Blower, ME_1_Shaft_Gen_Power, ME_1_Charge_Air_Inlet_Temp, ME_1_Charge_Air_Pressure, ME_1_Pressure_Drop_Over_Charge_Air_Cooler, ME_1_TC_Speed, ME_1_Exh_Temp_Before_TC, ME_1_Exh_Temp_After_TC, ME_1_Current_Consumption, ME_1_SFOC_ISO_Corrected, ME_1_SFOC, ME_1_Pmax, ME_1_Pcomp, ME_2_Load, ME_2_Speed_RPM, Prop_2_Pitch, ME_2_Aux_Blower, ME_2_Shaft_Gen_Power, ME_2_Charge_Air_Inlet_Temp, ME_2_Charge_Air_Pressure, ME_2_Pressure_Drop_Over_Charge_Air_Cooler, ME_2_TC_Speed, ME_2_Exh_Temp_Before_TC, ME_2_Exh_Temp_After_TC, ME_2_Current_Consumption, ME_2_SFOC_ISO_Corrected, ME_2_SFOC, ME_2_Pmax, ME_2_Pcomp, ME_3_Load, ME_3_Speed_RPM, Prop_3_Pitch, ME_3_Aux_Blower, ME_3_Shaft_Gen_Power, ME_3_Charge_Air_Inlet_Temp, ME_3_Charge_Air_Pressure, ME_3_Pressure_Drop_Over_Charge_Air_Cooler, ME_3_TC_Speed, ME_3_Exh_Temp_Before_TC, ME_3_Exh_Temp_After_TC, ME_3_Current_Consumption, ME_3_SFOC, ME_3_SFOC_ISO_Corrected, ME_3_Pmax, ME_3_Pcomp, ME_4_Load, ME_4_Speed_RPM, Prop_4_Pitch, ME_4_Aux_Blower, ME_4_Shaft_Gen_Power, ME_4_Charge_Air_Inlet_Temp, ME_4_Charge_Air_Pressure, ME_4_Pressure_Drop_Over_Charge_Air_Cooler, ME_4_TC_Speed, ME_4_Exh_Temp_Before_TC, ME_4_Exh_Temp_After_TC, ME_4_Current_Consumption, ME_4_SFOC, ME_4_SFOC_ISO_Corrected, ME_4_Pmax, ME_4_Pcomp, AE_Barometric_Pressure, AE_Charge_Air_Coolant_Inlet_Temp, AE_Air_Intake_Temp, AE_1_Load, AE_1_Charge_Air_Inlet_Temp, AE_1_Charge_Air_Pressure, AE_1_Pressure_Drop_Over_Charge_Air_Cooler, AE_1_TC_Speed, AE_1_Exh_Temp_Before_TC, AE_1_Exh_Temp_After_TC, AE_1_Current_Consumption, AE_1_SFOC_ISO_Corrected, AE_1_SFOC, AE_1_Pmax, AE_1_Pcomp, AE_2_Load, AE_2_Charge_Air_Inlet_Temp, AE_2_Charge_Air_Pressure, AE_2_Pressure_Drop_Over_Charge_Air_Cooler, AE_2_TC_Speed, AE_2_Exh_Temp_Before_TC, AE_2_Exh_Temp_After_TC, AE_2_Current_Consumption, AE_2_SFOC_ISO_Corrected, AE_2_SFOC, AE_2_Pmax, AE_2_Pcomp, AE_3_Load, AE_3_Charge_Air_Inlet_Temp, AE_3_Charge_Air_Pressure, AE_3_Pressure_Drop_Over_Charge_Air_Cooler, AE_3_TC_Speed, AE_3_Exh_Temp_Before_TC, AE_3_Exh_Temp_After_TC, AE_3_Current_Consumption, AE_3_SFOC_ISO_Corrected, AE_3_SFOC, AE_3_Pmax, AE_3_Pcomp, AE_4_Load, AE_4_Charge_Air_Inlet_Temp, AE_4_Charge_Air_Pressure, AE_4_Pressure_Drop_Over_Charge_Air_Cooler, AE_4_TC_Speed, AE_4_Exh_Temp_Before_TC, AE_4_Exh_Temp_After_TC, AE_4_Current_Consumption, AE_4_SFOC_ISO_Corrected, AE_4_SFOC, AE_4_Pmax, AE_4_Pcomp, AE_5_Load, AE_5_Charge_Air_Inlet_Temp, AE_5_Charge_Air_Pressure, AE_5_Pressure_Drop_Over_Charge_Air_Cooler, AE_5_TC_Speed, AE_5_Exh_Temp_Before_TC, AE_5_Exh_Temp_After_TC, AE_5_Current_Consumption, AE_5_SFOC_ISO_Corrected, AE_5_SFOC, AE_5_Pmax, AE_5_Pcomp, AE_6_Load, AE_6_Charge_Air_Inlet_Temp, AE_6_Charge_Air_Pressure, AE_6_Pressure_Drop_Over_Charge_Air_Cooler, AE_6_TC_Speed, AE_6_Exh_Temp_Before_TC, AE_6_Exh_Temp_After_TC, AE_6_Current_Consumption, AE_6_SFOC_ISO_Corrected, AE_6_SFOC, AE_6_Pmax, AE_6_Pcomp, Boiler_1_Operation_Mode, Boiler_1_Feed_Water_Flow, Boiler_1_Steam_Pressure, Boiler_2_Operation_Mode, Boiler_2_Feed_Water_Flow, Boiler_2_Steam_Pressure, Cooling_Water_System_SW_Pumps_In_Service, Cooling_Water_System_SW_Inlet_Temp, Cooling_Water_System_SW_Outlet_Temp, Cooling_Water_System_Pressure_Drop_Over_Heat_Exchanger, Cooling_Water_System_Pump_Pressure, ER_Ventilation_Fans_In_Service, ER_Ventilation_Waste_Air_Temp, Remarks, Entry_Made_By_1, Entry_Made_By_2
		FROM dnvglraw WHERE IMO_Vessel_Number = imo);

CALL convertDNVGLRawToRawData;

END;