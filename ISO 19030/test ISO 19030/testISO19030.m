classdef testISO19030 < matlab.unittest.TestCase
%testISO19030 Test suite for the ISO 19030 Database methods
%   testISO19030 contains a suite of tests for the stored procedures of a
%   given database. These tests will execute the procedures on table
%   "tempRawISO" tables in the database and compare the result data
%   retrieved from it with expected results found in MATLAB. Therefore it
%   relies on data in other tables and other procedures on which these 
%   procedures depends to be accessible.

properties
    
    Connection = [];
    TableName = 'tempRawISO';
    
end

properties(Hidden)
    
    Server = 'localhost';
    Database = 'test2';
    Uid = 'root';
    Pwd = 'HullPerf2016';
    
end

properties(Constant, Hidden)
   
    DateTimeFormSQL = 'yyyy-mm-dd HH:MM:SS';
    DateTimeFormAdodb = 'dd-mm-yyyy HH:MM:SS';
    
end

methods(TestClassSetup)
    
    function establishConnection(obj)
    % establishConnection Create connection to database if none exists
        
        if isempty(obj.Connection)
            
            conn_ch = ['driver=MySQL ODBC 5.3 ANSI Driver;', ...
                        'Server=' obj.Server ';',  ...
                        'Database=', obj.Database, ';',  ...
                        'Uid=' obj.Uid ';',  ...
                        'Pwd=' obj.Pwd ';'];
            obj.Connection = adodb_connect(conn_ch);
            
        end
    end
    
    function createTable(testcase)
    % createTable Creates test table in database if none exists
    
    testcase.establishConnection;
    invalidIMO = [1:6, 8];
    invalidIMO = sprintf('%u', invalidIMO);
    call(testcase, 'createTempRawISO', invalidIMO);
    
%     sql_s = ['CREATE TABLE ' testcase.TableName ...
%             ' (id INT PRIMARY KEY AUTO_INCREMENT,'...
%             ' a DATETIME, '...
%             ' b DOUBLE(10, 5));'];
% 	adodb_query(testcase.Connection, sql_s);
    
    end
    
end

methods(TestClassTeardown)
    
    function closeConnection(obj)
    % closeConnection Close connection to database if it exists
        
        if ~isempty(obj.Connection)
            
            obj.dropTable;
            
            obj.Connection.release;
            obj.Connection = [];
            
        end
    end
    
    function dropTable(obj)
    % dropTable Drops test table in database if none exists
    
    if ~isempty(obj.Connection)
    
    sql_s = ['DROP TABLE IF EXISTS ' obj.TableName ';'];
	adodb_query(obj.Connection, sql_s);
    
    end
    
    end
    
end

methods(Test)

    function testsortOnDateTime(testcase)
    % Test table has been sorted ascending by column named DateTime
    % 1: Test that data returned by database reading function matches that
    % returned by the SORT function, with the second output used to index
    % the non-DateTime data.
    
    % Inputs
    date = now+1:-1:now-1;
    x = (3:-1:1)';
    
    date_c = cellstr(datestr(date, testcase.DateTimeFormSQL));
    input = [date_c, num2cell(x)];
    names = {'DateTime_UTC', 'Speed_Loss'};
    [startrow, numrows] = testcase.insert(input, names);
    
    [exp_date, datei] = sort(date, 'ascend');
    exp_date = cellstr(datestr(exp_date, testcase.DateTimeFormAdodb));
    exp_x = num2cell(x(datei));
    exp_sorted = [exp_date, exp_x];
    
    % Execute
    testcase.call('sortOnDateTime');
    
    % Verify
    act_sorted = testcase.read(names, startrow, numrows);
    
    msg_sorted = ['All data read from table expected to be sorted based on'...
        ' the values of the "DateTime" column.'];
    testcase.verifyEqual(act_sorted, exp_sorted, msg_sorted);
    
    end
    
    function testupdateAirDensity(testcase)
    % Test that procedure updateAirDensity will update appropriate values.
    % 1: Test that the values for column 'airDensity' will be updated with
    % those from the appropriate columns as descirbed by equation G5 in IMO
    % standard ISO/DIS 19030-2, namely:
    % airDensity = airPressure / SpecificGasConstant * (AirTemp + 273.15)
    
    % Inputs
    in_press = [1.225, 1.2, 1.1];
    in_R = 287.058;
    in_Temp = [25, 30, 27];
    exp_dens = num2cell( in_press ./ (in_R.*(in_Temp + 273.15)) )';
    
    names_c = {'Air_Pressure', 'Air_Temperature'};
    [startrow, numrows] = testcase.insert([in_press', in_Temp'], names_c);
    
    % Execute
    testcase.call('updateAirDensity');
    
    % Verify
    act_dens = testcase.read('Air_Density', startrow, numrows);
    msg_dens = ['Data for column ''Air_Density'' should have values ',...
        'matching those given for Equation G5 in standard ISO 19030'];
    testcase.verifyEqual(act_dens, exp_dens, 'AbsTol', 1e-9, msg_dens);
    
    end
end

methods
    
    function call(testcase, funcname, varargin)
    % CALL Execute procedure call given procedure name and inputs
    % call(testcase, funcname) will call the stored procedure FUNCNAME in
    % the database given by input object TESTCASE. 
    % call(testcase, funcname, inputs) will, in addition to the above, call
    % procedure FUNCNAME with inputs given by string or cell of strings
    % INPUTS. 
    
    conn = testcase.Connection;
    inputs_s = '()';
    if nargin > 2
        inputs_c = cellstr(varargin{1});
        inputs_s = ['(' strjoin(inputs_c, ', ') ')'];
    end
    
    sql_s = ['CALL ' funcname, inputs_s, ';'];
    adodb_query(conn, sql_s);
    
    end
    
    function [data, colnames] = read(obj, varargin)
    % READ Reads the database with optional specified parameters
    % data = read(obj) will return in DATA a cell array containing all rows
    % for all columns in the database table specified by input object OBJ.
    % data = read(obj, names) will return in DATA all data from the table
    % specified in OBJ for the column name(s) given by string or cell array
    % of strings NAMES.
    % data = read(obj, names, startrow, count) will, in addition to the 
    % above, return only the data from row number STARTROW and having the 
    % number of rows given by COUNT. Inputting COUNT without a STARTROW 
    % will result in COUNT having no effect.
    
        % Input
        names_s = '*';
        if nargin > 1
            names_c = varargin{1};
            names_c = cellstr(names_c);
            names_s = strjoin(names_c, ', ');
        end
        
        start_s = '';
        if nargin > 2
            start_row = varargin{2};
            start_s = num2str(start_row);
        end
        
        count_s = '1';
        if nargin > 3
            count_d = varargin{3};
            count_s = num2str(count_d);
        end
        
        % Establish Connection
        sqlConn = obj.Connection;
        
        % Read command
        sql_read = ['SELECT ', names_s, ' FROM ' obj.TableName];
        if ~isempty(start_s)
            sql_read = [sql_read, ' LIMIT ', start_s, ', ', count_s];
        end
        [~, out] = adodb_query(sqlConn, sql_read);
        
        % Output
        colnames = names_c;
        data = out;
        
    end
    
    function [startrow, numrows] = insert(testcase, data, names)
    % INSERT Inserts data into table, returning indices to read
    % startrow = insert(testcase, data, names) will call INSERT on the data
    % in DATA with the column names given by cell array of strings NAMES
    % for the database and tables given by object TESTCASE. NAMES must have
    % as many elements as columns in DATA.
    
    % Establish Connection
    sqlConn = testcase.Connection;
    
    % Insert command
    if isnumeric(data)
        
        w = mat2str(data);
        e = strrep(w, ' ', ', ');
        r = strrep(e, ';', '),(');
        t = strrep(r, '[', '(');
        data_str = strrep(t, ']', ')');
    elseif iscell(data)
        
        % Assume first column is date data
        data(:, 1) = strcat('''', data(:, 1), '''');
        
        data(:, 2:end) = cellfun(@num2str, data(:, 2:end), 'Uni', 0);
        for qi = 1:size(data, 1)
            data(qi, 1) = { strjoin(data(qi, :), ', ') };
        end
        data(:, 2:end) = [];
        
        data_c = cellfun(@(x) ['(' strrep(x, '  ', ', ') '),'],...
            data, 'Uni', 0);
        data_c = data_c(:)';
        data_str = [data_c{:}];
        data_str(end) = [];
    end
    
    names_str = ['(', strjoin(names, ', '), ')'];
    
    sql_numrows = ['SELECT COUNT(*) FROM ' testcase.TableName];
    [~, startrow_c] = adodb_query(sqlConn, sql_numrows);
    startrow = str2double( [startrow_c{:}] );
    numrows = size(data, 1);
    
    sql_insert = ['INSERT INTO ' testcase.TableName ' ' names_str ' VALUES ' , ...
        ' ', data_str, ';'];
    adodb_query(sqlConn, sql_insert);
    
    end
    
end

end