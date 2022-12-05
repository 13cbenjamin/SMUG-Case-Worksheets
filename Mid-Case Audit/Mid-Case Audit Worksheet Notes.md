## Current status:
Working to get the CheckBox for Verified - Corrected to show in the Secured Claims
Also talked to Tracy and 1 single Verified box is better than each column having a verified box. 


## Friday 8/19
I managed to get the checkboxes to show up for Verified, Corrected, and TextBox for Comments for all claims tables
I also removed the checkboxes for verified from each of the individual table cells since the singular verfified will apply to the whole row. 

## 8/22
Began working on the calculator part
Trying to get total to work for Plan Payment section. Currently the Subtotal and Months are calculating but the Subtotal is coming out as NaN. 

## 8/23
- Need to fix trash icon in calc, need to clear contents and hide row.  (done)
- Set it so completed cannot be checked unless every section has a verified/corrected as checked.  (done)
- Update forum note to go to Case Review instead of Case Administration.  (Updated)

## 8/24
- Remove random number on claims, it's causing worksheet reloads to uncheck boxes since random is changing each time. 
- Fixed issues identified 8/23. The completed checkbox is only available once at least half of the total checkboxes (minus 5 for final section) are checked, and not counting the completed checkbox itself. 
- Added hover to the completed checkbox when disabled so that it may educate the user why the box is not checked. I had attempted to trigger a page alert when clicking the box however, due to worksheet logic, it was still checking the box even though it wasn't visually indicated until refresh, even when triggering event and unchecking the box. I then resorted to disabling and only enabling once the proper number of checkboxes have been checked. 

## Beta test
The worksheet is now live in the system for beta testing by Tracy. 

## TO DO
I still need to draft the SOP and instructions for this worksheet. 


## notes from meeting
Move to claims: Review and Verify all secured, provided for creditors, are being paid as provided  - Done
Move to claims: Review interest rate for vehicle or other secured claims. Lower interest rate of plan or claim to be used - Done
Move to claims: Review Interest Recalc and update interest due if underpaid. If we have overpaid interest, email Ann to reallocate overage of interest paid to principal paid - Done
Move to claims: Mortgage Claims: Verify the arrears claim is filed correctly - Done
Move to claims: Do we have a 'Hold Money' claim?  - Done 

Remove Plan Section 2 row 1 = Verify Unsecured Percent Correct Unsecured Percent From Case Modify: 100.000%  - Done 

Feasability -> Add auditor feasability question to claim section, there will be 2 sections, one for auditor to check feasability and one for the auditor to tell the CA there is a feasability issue. 
Is the plan still feasible? -> change to feasability issue to address./ 


Verify Attorney Fee's is duplicated.  In top section, add the Verified / Corrected / Comment box and remove attorney fees from the claim review. Only need to review attorney fee's once  

BUG: Unchecking completed - left the hold open disabled, unable to check either box. 

Body of message -> review the mid-case audit worksheet for this case and address. 
Change subject to Mid Case Audit Needs Addressing 


Tickle -> Change the email to creat a tickle instead when worksheet is marked hold open, send to CA. 


## Tickle
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

-- The tickle will only send once every 30 days while the worksheet is marked 'hold open'



## 9/9/2022
Mid-case audit was reworked after meeting with Z, Tracy, and Ann to better suit their needs. Some sections were moved around or removed entirely. 
A tickle was added to notify CA when a mid-case audit is marked hold-open. 


## 9/26/2022
updated the workflow update string. There was a bug that was sending all cases to Fava because I forgot to update the userID in the tickle when the workflow ran to be that of the case administrator. 


## 10/6/2022
Removed plan section 1 in plan review entirely. The plan section 1 does not need to be reviewed during mid-case audit since the three items from that section only apply during pre-confirmation. After meeting with tracy, it was decided that it would be best to remove that due to a conflict with the non-standard plan provisions and how it was being interpreted against the case modify 'non-standard plan'. During this change, the non-standard plan case flag in CH13Flags was also updated to clarify that the non-standard plan case flag is really referring to plan section 1B and 1C, and not 1A. 


## 10/26/2022
Revised entire calculator to match the same code and logic as the Plan Narrative worksheet calculator. This way, all calculators are designed with the same structure (different row numbers) and the math functions in javascript at the same. I also changed it from a split 30%/70% view width to full width. 
Updated the report update statement to ensure that it updates the values into tblTAC_BaseCalc with this worksheet ID. 
Also updated calculate button to update the auditor calculated value. 