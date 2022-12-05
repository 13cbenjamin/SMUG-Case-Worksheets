UPDATE tblPayee 
SET NoticeOfFinalCurePaymentDate = DateAdd(Day,0,DateDiff(Day,0,GETDATE())) 
WHERE CaseID = {CaseID} 
AND ClaimID = CASE {UserInput2} WHEN 0 
              THEN ( SELECT TOP 1 ClaimID 
                     FROM tblPayee p 
                     WHERE CaseID = {CaseID} 
                     AND PrincipalResidence = 1 
                     AND NoticeOfFinalCurePaymentDate = '1/1/1900' 
                     ORDER BY ClaimID ) 
              ELSE {UserInput2} END; 

INSERT tblInbox ( UserIDs, InboxItemType, CaseNumber, InboxText, 
    InboxDetail, ActivateTickleDate, ActionOrInfo, InboxColor ) 
SELECT '{UserInput1}', 1, CaseNumber, 'Notice of Final Cure Follow up - ' + vwCRDebtor1.Deb1LastName, 
    CaseNumber + ' - 21 day follow up to the final cure notice submitted on ' + CONVERT(VARCHAR(10),GetDate(),101), 
    DATEADD(d,21,CONVERT(VARCHAR(10),GetDate(),101)), 'I', 3 
FROM tblCaseData INNER JOIN 
vwCRDebtor1 ON tblCaseData.CaseID = vwCRDebtor1.CaseID 
WHERE tblCaseData.CaseID = {CaseID}  
AND NOT EXISTS 
 (SELECT tblInbox.InboxID 
  FROM tblInbox 
  WHERE tblInbox.CaseNumber = (SELECT CaseNumber from tblCaseData WHERE tblCaseData.CaseID = {CaseID}) 
  AND tblInbox.UserIDs = '{UserInput1}' 
  AND tblInbox.InboxText LIKE '%Notice of Final Cure Follow up%'); 

UPDATE tblDocumentDetail 
SET tblDocumentDetail.DocketTextFreeText = 
 ( SELECT vwCRMainPayee.LongName 
  FROM vwCRMainPayee 
  WHERE vwCRMainPayee.CaseID = {CaseID} 
    AND vwCRMainPayee.ClaimID = {UserInput2}) 
WHERE tblDocumentDetail.DocumentID = {DocumentID}; 

UPDATE tblDocumentDetail 
SET tblDocumentDetail.RelateToThisDocumentFormTypeWhenFiling = 0 
WHERE tblDocumentDetail.DocumentID = {DocumentID}; 

INSERT tblForum ( CaseID, Header, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID}, tblForumHeading.Description, {UserInput1}, GetDate(), 0, tblForumHeading.ForumHeadingID, 1 
FROM tblForumHeading 
WHERE tblForumHeading.ForumHeadingID = 7 
AND NOT EXISTS 
( SELECT tblForum.ForumID 
  FROM tblForum 
  WHERE tblForum.CaseID = {CaseID} 
  AND tblForum.LinkForumID = 0 
  AND tblForum.ForumHeadingID = tblForumHeading.ForumHeadingID ); 

INSERT tblForum ( CaseID, Header, Detail, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID},'Form 4100N - Notice of Final Cure Payment', CONVERT(VARCHAR(10),GetDate(),101) + ' (' + RTRIM(tblUserTable.UserInitials) + ') - Mailed Notice of Final Cure Payment to ' + P.LongName + '. Response date: ' + CONVERT(VARCHAR(10),DATEADD(d,21,GetDate()),101) + '. The next postpetition payment is due: ' + DATENAME(m,'{UserInput3}') + ' ' + DATENAME(yyyy,'{UserInput3}'), {UserInput1}, GetDate(), F.ForumID, F.ForumHeadingID, {UserInput1} 
FROM tblForum F INNER JOIN 
vwCRMainPayee P ON F.CaseID = P.CaseID INNER JOIN 
tblUserTable ON F.TruCode = tblUserTable.TruCode 
WHERE F.CaseID = {CaseID} 
AND F.ForumHeadingID = 7 
AND F.LinkForumID = 0 
AND P.ClaimID = {UserInput2} 
AND tblUserTable.UserCodeID = {UserInput1}; 

INSERT tblDocumentKeys ( DocumentID, DocumentKey, KeyTable ) 
VALUES ({DocumentID}, (SELECT SCOPE_IDENTITY()), 1077); 

INSERT tblDocumentKeys ( DocumentID, DocumentKey, KeyTable ) 
SELECT {DocumentID}, A.PayeeID, 1047 
FROM tblPayee AS B 
CROSS APPLY (  SELECT tblPayee.PayeeID 
               FROM tblPayee 
               WHERE tblPayee.MortgageLink = B.MortgageLink 
      AND tblPayee.CaseID = B.CaseID 
      AND tblPayee.MortgageLink <> '' 
            ) AS A 
WHERE B.ClaimID = {UserInput2} 
AND B.CaseID = {CaseID};

DELETE FROM tblch13Dates WHERE DatesCodeID = 32 AND LinkTableCodeId = 1000 AND
LinkTableKey = {CaseID};
INSERT INTO tblch13Dates(LinkTableCodeID, LinkTableKey,DatesCodeID,EventDate)
VALUES (1000,{CaseID},32,GetDate());