function convertXLSX2CSV(imo, infile, sheet, firstRow, fileColID, fileColName, outfile, setsql)
%convertXLSX2CSV Summary of this function goes here
%   Detailed explanation goes here
    
    obj = cVessel();
    obj.IMO_Vessel_Number = imo;
    
    dateCols_c = {'DateTime_UTC', 'yyyy-mm-dd HH:MM:SS.000'};
    obj = loadXLSX(obj, infile, sheet, firstRow, fileColID, fileColName, ...
        '', setsql, dateCols_c);
    cols = {'DateTime_UTC' ...
      ,'Relative_Wind_Speed' ...
      ,'Relative_Wind_Direction' ...
      ,'Speed_Over_Ground' ...
      ,'Ship_Heading' ...
      ,'Shaft_Revolutions' ...
      ,'Static_Draught_Fore' ...
      ,'Static_Draught_Aft' ...
      ,'Water_Depth' ...
      ,'Rudder_Angle' ...
      ,'Seawater_Temperature' ...
      ,'Air_Temperature' ...
      ,'Air_Pressure' ...
      ,'Speed_Through_Water' ...
      ,'Delivered_Power' ...
      ,'Shaft_Power' ...
      ,'Brake_Power' ...
      ,'Shaft_Torque' ...
      ,'Mass_Consumed_Fuel_Oil' ...
      ,'Volume_Consumed_Fuel_Oil' ...
      ,'Temp_Fuel_Oil_At_Flow_Meter' ...
      ,'Displacement'};
    ifnullCols_c = strcat('ifnull(', cols);
    ifnullCols_c = strcat(ifnullCols_c, ', '''')');
    
    tab = 'RawData';
    where_sql = ['IMO_Vessel_Number = ', num2str(imo),' '...
        'AND Speed_Through_Water IS NOT NULL '];
    [~, ~, sel_sql] = obj.select(tab, ifnullCols_c, where_sql);
    [~, sel_sql] = obj.determinateSQL(sel_sql);
    
    union1_sql = 'UNION ALL SELECT * FROM (';
    outfile_ch = obj.encloseFilename(outfile);
    union2_sql = [') a ' ...
    'INTO OUTFILE ' outfile_ch '' ...
		' FIELDS TERMINATED BY '',''' ...
			' ESCAPED BY ''''' ...
				' ENCLOSED BY ''''' ...
					' LINES TERMINATED BY ''\n'''];
    union_sql = [union1_sql, sel_sql, union2_sql];
    
    colNamesEnclosed_c = obj.encloseCols(cols, '''');
    colNamesEnclosedSep_ch = obj.colSepList(colNamesEnclosed_c);
    [obj, write_sql] = obj.combineSQL('SELECT', colNamesEnclosedSep_ch, union_sql);
    [obj, write_sql] = obj.terminateSQL(write_sql);
    obj.execute(write_sql);
end