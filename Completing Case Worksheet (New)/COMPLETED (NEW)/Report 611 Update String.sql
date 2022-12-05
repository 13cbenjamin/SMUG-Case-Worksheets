INSERT tblForum (CaseID, Header, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID}, tblForumHeading.Description, {UserCodeID}, GetDate(), 0, tblForumHeading.ForumHeadingID, 1 
FROM tblForumHeading 
WHERE tblForumHeading.ForumHeadingID = 7 
AND NOT EXISTS 
( SELECT tblForum.ForumID 
FROM tblForum 
WHERE tblForum.CaseID = {CaseID}
AND tblForum.LinkForumID = 0 
AND tblForum.ForumHeadingID = tblForumHeading.ForumHeadingID );

-- Create Forum Entry 
INSERT tblForum ( CaseID, Header, Detail, UserCodeID, EventDate, LinkForumID, ForumHeadingID, InitialUserID ) 
SELECT {CaseID}, 'Case Closing Audit', ISNULL((SELECT dbo.udfGetWorksheetData({CaseID},214,'TextBox',10100,0)), ''), {UserCodeID}, GetDate(), F.ForumID, F.ForumHeadingID, {UserCodeID}
FROM tblForum F WHERE F.CaseID = {CaseID} AND F.ForumHeadingID = 7 AND F.LinkForumID = 0;
-- End forum update section