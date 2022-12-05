function wsOnLoad(){ 

  function cl(text){ console.log(text)}

  $('textarea').css('white-space' , 'pre-wrap').css('width', '100%');
  $('input[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to TextBox elements
  $('input[name*="CheckBox_"]').addClass("form-check-input"); // add bootstrap form-check-input class to CheckBox elements
  $('textarea[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to CommentBox elements


  //////////////////////////////////
  // Show Hide Collapse Sections
  //////////////////////////////////

   // Toggle Plan Documents
   $("#planDocumentsCollapse_title").on("click", function () {
      if ($(this)[0].innerText == 'Show Plan Documents')
      {
          $(this)[0].innerText = "Hide Plan Documents"
          $(this).removeClass("btn-info")
          $(this).addClass("btn-primary")
      } else {
          $(this)[0].innerText = "Show Plan Documents"
          $(this).removeClass("btn-primary")
          $(this).addClass("btn-info")

      }
      
      $("#planDocumentsCollapse").fadeToggle().toggleClass("collapse");
    }); 

    // Toggle payScheduleCollapse_title
    $("#payScheduleCollapse_title").on("click", function () {
      if ($(this)[0].innerText == 'Show Pay Schedules')
      {
          $(this)[0].innerText = "Hide Pay Schedules"
          $(this).removeClass("btn-info")
          $(this).addClass("btn-primary")
      } else {
          $(this)[0].innerText = "Show Pay Schedules"
          $(this).removeClass("btn-primary")
          $(this).addClass("btn-info")

      }
      $("#payScheduleCollapse").fadeToggle().toggleClass("collapse");
    }); 

    // Toggle taxdataCollapse_title
    $("#taxdataCollapse_title").on("click", function () {
      if ($(this)[0].innerText == 'Show Tax Return Documents and Return Data')
      {
          $(this)[0].innerText = "Hide Tax Return Documents and Return Data"
          $(this).removeClass("btn-info")
          $(this).addClass("btn-primary")
      } else {
          $(this)[0].innerText = "Show Tax Return Documents and Return Data"
          $(this).removeClass("btn-primary")
          $(this).addClass("btn-info")

      }
      $("#taxdataCollapse").fadeToggle().toggleClass("collapse");
    }); 



  //////////////////////////////////////
  // Table Cleanup Function
  //////////////////////////////////////

  // Cleanup table by hiding extra rows that do not contain data 
  $("[id^=table_template_]").each(function () {
      $(this)
      .find("tbody tr")
      .each(function (i) {
          var x = $(this)
          .find('input[name*="TextBox_"]')
          .filter(function () {
              return this.value.length > 0; // filter through TextBox values, returning lengths greater than zero
          }).length; // the total of all non zero length TextBox values in this row
          if (x == 0 && i > 0) {
          // if the total length of all TextBox values for this row is zero, and this row is not the first row, hide the row
          $(this).hide();
          } else {
          $(this).show();
          }
          $(this)
          .find('input[name*="TextBox_"]')
          .css("width", "100%")
          .css("text-align", "left"); // expand TextBox width to fill table cell
      });
  });

  /////////////////////////////////////
// Table Manipulation
/////////////////////////////////////


/////////////
// TODO: Add logic to set proper number of rows on load and pre-fill the data
// Pre-fill table rows on load based on hidden tableRows textbox 
///////////
$("#TextBox_222_900").each(function () {
  if ( $(this).val() > 1){
    console.log('need to add row')
    let x = $(this).val()
    for (let i = 1; i < x; i++)
    {
      let tableID = 'table_template_100'
      let lastRow =  $('#' + tableID).find("tbody tr:last")[0].children[0].firstElementChild.id
      let buttonID =  Number(lastRow.slice(-3))
      addNewRow(buttonID, tableID)
    }
  }
})
$("#TextBox_222_901").each(function () {
  if ( $(this).val() > 1){
    console.log('need to add row')
    let x = $(this).val()
    for (let i = 1; i < x; i++)
    {
      let tableID = 'table_template_400'
      let lastRow =  $('#' + tableID).find("tbody tr:last")[0].children[0].firstElementChild.id
      let buttonID =  Number(lastRow.slice(-3))
      addNewRow(buttonID, tableID)
    }
  }
})
$("#TextBox_222_902").each(function () {
  if ( $(this).val() > 1){
    console.log('need to add row')
    let x = $(this).val()
    for (let i = 1; i < x; i++)
    {
      let tableID = 'table_template_700'
      let lastRow =  $('#' + tableID).find("tbody tr:last")[0].children[0].firstElementChild.id
      let buttonID =  Number(lastRow.slice(-3))
      addNewRow(buttonID, tableID)
    }
  }
})


///////////////////////////
// ADD / DELETE ROW
//////////////////////////
// To add a row to the table, we are going to take the existing table
// by it's ID, we are then going to get the ID of the first textbox in the 
// last row. That will be our basis for the numbers for the next row
// Then call addNewRow() which will use a generator function to add the row
// Then we will update the hidden textbox with number of rows. 
$("[id^=addrow_]").click(function () {
  let tableID = $(this).closest("table")[0].id

  let lastRow =  $('#' + tableID).find("tbody tr:last")[0].children[0].firstElementChild.id
  let buttonID =  Number(lastRow.slice(-3))
  addNewRow(buttonID, tableID)

  // Update this tables hidden textbox that indicates the number of rows
  // This will be used when reloading worksheet to set the proper number of rows
  // on the screen
  // this is achieved by setting the value of the textbox to be the indesx number of the last row in the
  // body section of the table.
  // TextBox997
  // Check which table is being adjusted and then correct the table row count textbox
  let indexLastRow =  $('#' + tableID).find("tbody tr:last")
  var row_index = $(indexLastRow).index();
  let regex1 = /^table_template_1\d\d/
  let regex2 = /^table_template_4\d\d/
  let regex3 = /^table_template_7\d\d/
  if ( regex1.test( tableID ) ){ 
    $('#TextBox_222_900').val(row_index + 1) 
    triggerEvent(document.querySelector('#TextBox_222_900'), 'change')
  }
  if ( regex2.test( tableID ) ){ 
    $('#TextBox_222_901').val(row_index + 1) 
    triggerEvent(document.querySelector('#TextBox_222_901'), 'change')

  }
  if ( regex3.test( tableID ) ){ 
    $('#TextBox_222_902').val(row_index + 1) 
    triggerEvent(document.querySelector('#TextBox_222_902'), 'change')

  }



})

// Hide table rows and clear all input fields in the row when the "Delete" button is clicked.
$("[id^=delrow_]").click(function (event) {

  let tableID = $(this).closest("table")[0].id
  let lastRow =  $('#' + tableID).find("tbody tr:last")

  // buttons with class .tac_btnDel when clicked
  var row_index = $(lastRow).index(); // this row index value
  if (row_index > 0) {
    // Check which table is being adjusted and then correct the table row count textbox
    let regex1 = /^table_template_1\d\d/
    let regex2 = /^table_template_4\d\d/
    let regex3 = /^table_template_7\d\d/
    if ( regex1.test( tableID ) ){  
      let current = $('#TextBox_222_900').val()
     $('#TextBox_222_900').val(current-1) 
    triggerEvent(document.querySelector('#TextBox_222_900'), 'change')
    }
    if ( regex2.test( tableID ) ){  
      let current = $('#TextBox_222_901').val()
     $('#TextBox_222_901').val(current-1) 
    triggerEvent(document.querySelector('#TextBox_222_901'), 'change')

    }
    if ( regex3.test( tableID ) ){  
      let current = $('#TextBox_222_902').val()
     $('#TextBox_222_902').val(current-1) 
    triggerEvent(document.querySelector('#TextBox_222_902'), 'change')

    }
    // second row and on
    $(lastRow).remove();
  }


});



  // On Change

  // When an input in base calc changes, run baseCalc() function to update calculations 
// $("[id^=TextBox_222_7],[id^=TextBox_222_6],[id^=TextBox_222_5]" ).on("change", function () {
//     baseCalc();
//   })

// //   On First Load

//   // on load of the worksheet, we want to loop through all inputs and set the initial value to 0. 
//   $("[id^=TextBox_222_7],[id^=TextBox_222_6],[id^=TextBox_222_5]" ).each(function () {
//     if ($(this).find('input[name*="TextBox_"]').val() = '') {
//       $(this).find('input[name*="TextBox_"]').val(0)
//     }

//   })

$("#calculateButton").on("click", function(){
  baseCalc();
});

$("#generateButton").on("click", function(){
  cl('generate button clicked')
  generateNote();
})

////////////////////////
// End of WS On Load
///////////////////////
}


/////////////////////////////
// Calculations 
/////////////////////////////
function baseCalc(){
  function cl(text){
      console.log(text)
  }

  // get the object 
  let baseCalcValues = generateObject();

// Call the Caluation Functions 
updateSubtotal();
updatePlanPaymentTotal();
updateMonths();
updateAdditionalPaymentTotal();
updateForgivePaymentTotal();
updateBaseTotal();


// Update Subtotals function
function updateSubtotal() {
  // cl('updateSuttotal() running')
  let lengthOfAmounts = Object.keys(baseCalcValues.planPayments.amounts).length
  //cl(lengthOfAmounts)
  for (let i = 0; i < lengthOfAmounts; i++) {
      let amounts = Number(baseCalcValues.planPayments.amounts[i])
      let periods = Number(baseCalcValues.planPayments.periods[i])
      let subtotalElement = document.querySelector('#subtotal10' + [i])
      subtotalElement.innerText = (amounts*periods).toLocaleString('en-US', {style: 'currency', currency: 'USD'});
  }
}

function updatePlanPaymentTotal() {
  let lengthOfAmounts = Object.keys(baseCalcValues.planPayments.amounts).length
  let total = 0;
  let totalElement = document.querySelector('#planPaymentsTotal')
  for (let i = 0; i < lengthOfAmounts; i++){
      let subtotalValue = remove_financial(document.querySelector('#subtotal10' + [i]).innerText)
      total += subtotalValue
  }
  totalElement.innerText = total.toLocaleString('en-US', {style: 'currency', currency: 'USD'})
}


function updateMonths(){
  let lengthOfAmounts = Object.keys(baseCalcValues.planPayments.amounts).length
  for (let i = 0; i < lengthOfAmounts; i++){
      let periods = Number(baseCalcValues.planPayments.periods[i])
      let months = Number(baseCalcValues.planPayments.perMonth[i])
      let monthsElement = document.querySelectorAll('#months10' + [i])[0]
      let monthsCalc = Math.floor(periods/months) || 0;
      monthsElement.innerText = monthsCalc;
  }
  }

  // this function will add the Additional Payment amounts and update that sections total. 
  function updateAdditionalPaymentTotal() {
    let lengthOfAmounts = Object.keys(baseCalcValues.additionalPayments.amounts).length
    let total = 0;
    let totalElement = document.querySelector('#additionalPaymentsTotal')
    for (let i = 0; i < lengthOfAmounts; i++){
      let amounts = Number(baseCalcValues.additionalPayments.amounts[i])
      total += amounts;
    }

    totalElement.innerText = total.toLocaleString('en-US', {style: 'currency', currency: 'USD'})

  }

  // this function will add the values in the Forgive Amounts and update that sections total
  function updateForgivePaymentTotal() {
    let lengthOfAmounts = Object.keys(baseCalcValues.forgiveAmounts.amounts).length
    let total = 0;
    let totalElement = document.querySelector('#forgiveAmountsTotal')
    for (let i = 0; i < lengthOfAmounts; i++){
      let amounts = Number(baseCalcValues.forgiveAmounts.amounts[i])
      total += amounts;
    }

    totalElement.innerText = total.toLocaleString('en-US', {style: 'currency', currency: 'USD'})

  }

  // This function will update the blue Base Total amount. Will loop through all amounts in the object and calculate separate to a grand total
  // plan Payments + additional Payments - Forgive Amounts = Base Total 
  function updateBaseTotal() {

    let lengthOfPlanPaymentAmounts = Object.keys(baseCalcValues.planPayments.amounts).length
    let lengthOfAdditionalAmounts = Object.keys(baseCalcValues.additionalPayments.amounts).length
    let lengthOfForgiveAmounts = Object.keys(baseCalcValues.forgiveAmounts.amounts).length

    let total = 0;
    let baseTotalElement = document.querySelector('#baseTotalSpan')
    for (let i = 0; i < lengthOfPlanPaymentAmounts; i++){
        let subtotalValue = remove_financial(document.querySelector('#subtotal10' + [i]).innerText)
        total += subtotalValue
    }
    for (let i = 0; i < lengthOfAdditionalAmounts; i++){
      let amounts = Number(baseCalcValues.additionalPayments.amounts[i])
      total += amounts;
    }

    for (let i = 0; i < lengthOfForgiveAmounts; i++){
      let amounts = Number(baseCalcValues.forgiveAmounts.amounts[i])
      total -= amounts;
    }

    baseTotalElement.innerText = total.toLocaleString('en-US', {style: 'currency', currency: 'USD'})
  }



}

/////////////////////////////
// Generate Forum Note
////////////////////////////
function generateNote() {
  // first call the calculate to make sure all values are up to date and calculated
  baseCalc();

  // This function will look at the table and attempt to write out the text area. 
  // forum note id: TextBox_224_10224
  // Example: innerHTML: "$100 x 18 Months at 2 Payments per month = $3,600 \nAdditional Amount of $1,000 one-time payment\nForgive amount of $500"
  //console.log($("#TextBox_224_10224"))
  let basePayments = generateObject();

  let lengthOfPlanPaymentAmounts = Object.keys(basePayments.planPayments.amounts).length
   let lengthOfAdditionalAmounts = Object.keys(basePayments.additionalPayments.amounts).length
   let lengthOfForgiveAmounts = Object.keys(basePayments.forgiveAmounts.amounts).length

  let note = ''
  let forumNoteElement = document.querySelector('#TextBox_224_10224')
  for (let i = 0; i < lengthOfPlanPaymentAmounts; i++){
    let amounts = Number(basePayments.planPayments.amounts[i])
    let periods = Number(basePayments.planPayments.periods[i])
    let subtotalElement = document.querySelector('#subtotal10' + [i])
    note += `$${amounts} x ${periods} = ${subtotalElement.innerHTML}\n`
  }
  for (let i = 0; i < lengthOfAdditionalAmounts; i++){
    let amounts = Number(basePayments.additionalPayments.amounts[i])
    let description = basePayments.additionalPayments.description[i]
    note += `+ Additional $${amounts} - ${description} \n`
  }
  for (let i = 0; i < lengthOfForgiveAmounts; i++){
    let amounts = Number(basePayments.forgiveAmounts.amounts[i])
    let description = basePayments.forgiveAmounts.description[i]
    note += `- Forgive $${amounts} - ${description} \n`
  }
  let baseTotalElement = document.querySelector('#baseTotalSpan')
  note += `Base Total: ${baseTotalElement.innerText}`


  console.log(`note after function`)
  console.log(note)
  forumNoteElement.innerHTML = note;

  triggerEvent(forumNoteElement, 'change')
  //console.log(basePayments)

}


//  Get the values that will be used to perform calculations and update forum note. 
function generateObject() {
   
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
      'amounts': {

        },
      'description': {

      }
    },
    'forgiveAmounts': {
        'amounts': {

        },
        'description': {
        
        }
    }
}

///////////////////
// Plan Payments
///////////////////

// Loop through Plan Payments amounts and add values to the newCalcObject amounts key
let planPaymentAmounts = document.querySelectorAll("[id^='TextBox_222_1']")
for (let i = 0; i < planPaymentAmounts.length; i++) {
newCalcOBject.planPayments.amounts[i] = planPaymentAmounts[i].value;
}
// loop through the plan payment periods and add values to the new object periods key
let planPaymentPeriods = document.querySelectorAll("[id^='TextBox_222_2']")
for (let i = 0; i < planPaymentPeriods.length; i++) {
newCalcOBject.planPayments.periods[i] = planPaymentPeriods[i].value;
}
// loop through the plan payment per month and add values to the new object per month key
let planPaymentPerMonth = document.querySelectorAll("[id^='TextBox_222_3']")
for (let i = 0; i < planPaymentPerMonth.length; i++) {
newCalcOBject.planPayments.perMonth[i] = planPaymentPerMonth[i].value;
}

//////////////////////////
// Additional Payments
/////////////////////////
let additionalAmounts = document.querySelectorAll("[id^='TextBox_222_4']")
let additionalAmountsDescription = document.querySelectorAll("[id^='TextBox_222_5']")
for (let i = 0; i < additionalAmounts.length; i++) {
newCalcOBject.additionalPayments.amounts[i] = additionalAmounts[i].value;
newCalcOBject.additionalPayments.description[i] = additionalAmountsDescription[i].value;
}

/////////////////////////
// Forgive Amounts
/////////////////////////
let forgiveAmounts = document.querySelectorAll("[id^='TextBox_222_7']")
let forgiveAmountsDescription = document.querySelectorAll("[id^='TextBox_222_8']")
for (let i = 0; i < forgiveAmounts.length; i++) {
newCalcOBject.forgiveAmounts.amounts[i] = forgiveAmounts[i].value;
newCalcOBject.forgiveAmounts.description[i] = forgiveAmountsDescription[i].value;
}

//  console.log(newCalcOBject);
// 
// Object Output: Each row will line up by ID. We will be calculating based on object index. Amount.0 * periods.0 
// amounts: {0: '100', 1: '200'}
// perMonth: {0: '2', 1: '4'}
// periods: {0: '36', 1: '72'}
// */

return newCalcOBject;
}



// function getProgramResults(urltofetch, divtopopulate, caseid, pid)
// {

//     $.ajax({
//         type: "POST",
//         url: urltofetch,
//         data: 'cid=' + caseid + '&pid=' + pid,
//         dataType: "html",
//         success: function (result) {

//             if (divtopopulate != '') {
//                 populateDiv(result, divtopopulate)
//             } 

//             ajaxOnSuccess(result)

//         }		
//   });

// }

function populateDiv(result, divtopopulate) {
    $('#' + divtopopulate).html(result); 
}

//////////////////////
// Formatting
//////////////////////
function clean_numbers() {
  //Convert to plain numbers for calculations
  $(".tac_money")
    .find("input")
    .each(function () {
      // convert TextBox value to currency
      $(this).each(function () {
        if (
          !isNaN($(this).val().toString().replace(/[$,]+/g, "")) &&
          $(this).val() != ""
        ) {
          // remove '$' and ',' check if the value is a number
          $(this).val(remove_financial($(this).val())); // if the value is a number, convert it to currency format
        }
      });
    });

  }

    //remove currency
    function remove_financial(x) {
      var dollarCurrenyValue = x;
      return Number(dollarCurrenyValue.replace(/[^0-9.-]+/g, ""));
    }

    function add_format() {
      $(".tac_money").find("input").each(function () {
          // convert TextBox value to currency
          $(this).each(function () {
            if (
              !isNaN($(this).val().toString().replace(/[$,]+/g, "")) &&
              $(this).val() != ""
            ) {
              // remove '$' and ',' check if the value is a number
              $(this).val(tac_financial($(this).val())); // if the value is a number, convert it to currency format
            }
          });
        });

      }

        //currency format
  function tac_financial(x) {
    var num = Number(x.toString().replace(/[$,]+/g, ""));
    return num.toLocaleString("en-US", { style: "currency", currency: "USD" });
  }


// called when an event needs triggered so that worksheet will recognize a Change has occurred and update tblCaseWorksheetData 
function triggerEvent (element, eventName) {
  var event = new Event(eventName);
  element.dispatchEvent(event);
}


function addNewRow(buttonID, tableID) {
  console.log('running addNewRow')
const GeneratorFunction = (function* () {}).constructor;
const g = new GeneratorFunction('a', 'yield a + 1');
const iterator = g(buttonID);
let nextRowNumber = iterator.next().value;

let regex1 = /^table_template_1\d\d/
let regex2 = /^table_template_4\d\d/
let regex3 = /^table_template_7\d\d/
  
          let planPaymentTemplate = `
          <tr>
          <td class="tac_money"><input class="form-control wsTextBoxClass" type="Text" name="TextBox_222_${nextRowNumber}" id="TextBox_222_${nextRowNumber}" onchange="update('TextBox_222_${nextRowNumber}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
          <td><input class="form-control" type="Text" maxlength="200" id="TextBox_222_${nextRowNumber+100}" onchange="update('TextBox_222_${nextRowNumber+1}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
          <td><input class="form-control" type="Text" id="TextBox_222_${nextRowNumber+200}" onchange="update('TextBox_222_${nextRowNumber+2}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
          <td><span id="subtotal${nextRowNumber}"></span></td>
          <td><span id="months${nextRowNumber}"></span></td>
          </tr>
      ` 

        
  
      let additionalPaymentsTemplate = `
  <tr>
  <td class="tac_money"><input class="form-control wsTextBoxClass" type="Text" name="TextBox_222_${nextRowNumber}" id="TextBox_222_${nextRowNumber}" onchange="update('TextBox_222_${nextRowNumber}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
  <td colspan="2"><input class="form-control" type="Text" maxlength="200" id="TextBox_222_${nextRowNumber+100}" onchange="update('TextBox_222_${nextRowNumber+100}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
  </tr>
  `
  
  
  let forgiveAmountsTemplate = `
  <tr>
  <td class="tac_money"><input class="form-control wsTextBoxClass" type="Text" name="TextBox_222_${nextRowNumber}" id="TextBox_222_${nextRowNumber}" onchange="update('TextBox_222_${nextRowNumber}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
  <td colspan="2"><input class="form-control" type="Text" maxlength="200" id="TextBox_222_${nextRowNumber+100}" onchange="update('TextBox_222_${nextRowNumber+100}',222,'','','*!wstype!*','|:CaseID:|',2,'False','0','tblCaseData')"></td>
  </tr>
  `
  if (regex1.test(tableID)) {$('#' + tableID + ' tbody tr:last').after(planPaymentTemplate)}
  if (regex2.test(tableID)) {$('#' + tableID + ' tbody tr:last').after(additionalPaymentsTemplate)}
  if (regex3.test(tableID)) {$('#' + tableID + ' tbody tr:last').after(forgiveAmountsTemplate)}
      
}