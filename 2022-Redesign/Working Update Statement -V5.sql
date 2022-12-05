SELECT 1; 
--Version 6 -- Added Base Calc values to be stored in tblTAC_PlanNarrative
-- eliminate 'null' values 
-- Added isnull(select..., '0') for comment values so it will enter a blank or a 0 and not 'NULL'
-- added 2 update statements right before forum note to clear any null values for amended or comment columns for this plan
-- updated forum insert statements to account for new comment type 
DECLARE @TBLSECTION INT; -- Used to identify DIV Section Numbers for each table (51 - 66) 
DECLARE @SECTION VARCHAR; -- Used in the update after each Insert Into tblTAC_PlanNarrative to update first column with section number
DECLARE @WORKSHEETID INT; --Declare WOrksheet integer 
DECLARE @PLANID INT;
SET @WORKSHEETID = 186; -- Set worksheet id, useful for re-using code in future projects 
DECLARE @randomnumber int;
SET @randomnumber = RAND()*(100-1)+13

--Set PlanNumber in SQL Table equal to 1 if Original plan, otherwise set PlanNumber equal to Document Number entered so it can be referenced back later 
 SET @PLANID = CONCAT((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',111,0)),@randomnumber)

--Set Amended Plan ID of Previous Court Doc #
DECLARE @PREVPLANID INT;
 SET @PREVPLANID = (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',112,0) = CAST(1 AS BIT) then
 (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',112,0))
 ELSE  '0' 
 end) 

--Start Update tblTAC_PlanNarrative section of building data to put into custom table 
SET @TBLSECTION = 111 
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',111,0), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',112,0)), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',111,0) = CAST(1 AS BIT) then 'Original ' ELSE '' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',112,0) = CAST(1 AS BIT) then 'Amended ' ELSE '' end), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',3,0)), '', ''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox','111',0) <> '' 


SET @TBLSECTION = 211 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',211,0) = CAST(1 AS BIT) then 'Yes' ELSE 'No' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',212,0) = CAST(1 AS BIT) then 'Yes' ELSE 'No' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',213,0) = CAST(1 AS BIT) then 'Yes' ELSE 'No' end), '', '', '', ''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox','211',0) <> '' 


--Section 311
SET @TBLSECTION = 311 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',311,0) = CAST(1 AS BIT) then 'Below Median 36 Months' ELSE '' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',312,0) = CAST(1 AS BIT) then 'Above Median 60 Months' ELSE '' end), '', '', '', '', ''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox','311',0) <> ''

--Section 39
SET @TBLSECTION = 39
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT) -- Setup the HEADER_ROW to separate sections in the TmpTable 
SELECT {CaseID}, @TBLSECTION, 0, (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',40,0) = CAST(1 AS BIT) then '(YES)' ELSE '(NO)' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',41,0) = CAST(1 AS BIT) then '(NO)' ELSE '' end), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',40,0)), '', '', '', '', ''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','40',0) <> ''

SET @TBLSECTION = 40
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT) -- Setup the HEADER_ROW to separate sections in the TmpTable 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), '','','','',(SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10402,0))
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10402',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), '','','','',''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), '','','','',''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), '','','','',''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), '','','','',''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> ''

--Section 41
SET @TBLSECTION = 41 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10301,0)), '', '', '', '', '', ''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10301',0) <> ''

--section 411 frequency
SET @TBLSECTION = 411 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',411,0) = CAST(1 AS BIT) then 'Monthly' ELSE '' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',412,0) = CAST(1 AS BIT) then 'Twice Per Month' ELSE '' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',413,0) = CAST(1 AS BIT) then 'Every Two Weeks' ELSE '' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',414,0) = CAST(1 AS BIT) then 'Weekly' ELSE '' end), '', '', ''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox','411',0) <> '' 

--section 421 Tax Refunds
SET @TBLSECTION = 421 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',421,0) = CAST(1 AS BIT) then 'Committed' ELSE '' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',422,0) = CAST(1 AS BIT) then 'NOT Committed' ELSE '' end), '', '', '', '', '',ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10900,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox','421',0) <> '' 

--Section 431 E: Other
SET @TBLSECTION = 431
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1, COL2, COL3, COL4, COL5, COL6, COL7)
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',431,0)), '', '', '', '', '', ''
WHERE dbo.udfGetWorksheetData({CaseID}, @WORKSHEETID, 'TextBox', '431', 0) <> ''

--Section 501
SET @TBLSECTION = 501 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',501,0)), '', '', '', '', '', ''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','501',0) <> ''

--Section 502
SET @TBLSECTION = 502
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',502,0)), '', '', '', '', '', ''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','502',0) <> ''

--Section 511
SET @TBLSECTION = 511 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',511,0) = CAST(1 AS BIT) then 'Prior to All Creditors' ELSE '' end), 
(SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',512,0) = CAST(1 AS BIT) then 'Monthly Payment of $' ELSE '' end), 
(SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',512,0)), 
(SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',513,0) = CAST(1 AS BIT) then 'All Remaining after the following Creditors: ' ELSE '' end), 
(SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',513,0)), 
(SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',514,0) = CAST(1 AS BIT) then 'Other: ' ELSE '' end), 
(SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',514,0)), 
ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10901,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox','511',0) <> ''

-- START TABLES
-- Base Calc Table tblTAC_BaseCalc
    -- Plan Payments
DECLARE @cnt INT = 0;
DECLARE @cnt_total INT = 21;
SET @TBLSECTION = 99
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), {CaseID}, 1, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'10'+CAST(@cnt as VARCHAR),0)), 'Plan Payment', (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'20'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'30'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'60'+CAST(@cnt as VARCHAR),0))
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'10'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), {CaseID}, 1, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'1'+CAST(@cnt as VARCHAR),0)), 'Plan Payment', (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'2'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'3'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'6'+CAST(@cnt as VARCHAR),0))
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'1'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;

    -- Additional Payments
SET @cnt = 0;
SET @cnt_total = 11;
SET @TBLSECTION = 99
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), {CaseID}, 2, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'90'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'50'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'90'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), {CaseID}, 2, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'9'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'5'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'9'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;

        -- Forgive Amounts
SET @cnt = 0;
SET @cnt_total = 10;
SET @TBLSECTION = 99
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), {CaseID}, 3, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'70'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'80'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'70'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), {CaseID}, 3, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'7'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'8'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'7'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;



-- Section 99 Base Calc Table
-- Add to tblTAC_PlanNarrative
-- Plan Payments
SET @cnt = 0;
SET @cnt_total = 21
SET @TBLSECTION = 99;
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                INSERT INTO tblTAC_PlanNarrative (CaseID, SECTION, tblRow, COL1, COL2, COL3, COL4, COL5, COL6, COL7, Comment)
                SELECT {CaseID}, @TBLSECTION, 0, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'10'+CAST(@cnt as VARCHAR),0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'20'+CAST(@cnt as VARCHAR),0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'30'+CAST(@cnt as VARCHAR),0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'60'+CAST(@cnt as VARCHAR),0),'','','',''
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'10'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                INSERT INTO tblTAC_PlanNarrative (CaseID, SECTION, tblRow, COL1, COL2, COL3, COL4, COL5, COL6, COL7, Comment)
                SELECT {CaseID}, @TBLSECTION, 0, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'10'+CAST(@cnt as VARCHAR),0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'20'+CAST(@cnt as VARCHAR),0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'30'+CAST(@cnt as VARCHAR),0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'60'+CAST(@cnt as VARCHAR),0),'','','',''
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'1'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;

--Additional Payments
SET @cnt = 0;
SET @cnt_total = 21
SET @TBLSECTION = 99;
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                INSERT INTO tblTAC_PlanNarrative (CaseID, SECTION, tblRow, COL1, COL2, COL3, COL4, COL5, COL6, COL7, Comment)
                SELECT {CaseID}, @TBLSECTION,21, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'90'+CAST(@cnt as VARCHAR),0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'50'+CAST(@cnt as VARCHAR),0),'','','','','',''
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'90',0) <> '' 
 SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                INSERT INTO tblTAC_PlanNarrative (CaseID, SECTION, tblRow, COL1, COL2, COL3, COL4, COL5, COL6, COL7, Comment)
                SELECT {CaseID}, @TBLSECTION,21, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'9'+CAST(@cnt as VARCHAR),0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'5'+CAST(@cnt as VARCHAR),0),'','','','','',''
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'9'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;

-- FORGIVE AMOUNTS
SET @cnt = 0;
SET @cnt_total = 21
SET @TBLSECTION = 99;
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                INSERT INTO tblTAC_PlanNarrative (CaseID, SECTION, tblRow, COL1, COL2, COL3, COL4, COL5, COL6, COL7, Comment)
                SELECT {CaseID}, @TBLSECTION,42, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'70'+CAST(@cnt as VARCHAR),0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'80'+CAST(@cnt as VARCHAR),0),'','','','','',''
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'70'+CAST(@cnt as VARCHAR),0) <> '' 
                 SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                INSERT INTO tblTAC_PlanNarrative (CaseID, SECTION, tblRow, COL1, COL2, COL3, COL4, COL5, COL6, COL7, Comment)
                SELECT {CaseID}, @TBLSECTION,42, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'7'+CAST(@cnt as VARCHAR),0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'8'+CAST(@cnt as VARCHAR),0),'','','','','',''
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'7'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;

-- END of Base Calc

-- Section 51
SET @TBLSECTION = 51 
--SET @SECTION = CONVERT(String,@TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT) -- Setup the HEADER_ROW to separate sections in the TmpTable 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10902,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10902',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 
SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> ''

-- Section 52

SET @TBLSECTION = 52 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10903,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10903',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> ''


-- Section 53
SET @TBLSECTION = 53 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10904,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10904',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> ''

-- Section 54
SET @TBLSECTION = 54
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10905,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10905',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> '' 


-- Section 55
SET @TBLSECTION = 55 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10906,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10906',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> '' 

-- Section 56
SET @TBLSECTION = 56 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10907,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10907',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> ''

-- Section 57
SET @TBLSECTION = 57 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10908,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10908',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> ''

 --SECTION 58
SET @TBLSECTION = 58 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT) 
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',580,0) = CAST(1 AS BIT) then 'None' ELSE '' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',581,0) = CAST(1 AS BIT) then '100%' ELSE '' end), (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',582,0) = CAST(1 AS BIT) then 'At Least: $' ELSE '' end), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',5821,0)), '', '', '', ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10909,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox','580',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10909',0) <> ''

-- Section 59
SET @TBLSECTION = 59 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);

INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10910,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10910',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> '' 


-- Section 61
SET @TBLSECTION = 61
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10911,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10911',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> '' 


-- Section 62
SET @TBLSECTION = 62 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10912,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10912',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> '' 


-- Section 63
SET @TBLSECTION = 63 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Testing with Current Domsetic Support obligations, Section 51, rows 5101,5102 to 5191 and 5192 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10913,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10913',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> '' 

-- Section 64
SET @TBLSECTION = 64 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10914,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10914',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> ''  or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0) <> '' or dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0) <> ''

--Section 65
SET @TBLSECTION = 65 
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
-- Gets value in First textbox of the section. Accounts for all possible boxes being filled out (7 Columns and 10 rows) 
--If the first box is empty then it skips the row. 
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',6501,0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',6502,0)), '', '', '', '', '', ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10915,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','6501',0) <> ''OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10915',0) <> ''

-- Section 66 Non-Standard Provisions
SET @TBLSECTION = 166
SET @SECTION = CONVERT(VARCHAR, @TBLSECTION);
INSERT INTO tblTAC_PlanNarrative (CaseID,SECTION,tblRow,COL1,COL2,COL3,COL4,COL5,COL6,COL7,COMMENT)
SELECT {CaseID}, @TBLSECTION, 1, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'02',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'03',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'04',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'05',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'06',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '07',0),ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',10916,0)), '0')
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'01',0) <> '' OR dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox','10916',0) <> ''
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 2, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'12',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'13',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'14',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'15',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'16',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '17',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'11',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 3, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'22',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'23',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'24',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'25',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'26',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '27',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'21',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 4, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'32',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'33',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'34',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'35',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'36',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '37',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'31',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 5, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'42',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'43',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'44',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'45',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'46',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '47',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'41',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 6, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'52',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'53',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'54',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'55',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'56',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '57',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'51',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 7, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'62',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'63',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'64',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'65',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'66',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '67',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'61',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 8, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'72',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'73',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'74',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'75',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'76',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '77',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'71',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 9, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'82',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'83',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'84',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'85',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'86',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '87',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'81',0) <> '' 
UNION ALL 

SELECT {CaseID}, @TBLSECTION, 10, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0)),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'92',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'93',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'94',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'95',0),dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'96',0), dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) + '97',0),''
WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'91',0) <> '' 

--Perform Table Updates for Date and PlanNumber 
UPDATE tblTAC_PlanNarrative SET PlanNumber = @PLANID where PlanNumber IS NULL AND CaseID = {CaseID} AND PlanDate IS NULL; 

--Add Date to Plan for reference purposes 
Update tblTAC_PlanNarrative SET PlanDate = GetDate() where CaseID = {CaseID} and PlanDate IS NULL; 

-- Need to determine if previous plan exists in tblTAC_PlanNarrative for this case. 
-- If no plan has been filed in new table then we don't want to track changes since it will highlight everything. 
Declare @PrevPlanV2Exists INT;
Set @PrevPlanV2Exists = (Select Case when (Select DISTINCT CaseID from tblTAC_PlanNarrative where CaseID = {CaseID}) = {CaseID} then '1' ELSE  '0' end)

--Change the PrevPlanID to account for the random plan numbers being saved in database
 SET @PREVPLANID = (Select TOP 1 PlanNumber from tblTAC_PlanNarrative where section = 111 and CaseID = {CaseID} and PlanNumber <> @PlanID order by PlanID desc)


--CLEANUP PREVIOUS PLAN IN tblTAC_PlanNarrative to remove <mark> and </mark> for previous highlighting before comparing fields 
 Update tblTAC_PlanNarrative set COL1 = Replace(Replace(COL1, '<MARK>', ''),'</MARK>', '') where PlanID in ( Select PLanID from tblTAC_PlanNarrative where COL1 like '%<MARK>%' and caseid = {CaseID} and PlanNumber = @PrevPlanID)
 Update tblTAC_PlanNarrative set COL2 = Replace(Replace(COL2, '<MARK>', ''),'</MARK>', '') where PlanID in ( Select PLanID from tblTAC_PlanNarrative where COL2 like '%<MARK>%' and caseid = {CaseID} and PlanNumber = @PrevPlanID)
 Update tblTAC_PlanNarrative set COL3 = Replace(Replace(COL3, '<MARK>', ''),'</MARK>', '') where PlanID in ( Select PLanID from tblTAC_PlanNarrative where COL3 like '%<MARK>%' and caseid = {CaseID} and PlanNumber = @PrevPlanID)
 Update tblTAC_PlanNarrative set COL4 = Replace(Replace(COL4, '<MARK>', ''),'</MARK>', '') where PlanID in ( Select PLanID from tblTAC_PlanNarrative where COL4 like '%<MARK>%' and caseid = {CaseID} and PlanNumber = @PrevPlanID)
 Update tblTAC_PlanNarrative set COL5 = Replace(Replace(COL5, '<MARK>', ''),'</MARK>', '') where PlanID in ( Select PLanID from tblTAC_PlanNarrative where COL5 like '%<MARK>%' and caseid = {CaseID} and PlanNumber = @PrevPlanID)
 Update tblTAC_PlanNarrative set COL6 = Replace(Replace(COL6, '<MARK>', ''),'</MARK>', '') where PlanID in ( Select PLanID from tblTAC_PlanNarrative where COL6 like '%<MARK>%' and caseid = {CaseID} and PlanNumber = @PrevPlanID)
 Update tblTAC_PlanNarrative set COL7 = Replace(Replace(COL7, '<MARK>', ''),'</MARK>', '') where PlanID in ( Select PLanID from tblTAC_PlanNarrative where COL7 like '%<MARK>%' and caseid = {CaseID} and PlanNumber = @PrevPlanID)


--Table Comparison
--Using Inner Join on same table by matching CaseID, Section, and Row, check to see if the data is different
--If the data is different, concatenation is done to add html '<MARK>' and '</MARK>'

Update tblTAC_PlanNarrative set COL1 = CONCAT('<MARK>', COL1, '</MARK>') where PlanID in(
Select d1.PlanID from tblTAC_PlanNarrative d1
INNER JOIN tblTAC_PlanNarrative d2 on d1.CaseID = d2.CaseID and d1.SECTION = d2.SECTION  and d1.tblRow = d2.tblRow
where @PREVPLANID <> 0 AND d2.col1 <> d1.COL1
and d1.section <> 111 and d2.section <> 111
 and d1.CaseID = {CaseID} and d2.CaseID = {CaseID} 
 and d1.PlanNumber = @PlanID and d2.PlanNumber = @PREVPLANID)

 Update tblTAC_PlanNarrative set COL2 = CONCAT('<MARK>', COL2, '</MARK>') where PlanID in(
Select d1.PlanID from tblTAC_PlanNarrative d1
INNER JOIN tblTAC_PlanNarrative d2 on d1.CaseID = d2.CaseID and d1.SECTION = d2.SECTION  and d1.tblRow = d2.tblRow
where @PREVPLANID <> 0 AND d2.col2 <> d1.COL2
 and d1.section <> 111 and d2.section <> 111
 and d1.CaseID = {CaseID} and d2.CaseID = {CaseID} 
 and d1.PlanNumber = @PlanID and d2.PlanNumber = @PREVPLANID)

 Update tblTAC_PlanNarrative set COL3 = CONCAT('<MARK>', COL3, '</MARK>') where PlanID in(
Select d1.PlanID from tblTAC_PlanNarrative d1
INNER JOIN tblTAC_PlanNarrative d2 on d1.CaseID = d2.CaseID and d1.SECTION = d2.SECTION  and d1.tblRow = d2.tblRow
where @PREVPLANID <> 0 AND d2.col3 <> d1.COL3
 and d1.section <> 111 and d2.section <> 111
 and d1.CaseID = {CaseID} and d2.CaseID = {CaseID} 
 and d1.PlanNumber = @PlanID and d2.PlanNumber = @PREVPLANID)

  Update tblTAC_PlanNarrative set COL4 = CONCAT('<MARK>', COL4, '</MARK>') where PlanID in(
Select d1.PlanID from tblTAC_PlanNarrative d1
INNER JOIN tblTAC_PlanNarrative d2 on d1.CaseID = d2.CaseID and d1.SECTION = d2.SECTION  and d1.tblRow = d2.tblRow
where @PREVPLANID <> 0 AND d2.col4 <> d1.COL4
 and d1.section <> 111 and d2.section <> 111
 and d1.CaseID = {CaseID} and d2.CaseID = {CaseID} 
 and d1.PlanNumber = @PlanID and d2.PlanNumber = @PREVPLANID)

  Update tblTAC_PlanNarrative set COL5 = CONCAT('<MARK>', COL5, '</MARK>') where PlanID in(
Select d1.PlanID from tblTAC_PlanNarrative d1
INNER JOIN tblTAC_PlanNarrative d2 on d1.CaseID = d2.CaseID and d1.SECTION = d2.SECTION  and d1.tblRow = d2.tblRow
where @PREVPLANID <> 0 AND d2.col5 <> d1.COL5
 and d1.section <> 111 and d2.section <> 111
 and d1.CaseID = {CaseID} and d2.CaseID = {CaseID} 
 and d1.PlanNumber = @PlanID and d2.PlanNumber = @PREVPLANID)

  Update tblTAC_PlanNarrative set COL6 = CONCAT('<MARK>', COL6, '</MARK>') where PlanID in(
Select d1.PlanID from tblTAC_PlanNarrative d1
INNER JOIN tblTAC_PlanNarrative d2 on d1.CaseID = d2.CaseID and d1.SECTION = d2.SECTION  and d1.tblRow = d2.tblRow
where @PREVPLANID <> 0 AND d2.col6 <> d1.COL6
 and d1.section <> 111 and d2.section <> 111
 and d1.CaseID = {CaseID} and d2.CaseID = {CaseID} 
 and d1.PlanNumber = @PlanID and d2.PlanNumber = @PREVPLANID)

  Update tblTAC_PlanNarrative set COL7 = CONCAT('<MARK>', COL7, '</MARK>') where PlanID in(
Select d1.PlanID from tblTAC_PlanNarrative d1
INNER JOIN tblTAC_PlanNarrative d2 on d1.CaseID = d2.CaseID and d1.SECTION = d2.SECTION  and d1.tblRow = d2.tblRow
where @PREVPLANID <> 0 AND d2.col7 <> d1.COL7
 and d1.section <> 111 and d2.section <> 111
 and d1.CaseID = {CaseID} and d2.CaseID = {CaseID} 
 and d1.PlanNumber = @PlanID and d2.PlanNumber = @PREVPLANID)

  --This function checks for new sections that were not part of previous plan and sets Amended to 1. 
        --Only works if not original and a previous plan exists in table  
       -- Drop Table #scrows 
       -- Drop Table #sprows 
        Declare @Amended VARCHAR;
        Set @Amended = (SELECT CASE WHEN dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'CheckBox',112,0) = CAST(1 AS BIT) then '1' ELSE  '0' end) 
        Select CaseID, PLanNumber, Section into #scrows from tblTAC_PlanNarrative where CaseID = {CaseID} and PlanNumber = @PlanID group by CaseID, PlanNumber, Section
        Select CaseID, PlanNumber, SEction into #sprows from tblTAC_PlanNarrative where CaseID = {CaseID} and PLanNumber = @PREVPLANID group by CaseID, PlanNumber, SEction
        --Create 2 temp tables, using an EXCEPT clause, determine new sections and Set Amended to 1 
        Update tblTAC_PlanNarrative Set Amended = 1 where CaseID = {CaseID} and @Amended = '1' and @PrevPlanV2Exists = '1' AND @PREVPLANID <> 0 AND PlanNumber = @PlanID and Section IN 
        (
            SELECT Section from #scrows
            EXCEPT
            SELECT Section From #sprows
      
   );


 Update tblTAC_PlanNarrative 
    SET Amended = 1
    where PlanID in(
    Select d1.PlanID from tblTAC_PlanNarrative d1
    INNER JOIN tblTAC_PlanNarrative d2 on d1.CaseID = d2.CaseID and d1.SECTION = d2.SECTION and d1.tblRow > d2.tblRow
    where d1.CaseID = {CaseID} and d2.CaseID = {CaseID}
 and d1.tblRow NOT IN (Select tblrow from tblTAC_PlanNarrative where section = d1.SECTION and PlanNumber = @PrevPlanID and tblrow <> d2.tblRow)
    and d1.section <> 111 and d2.section <> 111
    and d1.PlanNumber = @PlanID and d2.PlanNumber = @PrevPlanID
    )


   --For rows with Amended (meaning new sections or rows, add <mark> </mark> to all column fields since they are all new)
 Update tblTAC_PlanNarrative 
 set COL1 = CONCAT('<MARK>', COL1, '</MARK>'), 
 COL2 = CONCAT('<MARK>', COL2, '</MARK>'), 
 COL3 = CONCAT('<MARK>', COL3, '</MARK>'),
 COL4 = CONCAT('<MARK>', COL4, '</MARK>'),
 COL5 = CONCAT('<MARK>', COL5, '</MARK>'),
 COL6 = CONCAT('<MARK>', COL6, '</MARK>'),
 COL7 = CONCAT('<MARK>', COL7, '</MARK>')
 where PlanID in(Select PlanID from tblTAC_PlanNarrative where AMENDED = 1 and PlanNumber = @PlanID and CaseID = {CaseID} and Section <> 111)


--Added 9/10/2021
-- Fix Null Amended Sections 
Update tblTAC_PlanNarrative 
set AMENDED = 0  where AMENDED IS NULL and CaseID = {CaseID}

--added 9/10/2021
-- Fix NULL Comment sections
Update tblTAC_PlanNarrative
set Comment = '0' where Comment IS NULL and CaseID = {CaseID}

--Create Initial Forum Entry
INSERT tblForum (CaseID, Header, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID}, tblForumHeading.Description, {UserCodeID}, GetDate(), 0, tblForumHeading.ForumHeadingID, 1 
FROM tblForumHeading 
WHERE tblForumHeading.ForumHeadingID = 2 
AND NOT EXISTS 
( SELECT tblForum.ForumID 
FROM tblForum 
WHERE tblForum.CaseID = {CaseID}
AND tblForum.LinkForumID = 0 
AND tblForum.ForumHeadingID = tblForumHeading.ForumHeadingID );

-- Add data to forum
--Uses extermely long Detail section using sequential "ISNULL" sections to build a really long string of non-empty text which gets formatted by HTML 
--Header is defined by Original or Amended box being checked 
INSERT tblForum ( CaseID, Header, Detail, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
Select {CaseID}, (SELECT COL3 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 111) + (SELECT COL4 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 111) + ' Plan Narrative', 
--Section 111 Header 
ISNULL(
(SELECT 
    '<h3> ' + (SELECT COL3 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 111) + (SELECT COL4 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 111) + 'Plan Narrative: </h3> <h4><strong>Current Doc: </strong>' + (SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 111) + '<strong> Previous Doc: </strong>' + (SELECT COL2 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 111) +
   '<strong> Date of Plan: </strong>' + (SELECT COL5 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 111) + '</h4>'), '') +
ISNULL(
--Each ISNULL() section is for a different SECTION and not updating if the value is NULL 
--Section 211 A: B: C: 
(SELECT 
   '<strong>Nonstandard Provs & Plans Mods: </strong> A. ' + (SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 211)  
    + 
 (SELECT ' B. ' + (SELECT COL2 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 211))
    +
 (SELECT ' C. ' + (SELECT COL3 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 211))
 + '</br>'),'') +
ISNULL(
(SELECT 
    '<strong>Means Test & Plan Duration </strong>' +  (SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 311)
    + 
 (SELECT ' ' + (SELECT COL2 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 311)
    + '</br></br>')),'') +
ISNULL(
--Section 39 Does Payment Plan Match I-J 
(SELECT 
   '<strong> Plan Payment Amount: </strong> $' + (SELECT COL3 FROM tblTAC_PlanNarrative WHERE tblrow = 0 AND PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 39))
 ,'') +
 --Section 40 Plan Step Payments
ISNULL(
        (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong> Plan Step Payments</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Start Month</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">End Month</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Amount</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
            '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
            '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
            '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 40 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>' ), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 40) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Section 411 Frequency 
ISNULL(
(SELECT 
    '<strong> Frequency: </strong> ' + 
    (Select COL1 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 411) 
+
    (Select COL2 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 411) 
    +
    (Select COL3 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 411) 
    +
    (Select COL4 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 411)) ,'') + 

 ISNULL(
--Section 39 Does Payment Plan Match I-J 
(SELECT 
    '<strong> Does Plan Payment Match I-J? </strong>' + 
    (SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND tblRow = 0 AND SECTION = 39)),'') +

ISNULL(
--Section 41 Base Calc
(SELECT 
    '</br><strong>Base Calc: </strong>' + 
    (SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 41)
 + '</br>'),'') +

--Section 421 Frequency 
ISNULL(
(SELECT '<strong>Tax Refunds: </strong> ' + 
(Select COL1 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 421) +'</br>'), '') +

 ISNULL((Select (Select COL2 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 421)  +'</br>'),'') +

--Section 431 E: Other 
ISNULL(
(SELECT '<strong>Other E: </strong>' + 
(SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 431) +'<p></p'),'') +
    
--Section 421 Comments
ISNULL(
 (Select (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 421) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
 + '</p>'), '') +

--Section 501 Attorney Fees
ISNULL(
(SELECT '<strong>Attorney Fees: </strong>' + 
(SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 501)),'') +

--Section 502 Attorney Fees
ISNULL(
(SELECT 
    '<strong> Amount Paid Prior to Filing: </strong>' + 
    (SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 502)
 + 
    '<Strong> Amount to be paid in plan </strong>' + 
    (SELECT (CAST(CONVERT(MONEY,(dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',501,0))-CONVERT(MONEY,(dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox',502,0)))) AS VARCHAR))
)),'') +
--Section 411 Frequency 
ISNULL(
(SELECT 
    '<strong> Attorney Fees to be Paid </strong> ' + 
    (Select COL1 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 511) 
 +
(Select COL2 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 511) 
 +
(Select COL3 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 511) 
 +
(Select COL4 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 511) 
 +
 (Select COL5 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 511) 
 +
(Select COL6 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 511) 
+
 (Select COL7 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 511) 
 + '</br>'),'') + 
--Section 511 Comments
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 511) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
    + '</p>'), '') +
--Begin Tables

--Section 51 Current Domestic Support Obligations 
ISNULL(
    (Select (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>Current Domestic Support Obligations</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Amount</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
        '</tr>'  FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 51 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>') ), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 51) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Section 52 1. Ongoing Payments 
ISNULL(
        (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong> 1 Ongoing Payments</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Rank</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Payment</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Collateral</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL4 + '</td>' +
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 52 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>' ), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 52) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Section 53 - 1. Cure Payment 
ISNULL(
(SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong> 1 Cure Payments</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Rank</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Payment</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Collateral</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Arrears to be Cured</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Interest Rate</th>
            </tr>
        </thead>' + 
    
  (SELECT '<tr>' + 
       '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
       '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
       '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
       '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL4 + '</td>' +
       '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL5 + '</td>' +
       '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL6 + '%</td>' +
    '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 53 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>' ), '') +
ISNULL(
(SELECT  (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 53) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Section 54
ISNULL(
    (SELECT 
            (SELECT 
                '</br><table style="width:auto;margin-bottom:4px;">
                    <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong> 2 Ongoing Payments</strong></caption>
                    <thead>
                        <tr>
                            <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Rank</th>
                            <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Payment</th>
                            <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
                            <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Collateral</th>
                            <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Interest Rate</th>
                        </tr>
                    </thead>' + 
                
            (SELECT '<tr>' + 
                    '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
                    '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
                    '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
                    '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL4 + '</td>' +
                    '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL5 + '%</td>' +
                    '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 54 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>') ), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 54) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Each ISNULL() section is for a different SECTION and not updating if the value is NULL 
ISNULL(
    (SELECT (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong> 2 Cure Payments</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Rank</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Payment</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Collateral</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Arrears to be Cured</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Interest Rate</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL4 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL5 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL6 + '%</td>' +
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 55 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>') ), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 55) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
ISNULL(    
    (SELECT (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>910 Collateral</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Rank</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Payment</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Collateral</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Pre-Conf Adq Pro Pmt</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Interest Rate</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL4 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL5 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL6 + '%</td>' +
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 56 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>' )), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 56) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Section 57
ISNULL(
        (SELECT (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>Non-910 Collateral</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Rank</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Payment</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Debtors Value of Collateral</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Collateral</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Pre-Conf Adq Pro Pmt</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Interest Rate</th>

            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL4 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL5 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL6 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL7 + '%</td>' +
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 57 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>')), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 57) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
ISNULL(
(SELECT 
    '<p><strong>4E: Non-priority Unsecured Claims </strong> ' + 
    (SELECT  (Select COL1 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 58) 
    ) +
    (SELECT (Select COL2 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 58) 
    ) +
    (SELECT (Select COL3 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 58) 
    ) +
    (SELECT  (Select COL4 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 58) 
    ) + '</p>'), '')  +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 58) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Section 59
ISNULL(
    (SELECT (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>Specially Classified Non-Priority Unsecured Claims</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Rank</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Amount of Claim</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Percentage to be Paid</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Reason for Special Classification</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL4 + '%</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL5 + '</td>' +
        '</tr>' 
    
FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 59 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>' )), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 59) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
 + '</p>'), '') +

--SECTION 61

ISNULL(
        (SELECT (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>Direct Payment of Domestic Support Obligations</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Current Monthly Support Obligation</th>
    <th style="width:Auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Arrearage Payment</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:Auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
     '<td style="width:Auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 61 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>' )), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 61) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
    + '</p>'), '') +
--Section 62
ISNULL(
            (SELECT (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>Other Direct Payments by Debtor</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Nature of Debt</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Amount of Claim</th>
    <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Monthly Payment</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL3 + '</td>' +
     '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL4 + '</td>' +
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 62 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>' )), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 62) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
 --Section 63
ISNULL(
     (SELECT  (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
        <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>Property to be Surrendered</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Creditor</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Property to be Surrendered</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 63 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>' )), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 63) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
    --Section 64
ISNULL(
            (SELECT (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
    <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>Executory Contracts and Leases</strong></caption>
        <thead>
            <tr>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Contract / Lease</th>
                <th style="width:auto;text-align:left;padding:2px;border: 1px solid black;background:lightgrey">Assumed or Rejected</th>
            </tr>
        </thead>' + 
    
(SELECT '<tr>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL1 + '</td>' + 
           '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;border: 1px solid black;">' + COL2 + '</td>' + 
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 64 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>')), '') +
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 64) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Section 65
ISNULL(
    (SELECT 
    '<strong>The Liquidation Value of the Estate is: </strong> $' + 
    (SELECT (Select COL1 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 65) 
    )), '')  + 
ISNULL(
(Select
    ' <strong> Rate of Interest: </strong>' + (SELECT (Select COL2 FROm tblTAC_PlanNarrative where PlanNumber = @PLANID and CaseID = {CaseID} and SECTIOn = 65) 
    ) + '%<br>'),'') + 
ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 65) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), '') +
--Section 66
ISNULL(
            (SELECT  (SELECT 
    '</br><table style="width:auto;margin-bottom:4px;">
    <caption style="text-align:left;font-size:.8rem;font-family:Arial,Helvetica,sans-serif;"><strong>Non-Standard Provisions</strong></caption>' 
    + 
    (SELECT '<tr>' + 
               '<td style="width:auto;text-align:left;vertical-align:top;padding:2px;">' + COL1 + '</td>' + 
        '</tr>' FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 166 FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)') + '</table>')), '') +

ISNULL(
(SELECT (SELECT DISTINCT '<p style="color:blue">Comments: ' + COMMENT FROM tblTAC_PlanNarrative WHERE (Comment <> '0' AND Comment <> '') and (PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 166) FOR XML PATH (''),TYPE).value('.', 'VARCHAR(MAX)')
     + '</p>'), ''), 
    {UserCodeID}, GetDate(), F.ForumID, F.ForumHeadingID, {UserCodeID}
FROM tblForum F WHERE F.CaseID = {CaseID} AND F.ForumHeadingID = 2 AND F.LinkForumID = 0;
--End Forum Update Section 

--Turned off form type Create Document and turned off Show Document Form Type in Case Documents for RPT-Plan-Nar

--Attach forum note to the original plan based on document number field
INSERT tblDocumentKeys ( DocumentID, DocumentKey, KeyTable ) 
VALUES ((SELECT tblDocumentDetail.DocumentID 
                                 FROM tblDocumentDetail INNER JOIN 
                                 tblCaseData ON tblDocumentDetail.Comment = tblCaseData.CaseNumber
                                 WHERE tblCaseData.CaseID = {CaseID}
                                 AND tblDocumentDetail.CourtsDocumentNumber = '' + (SELECT COL1 FROM tblTAC_PlanNarrative WHERE PlanNumber = @PLANID AND CaseID = {CaseID} AND SECTION = 111)), (SELECT TOP 1 tblForum.ForumID from tblForum where CaseID = {CaseID} and ForumHeadingID = 2 Order By EventDate DESC), 1077);


