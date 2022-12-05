INSERT tblForum (CaseID, Header, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID}, tblForumHeading.Description, {UserCodeID}, GetDate(), 0, tblForumHeading.ForumHeadingID, 1 
FROM tblForumHeading 
WHERE tblForumHeading.ForumHeadingID = 10 
AND NOT EXISTS 
( SELECT tblForum.ForumID 
FROM tblForum 
WHERE tblForum.CaseID = {CaseID}
AND tblForum.LinkForumID = 0 
AND tblForum.ForumHeadingID = tblForumHeading.ForumHeadingID );

-- Create Forum Entry 
INSERT tblForum ( CaseID, Header, Detail, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID}, 'Base Calculator - Worksheet', ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},224,'TextBox',10224,0)), ''), {UserCodeID}, GetDate(), F.ForumID, F.ForumHeadingID, {UserCodeID}
FROM tblForum F WHERE F.CaseID = {CaseID} AND F.ForumHeadingID = 10 AND F.LinkForumID = 0;
-- End forum update section


-- Update tblTAC_BaseCalc table
DECLARE @SECTION VARCHAR; -- Used in the update after each Insert Into tblTAC_PlanNarrative to update first column with section number
DECLARE @WORKSHEETID INT; --Declare WOrksheet integer 
DECLARE @PLANID INT;
DECLARE @cnt INT;
DECLARE @cnt_total INT;
-- Base Calc Table tblTAC_BaseCalc
    -- Plan Payments
SET @WORKSHEETID = 222; -- Set worksheet id, useful for re-using code in future projects 
SET @cnt = 0;
SET @cnt_total = 50;
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 222, {CaseID}, 1, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '10'+CAST(@cnt as VARCHAR),0)), 'Plan Payment', (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '20'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '30'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '60'+CAST(@cnt as VARCHAR),0))
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '10'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 222, {CaseID}, 1, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '1'+CAST(@cnt as VARCHAR),0)), 'Plan Payment', (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '2'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '3'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '6'+CAST(@cnt as VARCHAR),0))
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '1'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;

    -- Additional Payments
SET @cnt = 0;
SET @cnt_total = 100;
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 222, {CaseID}, 2, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '40'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '50'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '40'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 222, {CaseID}, 2, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '4'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '5'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '4'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;

        -- Forgive Amounts
SET @cnt = 0;
SET @cnt_total = 10;
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 222, {CaseID}, 3, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '70'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '80'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '70'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 222, {CaseID}, 3, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '7'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '8'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '7'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;


            -- Stain Amounts
SET @cnt = 0;
SET @cnt_total = 10;
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 222, {CaseID}, 4, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '90'+CAST(@cnt as VARCHAR),0)), '', 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '90'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 222, {CaseID}, 4, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '9'+CAST(@cnt as VARCHAR),0)), '', 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', '9'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;