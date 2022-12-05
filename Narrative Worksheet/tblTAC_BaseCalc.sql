--Create Custom Table in Database

Create Table tblTAC_BaseCalc(
    PlanID INT IDENTITY(1,1) PRIMARY KEY, -- Auto incrementing primary key ID number 
    TruCode CHAR(3), -- Trustee Code
    BaseCalcDate DATE, -- The date the BaseCalc was created
    WorksheetID INT, -- The worksheet the baseCalc originated from
    CaseID INT, -- Foreign Key with tblCaseData
    SECTION INT, -- Section of worksheet variable that is updated throughout script (1 = Plan Payment 2 = Additional Amount 3 = Forgive Amount 4 = Stain Amount)
    tblRow INT, -- Row of the table 
    Amount VARCHAR(MAX), -- Amount
    Description VARCHAR(MAX), -- Description
    Periods VARCHAR(10), -- Periods for Plan Payments 
    PmtsPerMonth VARCHAR(10), -- Foreign Key - tblCasePayScheduleTypes -> CasePaySchedCodeID 
    EffectiveDate DATE, -- Effective Date for Plan Payments
    CONSTRAINT FK_BaseCaseID FOREIGN KEY (CaseID) REFERENCES tblCaseData(CaseID)); -- Establishes FK for CaseID 




