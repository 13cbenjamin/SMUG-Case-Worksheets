INSERT tblForum (CaseID, Header, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID}, tblForumHeading.Description, {UserCodeID}, GetDate(), 0, tblForumHeading.ForumHeadingID, 1 
FROM tblForumHeading 
WHERE tblForumHeading.ForumHeadingID = 16 
AND NOT EXISTS 
( SELECT tblForum.ForumID 
FROM tblForum 
WHERE tblForum.CaseID = {CaseID}
AND tblForum.LinkForumID = 0 
AND tblForum.ForumHeadingID = tblForumHeading.ForumHeadingID );

-- Create Forum Entry 
INSERT tblForum ( CaseID, Header, Detail, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID}, 'Mid-Case Audit', ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},221,'TextBox',12215,0)), ''), {UserCodeID}, GetDate(), F.ForumID, F.ForumHeadingID, {UserCodeID}
FROM tblForum F WHERE F.CaseID = {CaseID} AND F.ForumHeadingID = 16 AND F.LinkForumID = 0;
-- End forum update section


-- Base Calc Table tblTAC_BaseCalc
    -- Plan Payments
DECLARE @cnt INT;
DECLARE @cnt_total INT;
DECLARE @TBLSECTION INT;
DECLARE @WORKSHEETID INT;
SET @WORKSHEETID = 218;
SET @cnt = 0;
SET @cnt_total = 21;
SET @TBLSECTION = 99
WHILE @cnt < @cnt_total
    BEGIN
        if (@cnt < 10)
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 218, {CaseID}, 1, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'10'+CAST(@cnt as VARCHAR),0)), 'Plan Payment', (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'20'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'30'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'60'+CAST(@cnt as VARCHAR),0))
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'10'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 218, {CaseID}, 1, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'1'+CAST(@cnt as VARCHAR),0)), 'Plan Payment', (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'2'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'3'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'6'+CAST(@cnt as VARCHAR),0))
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
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 218, {CaseID}, 2, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'90'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'50'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'90'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 218, {CaseID}, 2, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'9'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'5'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
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
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 218, {CaseID}, 3, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'70'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'80'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'70'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
        ELSE
            BEGIN
                Insert Into TblTAC_BaseCalc (TruCode, BaseCalcDate, WorksheetID, CaseID, SECTION, tblRow, Amount, Description, Periods, PmtsPerMonth, EffectiveDate)
                SELECT 'TAC', GetDate(), 218, {CaseID}, 3, @cnt, (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'7'+CAST(@cnt as VARCHAR),0)), (SELECT dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'8'+CAST(@cnt as VARCHAR),0)), 0, 0, '1/1/1900'
                WHERE dbo.udfGetWorksheetData({CaseID},@WORKSHEETID,'TextBox', CAST(@TBLSECTION as VARCHAR) +'7'+CAST(@cnt as VARCHAR),0) <> '' 
                SET @cnt = @cnt + 1;
            END
    END;


