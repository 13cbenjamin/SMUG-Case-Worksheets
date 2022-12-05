-- Select
Select tblCaseData.CaseID as PrimaryID 
from tblCaseData
join tblCaseWorksheetData on tblcasedata.CaseID = tblCaseWorksheetData.CaseID
where tblCaseWorksheetData.FieldID = 'CheckBox_221_2215'
and tblCaseWorksheetData.SavedData = 'true'
-- Don't create a tickle if one has already been created in the past 30 days. 
AND NOT EXISTS 
 (SELECT tblInbox.InboxID 
  FROM tblInbox 
  WHERE tblInbox.CaseNumber = tblCaseData.CaseNumber 
  AND tblInbox.InboxText LIKE '%Mid-Case Audit - Action Required' 
  AND ( tblInbox.ActivateTickleDate >= GETDATE() -- Tickle exists in the future 
        OR tblInbox.ActivateTickleDate >= DATEADD(day, -30, GETDATE())  -- Tickle was created within 30 days of today 
        OR tblInbox.ClearedDate >= DATEADD(day, -30, GETDATE())  -- Tickle was cleared within 30 days of today 
        OR ( tblInbox.ClearedDate = '1/1/1900'  -- Tickle already exists and has not been cleared yet 
             AND tblInbox.Acknowledged = 0 )) 
 )



 -- UPDATE
 -- Update workflow history to set the workflow description as to which user was notified then update the inbox with text, detail, and the assigned case administrator. 
 UPDATE tblWorkflowHistory 
SET UserCodeID = dbo.udf_TAC_GetUser(tblCaseData.CaseAdministrator), 
    FullDescription = 'User ' + CONVERT(VARCHAR,dbo.udf_TAC_GetUser(tblCaseData.CaseAdministrator)) + ' Notified' 
FROM tblCaseData INNER JOIN 
tblWorkflowHistory ON tblCaseData.CaseID = tblWorkflowHistory.PrimaryID 
WHERE tblWorkflowHistory.WorkflowHistoryID = {WorkflowHistoryID}; 

UPDATE tblInbox 
SET UserIDs = dbo.udf_TAC_GetUser(tblCaseData.CaseAdministrator), 
InboxText = 'Case {CaseNumber} Mid-Case Audit - Action Required', 
InboxDetail = 'A Mid-Case Audit was recently completed on case {CaseNumber} and there are items that require addressing by Case Administrator'
FROM tblCaseData INNER JOIN 
tblWorkflowHistory ON tblCaseData.CaseID = tblWorkflowHistory.PrimaryID INNER JOIN 
tblInbox ON tblWorkflowHistory.WorkflowHistoryID = tblInbox.WorkflowHistoryID 
WHERE tblWorkflowHistory.WorkflowHistoryID = {WorkflowHistoryID} 
AND tblCaseData.CaseID = {CaseID};