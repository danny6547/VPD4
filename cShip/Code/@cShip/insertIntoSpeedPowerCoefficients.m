function [obj, varargout ] = insertIntoSpeedPowerCoefficients(obj, speed, power, displacement, trim)
%insertIntoSpeedPowerCoefficients Insert data into database table
%   Detailed explanation goes here

% Outputs
varargout{1} = [];
varargout{2} = [];

% Inputs
validateattributes(speed, {'numeric'}, {'positive', 'real', 'nonnan', 'vector'}, ...
    'insertIntoSpeedPowerCoefficients', 'speed', 1);
validateattributes(power, {'numeric'}, {'positive', 'real', 'nonnan', 'vector'}, ...
    'insertIntoSpeedPowerCoefficients', 'power', 2);
validateattributes(displacement, {'numeric'}, {'positive', 'real', 'nonnan', 'vector'}, ...
    'insertIntoSpeedPowerCoefficients', 'displacement', 3);
validateattributes(trim, {'numeric'}, {'real', 'nonnan', 'vector'}, ...
    'insertIntoSpeedPowerCoefficients', 'displacement', 4);
% validateattributes(IMO, {'numeric'}, {'positive', 'real', 'nonnan', 'integer'}, ...
%     'insertIntoSpeedPowerCoefficients', 'IMO', 5);
speed = speed(:);
power = power(:);
displacement = displacement(:);
trim = trim(:);
IMO = [obj.IMO_Vessel_Number];
numObj = numel(obj);

% Repeat any scalar inputs
inputs_c = {speed, power, displacement, trim};
[speed, power, displacement, trim] = obj.repeatInputs(inputs_c);

% Get unique pairs of displacement, trim
numUniDispTrim = size(unique([displacement, trim], 'rows'), 1);

if ~isscalar(obj) && numUniDispTrim > 1
    
    errid = 'cShip:insertMultiple';
    errmsg = ['If speed, power data is to be assigned to multiple ships,'...
        'only one speed, power curve can be assigned, ie. displacement '...
        'and trim must each have one value.'];
    error(errid, errmsg);
end

if numObj > 1 && numUniDispTrim == 1
    
    IMO = repmat(IMO, [size(displacement), 1]);
    displacement = repmat(displacement, [numObj, 1]);
    trim = repmat(trim, [numObj, 1]);
    speed = repmat(speed, [numObj, 1]);
    power = repmat(power, [numObj, 1]);
    
    IMO = IMO(:);
end

uniImoDispTrim = unique([IMO, displacement, trim], 'rows');
numUniCoordinates = size(uniImoDispTrim, 1);

% Expand outputs to match number of speed, power curves
coeffs = nan(numUniCoordinates, 2);
R2 = nan(numUniCoordinates, 1);

% Iterate unique pairs of displacement, trim
for ii = 1:numUniCoordinates
    
    % Fit data to exponential
    currDisp = uniImoDispTrim(ii, 2);
    currTrim = uniImoDispTrim(ii, 3);
    currDisp_l = displacement == currDisp;
    currTrim_l = trim == currTrim;
    currCoord_l = currDisp_l & currTrim_l;
    
    currSpeed = speed(currCoord_l);
    currPower = power(currCoord_l);
    
    fo = polyfit(log(currPower), currSpeed, 1);
    
    % Get statistics of fit
    residuals = currSpeed - (fo(2) + fo(1).*log(currPower));
    r2 = 1 - (sum(residuals.^2) / sum((currSpeed - mean(currSpeed)).^2));
    
    % Assign into outputs
    coeffs(ii, :) = fo;
    R2(ii) = r2;
end

if isscalar(obj)
    
    obj.SpeedPowerCoefficients = coeffs;
    obj.SpeedPowerRSquared = R2;
else
    
    coeffs_c = arrayfun(@(x) coeffs(x, :), 1:numUniCoordinates, 'Uni', 0);
    R2_c = arrayfun(@(x) R2(x, :), 1:numUniCoordinates, 'Uni', 0);
    [obj.SpeedPowerCoefficients] = coeffs_c{:};
    [obj.SpeedPowerRSquared] = R2_c{:};
end

varargout{1} = coeffs;
varargout{2} = R2;
varargout{3} = speed;
varargout{4} = power;
varargout{5} = displacement;
varargout{6} = trim;

% Remove records found in database
% Server = 'localhost';
% Database = 'test2';
% Uid = 'root';
% Pwd = 'HullPerf2016';
% conn_ch = ['driver=MySQL ODBC 5.3 ANSI Driver;', ...
%             'Server=' Server ';',  ...
%             'Database=', Database, ';',  ...
%             'Uid=' Uid ';',  ...
%             'Pwd=' Pwd ';'];
% conn = adodb_connect(conn_ch);

% Insert into database
% dropTable_s = 'DROP TABLE IF EXISTS tempSPC';
% adodb_query(conn, dropTable_s);
% createTemp_s = 'CREATE TABLE tempSPC LIKE speedPowerCoefficients';
% adodb_query(conn, createTemp_s);
% insertTemp_s = ['INSERT INTO tempSPC (IMO_Vessel_Number,Displacement,Trim,'...
%     'Exponent_A,Exponent_B,R_Squared) VALUES '];

% IMO_c = cellstr(num2str(IMO));
% speed_c = cellstr(num2str(speed));
% power_c = cellstr(num2str(power));
% displacement_c = cellstr(num2str(displacement));
% trim_c = cellstr(num2str(trim));

% insertValues_s = sprintf('(%u, %f, %f, %f, %f, %f),\n', ...
%     [uniImoDispTrim(:, 1), uniImoDispTrim(:, 2), uniImoDispTrim(:, 3), fo, R2]');
% insertValues_s(end-1:end) = [];
% insertValues_c = cellstr(all_s);
% insertValues_c = strcat('(', IMO_c, speed_c, power_c, displacement_c, trim_c, ')');
% insertValues_s = strjoin(insertValues_c, ', ');

% insertTempCommand_s = [insertTemp_s, insertValues_s];
% adodb_query(conn, insertTempCommand_s);

% Generate table of data for insertion
data = [uniImoDispTrim, coeffs, R2];
toTable = 'speedPowerCoefficients';
key = 'id';
uniqueColumns = {'IMO_Vessel_Number', 'Displacement', 'Trim'};
otherColumns = {'Exponent_A', 'Exponent_B', 'R_Squared'};
format_s = '%u, %f, %f, %f, %f, %f';
insertWithoutDuplicates(data, toTable, key, uniqueColumns, otherColumns, format_s);