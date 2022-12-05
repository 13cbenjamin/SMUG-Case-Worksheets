## Notes on this project
### Summary
This project is to create a standalone case worksheet for calculating bases. 
All staff will use this when calculating a base amount and then update the forum
The calculator will need to support a seemlingly unlimited number of inputs to calculate
as some cases have a large amount of payments. 


### Worksheet Table Layout for Calculator

#### Plan Payments
The plan payments has 3 inputs and 2 calculated columns. 
______________________________________________________________________________
| TextBox222_100 | TextBox222_200 | TextBox222_300 | SubTotal100 | Months100 |
| TextBox222_101 | TextBox222_201 | TextBox222_301 | SubTotal101 | Months101 |// generated with generator function 
|____________________________________________________________________________|

#### Additional Payments
___________________________________
| TextBox222_400 | TextBox222_500 |
| TextBox222_401 | TextBox222_501 | // generated with generator function
__________________________________|

#### Forgive Amounts
___________________________________
| TextBox222_700 | TextBox222_800 |
| TextBox222_701 | TextBox222_801 | // generated with generator function
__________________________________|


### Generator Function
To acheive the ability to add many text boxes, a generator function is used which will
create an autoincrementing number based on the ID number of the first textbox
in the last row of the table. Currently supports up to 100 without causing an issue
```javascript
function addNewRow(buttonID, tableID) {
  const GeneratorFunction = (function* () {}).constructor;
  const g = new GeneratorFunction('a', 'yield a + 1');
  const iterator = g(buttonID);
  let nextRowNumber = iterator.next().value;
          let template = 
          `<tr>
          <td class="tac_money"><input class="form-control wsTextBoxClass" type="Text" name="TextBox_222_${nextRowNumber}" id="TextBox_222_${nextRowNumber}" onchange="update('TextBox_222_${nextRowNumber}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
          <td><input class="form-control" type="Text" maxlength="200" id="TextBox_222_${nextRowNumber+100}" onchange="update('TextBox_222_${nextRowNumber+100}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
          <td><input class="form-control" type="Text" id="TextBox_222_${nextRowNumber+200}" onchange="update('TextBox_222_${nextRowNumber+200}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
          <td><span id="subtotal${nextRowNumber}"></span></td>
          <td><span id="months${nextRowNumber}"></span></td>
          </tr>`
      $('#' + tableID + ' tbody tr:last').after(template)
}
```

## Worksheet Math
The worksheet math is being achieved by using a generated object that is created each time the calculation is ran. 
This function will be used to loop through all textboxes and then add their value to the object. 

```javascript
  let newCalcOBject = {
        'planPayments':{
            'amounts': {
            },
            'periods': {
            },
            'perMonth': {
            }
        },
        'additionalPayments': {
            amounts: {
            }
        },
        'forgiveAmounts': {
            amounts: {
            }
        }
    }
 let planPaymentAmounts = document.querySelectorAll("[id^='TextBox_222_1']")
 for (let i = 0; i < planPaymentAmounts.length; i++) {
    //console.log(planPaymentInput[i])
    newCalcOBject.planPayments.amounts[i] = planPaymentAmounts[i].value;
 }

 let planPaymentPeriods = document.querySelectorAll("[id^='TextBox_222_2']")
 for (let i = 0; i < planPaymentPeriods.length; i++) {
    //console.log(planPaymentInput[i])
    newCalcOBject.planPayments.periods[i] = planPaymentPeriods[i].value;
 }

 let planPaymentPerMonth = document.querySelectorAll("[id^='TextBox_222_3']")
 for (let i = 0; i < planPaymentPerMonth.length; i++) {
    //console.log(planPaymentInput[i])
    newCalcOBject.planPayments.perMonth[i] = planPaymentPerMonth[i].value;
 }
 ```

 ## Current Status
 8/26/2022
 The Plan Payments Section is mostly complete. The values are calculating when you click calculate. The Subtotal and Months are calculating for all added rows. The total is now updating. 
 I've written loop functions to loop through all inputs and add to an object. Then using for loops I'm looping through the values and performing calculations and updating fields.
 Tables in 222 were updated so that planpayments are 100, 200, and 300. ID for first box in each column respectively.  


8/29/2022
- Added templates for additionalPayments and forgiveAmounts. 
- Using RegEx to determine which table is being added and then inserting correct template for that table. 
- Laid out functions but haven't filled them in for calculating amounts. 

8/30/2022
- Not going to be able to programatically load data from the worksheet when textboxes are created dynamically - not possible. 
- Switching worksheet to have 40 plan payments, 100 additional payments, and 20 forgive amounts
- Current add row is working but delete row is not. DelRow should remove contents and then hide the last visible row in tbody. 
- Calculate is not working for additional tables, or months. just subtotals at the moment. 


9/6/2022
- Fixed calculation for all fields to calculate properly 
- Fixed forum note to not create lines for $0 amounts
- Moved worksheet information from top of calculator 222 section to top of case info 223 section
- Added row to head of plan payment table to further explain the pay schedule values
- Updated plan payment column headers to match the table explaining schedule types

9/13/2022
- Added Effective Date column 
- Added Schedule Type drop down, which updates closest text box in same '<td></td>'
- Added Stain Case collapsible section
- Stain case section will take user entered delinquency, and user entered monthly payment, to calculate the number of months it will take to make the payment to cure delinquency
- Updated generate note to include effective date of the payment based on new field
- updated generate note to include delinquency total and stain payments. 

10/26/2022
- Added Prev Base Calcs section which pulls from tblTAC_BaseCalc to render and display previous calculated information. 
- Added Prev Calcs button to case information and corresponding section 

