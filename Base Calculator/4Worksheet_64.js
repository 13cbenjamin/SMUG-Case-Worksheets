function wsOnLoad() {
  // Bootstrap setup
  $("textarea").css("white-space", "pre-wrap").css("width", "100%");
  $('input[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to TextBox elements
  $('input[name*="CheckBox_"]').addClass("form-check-input"); // add bootstrap form-check-input class to CheckBox elements
  $('textarea[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to CommentBox elements
  $('span[id^="months1"]').css("align-items", "center");


  // Set effective date values to input  type date
  $("[id^=TextBox_222_6]").each(function () {
    $(this).attr({type:"date"})
  })

  // Load Pay Schedules Button
  $("#loadPayScheduleButton").on('click', function(){
    loadPaySchedules();
  })

  $('input[name*="TextBox_222_"]').on('change', function(){
    baseCalc();
  })

  // Select drop down magic
  // set the value of the closest textbox based on the dropdown selection 
  $("[id^=select1]").on('change', function() {
    let selection = $(this).val()
   let pmtsInput =  $(this).closest("td").find("input")
   let inputName = pmtsInput[0].id
   let updateInput = document.getElementById(inputName)

   switch(selection) {
    case '1': 
      updateInput.value = '1'
      triggerEvent(updateInput, 'change')
      break;
    case '2': 
      updateInput.value = '2'
      triggerEvent(updateInput, 'change')
      break;
    case '3':
      updateInput.value = '2.166'
      triggerEvent(updateInput, 'change')
      break;
    case '4':
      updateInput.value = '4.33'
      triggerEvent(updateInput, 'change')
      break;
    case '5':
      updateInput.value = '0.166'
      triggerEvent(updateInput, 'change')
      break;
    case '6':
      updateInput.value = '0.33'
      triggerEvent(updateInput, 'change')
      break;
    case '7':
      updateInput.value = '0.0833'
      triggerEvent(updateInput, 'change')
      break;
    default:
      updateInput.value = ''
      triggerEvent(updateInput, 'change')
      break;

   }

  })

  $("[id^=TextBox_222_3]").each(function() {
    let pmtsInput =  $(this).closest("td").find("select")
    let selectDropID = pmtsInput[0].id
    let selection = this.value
    switch(selection) {
      case '1': 
      $("#" + selectDropID).val("1").change();
        break;
      case '2': 
      $("#" + selectDropID).val("2").change();
        break;
      case '2.166':
      $("#" + selectDropID).val("3").change();
        break;
      case '4.33':
      $("#" + selectDropID).val("4").change();
        break;
      case '0.166':
        $("#" + selectDropID).val("5").change();
        break;
      case '0.33':
        $("#" + selectDropID).val("6").change();
        break;
      case '0.0833':
        $("#" + selectDropID).val("7").change();
        break;
      default:
        $("#" + selectDropID).val("0").change();
        break;
     }
  })


  //////////////////////////////////
  // Show Hide Collapse Sections
  //////////////////////////////////

  // Stain Cases
  $("#stainCollapseButton").on("click", function () {
    $("#stainCollapse").fadeToggle().toggleClass("collapse");
  })


  // Toggle Plan Documents
  $("#planDocumentsCollapse_title").on("click", function () {
    if ($(this)[0].innerText == "Show Plan Documents") {
      $(this)[0].innerText = "Hide Plan Documents";
      $(this).removeClass("btn-info");
      $(this).addClass("btn-primary");
    } else {
      $(this)[0].innerText = "Show Plan Documents";
      $(this).removeClass("btn-primary");
      $(this).addClass("btn-info");
    }

    $("#planDocumentsCollapse").fadeToggle().toggleClass("collapse");
  });

  // Toggle payScheduleCollapse_title
  $("#payScheduleCollapse_title").on("click", function () {
    if ($(this)[0].innerText == "Show Pay Schedules") {
      $(this)[0].innerText = "Hide Pay Schedules";
      $(this).removeClass("btn-info");
      $(this).addClass("btn-primary");
    } else {
      $(this)[0].innerText = "Show Pay Schedules";
      $(this).removeClass("btn-primary");
      $(this).addClass("btn-info");
    }
    $("#payScheduleCollapse").fadeToggle().toggleClass("collapse");
  });

  // Toggle taxdataCollapse_title
  $("#taxdataCollapse_title").on("click", function () {
    if ($(this)[0].innerText == "Show Tax Docs & Data") {
      $(this)[0].innerText = "Hide Show Tax Docs & Data";
      $(this).removeClass("btn-info");
      $(this).addClass("btn-primary");
    } else {
      $(this)[0].innerText = "Show Tax Docs & Data";
      $(this).removeClass("btn-primary");
      $(this).addClass("btn-info");
    }
    $("#taxdataCollapse").fadeToggle().toggleClass("collapse");
  });


  // Toggle prevBaseCalcsCollapse_title
  $("#prevBaseCalcsCollapse_title").on("click", function () {
    if ($(this)[0].innerText == "Show Prev Calcs") {
      $(this)[0].innerText = "Hide Prev Calcs";
      $(this).removeClass("btn-info");
      $(this).addClass("btn-primary");
    } else {
      $(this)[0].innerText = "Show Prev Calcs";
      $(this).removeClass("btn-primary");
      $(this).addClass("btn-info");
    }
    $("#previous_baseCalcs_collapse").fadeToggle().toggleClass("collapse");
  });

  //////////////////////////////////////
  // Table Cleanup Function
  //////////////////////////////////////

  // Cleanup table by hiding extra rows that do not contain data on initial load of worksheet
  tableCleanup();

  /////////////////////////////////////
  // Table Manipulation
  /////////////////////////////////////

  ///////////////////////////
  // ADD / DELETE ROW
  //////////////////////////
  // To add a row to the table, we are going to take the existing table
  // by it's ID, we are then going to get the ID of the first textbox in the
  // last row. That will be our basis for the numbers for the next row
  // Then call addNewRow() which will use a generator function to add the row
  // Then we will update the hidden textbox with number of rows.
  $("[id^=addrow_]").click(function () {
    $(this)
      .closest("table")
      .find("tbody tr:hidden")
      .first()
      .show()
      .find('input[name*="TextBox_"]')
      .first()
      .focus(); // show the first hidden row when "Add Row" button clicked, set the focus to the first input on the shown row

  });

  // Hide table rows and clear all input fields in the row when the "Delete" button is clicked. An event is triggered to save this information and the baseCalc() function is ran
  $("[id^=delrow_]").click(function () {
    let tableID = $(this).closest("table")[0].id;
    let lastRow = $("#" + tableID).find("tbody tr:visible:last");

    // Clear values and trigger event
    lastRow.find('input[name*="TextBox_"]').each(function () {
      let element = document.getElementById(this.id);
      $(this).val(""); // clear the contents of each TextBox
      triggerEvent(element, "change"); // save the change to the DB by triggering an event
    });

    // if this is not first row then hide the row
    var row_index = $(lastRow).index(); // this row index value
    if (row_index > 0) {
      // second row and on
      $(lastRow).hide();
    }
    baseCalc(); // perform a calc now that a row has been deleted to update totals
  });

  // When green Calculate Button is clicked, run the baseCalc() function
  $("#calculateButton").on("click", function () {
    baseCalc();
  });

  $("#generateButton").on("click", function () {
    generateNote();
  });

  ////////////////////////
  // End of WS On Load
  ///////////////////////
}

/////////////////////////////
// Calculations
/////////////////////////////
function baseCalc() {
  // get the object which will pull new values from the worksheet
  let baseCalcValues = generateObject();
  // console.log(baseCalcValues)
  // Call the Calcuation Functions in order
  updateSubtotal();
  updatePlanPaymentTotal();
  updateMonths();
  updateAdditionalPaymentTotal();
  updateForgivePaymentTotal();
  updateBaseTotal();
  updateStainValues();

  // Update Subtotals function for plan payment section
  function updateSubtotal() {
    let lengthOfAmounts = Object.keys(
      baseCalcValues.planPayments.amounts
    ).length;
    for (let i = 0; i < lengthOfAmounts; i++) {
      let amounts = Number(baseCalcValues.planPayments.amounts[i]);
      let periods = Number(baseCalcValues.planPayments.periods[i]);
      // The first 10 values, the selector has a 0
      if (i < 10) {
        let subtotalElement = document.querySelector("#subtotal10" + [i]);
        subtotalElement.innerText = (amounts * periods).toLocaleString(
          "en-US",
          { style: "currency", currency: "USD" }
        );
      } else {
        // double digits
        let subtotalElement = document.querySelector("#subtotal1" + [i]);
        subtotalElement.innerText = (amounts * periods).toLocaleString(
          "en-US",
          { style: "currency", currency: "USD" }
        );
      }
    }
  }
  // Update total in footer of plan payment total
  function updatePlanPaymentTotal() {
    let lengthOfAmounts = Object.keys(
      baseCalcValues.planPayments.amounts
    ).length;
    let total = 0;
    let totalElement = document.querySelector("#planPaymentsTotal");
    for (let i = 0; i < lengthOfAmounts; i++) {
      // The first 10 values, the selector has a 0
      if (i < 10) {
        let subtotalValue = remove_financial(
          document.querySelector("#subtotal10" + [i]).innerText
        );
        total += subtotalValue;
      } else {
        let subtotalValue = remove_financial(
          document.querySelector("#subtotal1" + [i]).innerText
        );
        total += subtotalValue;
      }
    }
    totalElement.innerText = total.toLocaleString("en-US", {
      style: "currency",
      currency: "USD",
    });
  }
  // update plan payment months
  function updateMonths() {
    let lengthOfAmounts = Object.keys(
      baseCalcValues.planPayments.amounts
    ).length;
    for (let i = 0; i < lengthOfAmounts; i++) {
      let periods = Number(baseCalcValues.planPayments.periods[i]);
      let months = Number(baseCalcValues.planPayments.perMonth[i]);
      // The first 10 values, the selector has a 0
      if (i < 10) {
        let monthsElement = document.querySelectorAll("#months10" + [i])[0];
        let monthsCalc = Math.floor(periods / months) || 0;
         var d = new Date(baseCalcValues.planPayments.effectiveDate[i]);
        let approxEndDate = new Date(d.setMonth(d.getMonth() + monthsCalc))
        monthsElement.setAttribute('title', approxEndDate.toLocaleDateString());
        monthsElement.innerText = `${monthsCalc.toString()} \n~${approxEndDate.toLocaleDateString()}`;

      } else {
        let monthsElement = document.querySelectorAll("#months1" + [i])[0];
        let monthsCalc = Math.floor(periods / months) || 0;
        var d = new Date(baseCalcValues.planPayments.effectiveDate[i]);
        let approxEndDate = new Date(d.setMonth(d.getMonth() + monthsCalc))
        monthsElement.setAttribute('title', approxEndDate.toLocaleDateString());
        monthsElement.innerText = `${monthsCalc.toString()} \n~${approxEndDate.toLocaleDateString()}`;

      }
    }
  }


  // Update Stain Payment Calculations
  function updateStainValues(){

    let delinquencyAmount = remove_financial(document.getElementById('TextBox_222_900').value)


      let stainMonths = document.getElementById('months905')
      let stainTotal = document.getElementById('stainMonthsTotal')
      let stainPaymentTotal = document.getElementById('stainTotalPaid')

      let amounts = Number(baseCalcValues.stainPayments.amounts[0])
     
      let months = parseFloat(delinquencyAmount / amounts).toFixed(2) || 0;

    stainMonths.innerText = months;
    stainTotal.innerText = months;
    stainPaymentTotal.innerText = (amounts * months).toLocaleString("en-US", {
      style: "currency",
      currency: "USD",
    });

}


  // this function will add the Additional Payment amounts and update that sections total.
  function updateAdditionalPaymentTotal() {
    let lengthOfAmounts = Object.keys(
      baseCalcValues.additionalPayments.amounts
    ).length;
    let total = 0;
    let totalElement = document.querySelector("#additionalPaymentsTotal");
    for (let i = 0; i < lengthOfAmounts; i++) {
      let amounts = Number(baseCalcValues.additionalPayments.amounts[i]);
      total += amounts;
    }
// set the total value as currency string 
    totalElement.innerText = total.toLocaleString("en-US", {
      style: "currency",
      currency: "USD",
    });
  }

  // this function will add the values in the Forgive Amounts and update that sections total
  function updateForgivePaymentTotal() {
    let lengthOfAmounts = Object.keys(
      baseCalcValues.forgiveAmounts.amounts
    ).length;
    let total = 0;
    let totalElement = document.querySelector("#forgiveAmountsTotal");
    for (let i = 0; i < lengthOfAmounts; i++) {
      let amounts = Number(baseCalcValues.forgiveAmounts.amounts[i]);
      total += amounts;
    }

    totalElement.innerText = total.toLocaleString("en-US", {
      style: "currency",
      currency: "USD",
    });
  }

  // This function will update the blue Base Total amount. Will loop through all amounts in the object and calculate separate to a grand total
  // plan Payments + additional Payments - Forgive Amounts = Base Total
  function updateBaseTotal() {
    let lengthOfPlanPaymentAmounts = Object.keys(
      baseCalcValues.planPayments.amounts
    ).length;
    let lengthOfAdditionalAmounts = Object.keys(
      baseCalcValues.additionalPayments.amounts
    ).length;
    let lengthOfForgiveAmounts = Object.keys(
      baseCalcValues.forgiveAmounts.amounts
    ).length;

    let total = 0;
    let baseTotalElement = document.querySelector("#baseTotalSpan");
    for (let i = 0; i < lengthOfPlanPaymentAmounts; i++) {
      // The first 10 values, the selector has a 0
      if (i < 10) {
        let subtotalValue = remove_financial(
          document.querySelector("#subtotal10" + [i]).innerText
        );
        total += subtotalValue;
      } else {
        let subtotalValue = remove_financial(
          document.querySelector("#subtotal1" + [i]).innerText
        );
        total += subtotalValue;
      }
    }
    for (let i = 0; i < lengthOfAdditionalAmounts; i++) {
      let amounts = Number(baseCalcValues.additionalPayments.amounts[i]);
      total += amounts;
    }

    for (let i = 0; i < lengthOfForgiveAmounts; i++) {
      let amounts = Number(baseCalcValues.forgiveAmounts.amounts[i]);
      total -= amounts;
    }

    let delinquencyAmount = document.getElementById('TextBox_222_900').value
    if (remove_financial(delinquencyAmount) > 0) {
      let totalPaid = remove_financial(document.getElementById('stainTotalPaid').innerText)
      total += totalPaid
    }

    baseTotalElement.innerText = total.toLocaleString("en-US", {
      style: "currency",
      currency: "USD",
    });
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
  let lengthOfPlanPaymentAmounts = Object.keys(
    basePayments.planPayments.amounts
  ).length;
  let lengthOfAdditionalAmounts = Object.keys(
    basePayments.additionalPayments.amounts
  ).length;
  let lengthOfForgiveAmounts = Object.keys(
    basePayments.forgiveAmounts.amounts
  ).length;

  let note = "";
  let forumNoteElement = document.querySelector("#TextBox_224_10224");
  let delinquencyValue = document.getElementById('TextBox_222_900').value
  for (let i = 0; i < lengthOfPlanPaymentAmounts; i++) {
    let amounts = Number(basePayments.planPayments.amounts[i]);
    let periods = Number(basePayments.planPayments.periods[i]);
    let schedule = basePayments.planPayments.scheduleType[i]
    // The first 10 values, the selector has a 0
    if (i < 10 && amounts > 0) {
      let subtotalElement = document.querySelector("#subtotal10" + [i]);
      note += `$${amounts} x ${periods} periods = ${subtotalElement.innerHTML} Type: ${schedule} Effective: ${basePayments.planPayments.effectiveDate[i]} <br> \n`;
    } else if (i >= 10 && amounts > 0) {
      // Now its double digits
      let subtotalElement = document.querySelector("#subtotal1" + [i]);
      note += `$${amounts} x ${periods} periods = ${subtotalElement.innerHTML} Type: ${schedule} Effective: ${basePayments.planPayments.effectiveDate[i]} <br> \n`;
    }
  }
  // Stain
  if (remove_financial(delinquencyValue) > 0) {
    let monthlyAmount = document.getElementById('TextBox_222_901').value
    let monthsAmount = document.getElementById('stainMonthsTotal').innerText
    let stainTotalPaid = document.getElementById('stainTotalPaid').innerText
    note += `Case has Delinquency of ${delinquencyValue} <br> \n*Stain Case* Monthly amount of $${monthlyAmount} will cure delinquency in ~${monthsAmount} months with a total cure payment of ${stainTotalPaid} <br> \n`
  }
  for (let i = 0; i < lengthOfAdditionalAmounts; i++) {
    let amounts = Number(basePayments.additionalPayments.amounts[i]);
    let description = basePayments.additionalPayments.description[i];
    if (amounts > 0){
    note += `+ Additional $${amounts} - ${description} <br> \n`;
    }
  }
  for (let i = 0; i < lengthOfForgiveAmounts; i++) {
    let amounts = Number(basePayments.forgiveAmounts.amounts[i]);
    let description = basePayments.forgiveAmounts.description[i];
    if (amounts > 0){
    note += `- Forgive $${amounts} - ${description} <br> \n`;
    }
  }
  let baseTotalElement = document.querySelector("#baseTotalSpan");
  note += `Base Total: ${baseTotalElement.innerText} <br>`;
  forumNoteElement.innerHTML = note;
  triggerEvent(forumNoteElement, "change");
}

//  Get the values that will be used to perform calculations and update forum note.
function generateObject() {
  let newCalcOBject = {
    planPayments: {
      amounts: {},
      periods: {},
      perMonth: {},
      months: {},
      effectiveDate: {},
      scheduleType: {},
    },
    stainPayments: {
      amounts: {},
    },
    additionalPayments: {
      amounts: {},
      description: {},
    },
    forgiveAmounts: {
      amounts: {},
      description: {},
    },
  };

  ///////////////////
  // Plan Payments
  ///////////////////

  // Loop through Plan Payments amounts and add values to the newCalcObject amounts key
  let planPaymentAmounts = document.querySelectorAll("[id^='TextBox_222_1']");
  for (let i = 0; i < planPaymentAmounts.length; i++) {
    newCalcOBject.planPayments.amounts[i] = planPaymentAmounts[i].value;
  }
  // loop through the plan payment periods and add values to the new object periods key
  let planPaymentPeriods = document.querySelectorAll("[id^='TextBox_222_2']");
  for (let i = 0; i < planPaymentPeriods.length; i++) {
    newCalcOBject.planPayments.periods[i] = planPaymentPeriods[i].value;
  }
  // loop through the plan payment per month and add values to the new object per month key
  let planPaymentPerMonth = document.querySelectorAll("[id^='TextBox_222_3']");
  for (let i = 0; i < planPaymentPerMonth.length; i++) {
    newCalcOBject.planPayments.perMonth[i] = planPaymentPerMonth[i].value;
    let months = Number(newCalcOBject.planPayments.perMonth[i])
    let periods = Number(newCalcOBject.planPayments.periods[i])
    newCalcOBject.planPayments.months[i] = Math.floor(periods/months)
  }
  // Effective Date
  let effectiveDate = document.querySelectorAll("[id^='TextBox_222_6");
  for (let i = 0; i < effectiveDate.length; i++){
    newCalcOBject.planPayments.effectiveDate[i] = effectiveDate[i].value;
  }
  // Schedule Type 
  let scheduleType = document.querySelectorAll("[id^='select1']")
  for (let i = 0; i < scheduleType.length; i++) {
    let selector = scheduleType[i].value
    // console.log(`scheduleType selector: ${selector}`)
    switch(selector) {
      case '1': 
      newCalcOBject.planPayments.scheduleType[i] = 'Monthly'
        break;
      case '2': 
      newCalcOBject.planPayments.scheduleType[i] = 'Semi-Monthly'
        break;
      case '3':
        newCalcOBject.planPayments.scheduleType[i] = 'Bi-Weekly'
        break;
      case '4':
        newCalcOBject.planPayments.scheduleType[i] = 'Weekly'
        break;
      case '5':
        newCalcOBject.planPayments.scheduleType[i] = 'Semi-Annually'
        break;
      case '6':
        newCalcOBject.planPayments.scheduleType[i] = 'Quarterly'
        break;
      case '7':
        newCalcOBject.planPayments.scheduleType[i] = 'Annually'
        break;
      default:
        newCalcOBject.planPayments.scheduleType[i] = ''
        break;
     }
  }

  // Stain Payments
  let stainPaymentAmounts = document.getElementById('TextBox_222_901')
  newCalcOBject.stainPayments.amounts[0] = stainPaymentAmounts.value


  //////////////////////////
  // Additional Payments
  /////////////////////////
  let additionalAmounts = document.querySelectorAll("[id^='TextBox_222_4']");
  let additionalAmountsDescription = document.querySelectorAll(
    "[id^='TextBox_222_5']"
  );
  for (let i = 0; i < additionalAmounts.length; i++) {
    newCalcOBject.additionalPayments.amounts[i] = additionalAmounts[i].value;
    newCalcOBject.additionalPayments.description[i] =
      additionalAmountsDescription[i].value;
  }

  /////////////////////////
  // Forgive Amounts
  /////////////////////////
  let forgiveAmounts = document.querySelectorAll("[id^='TextBox_222_7']");
  let forgiveAmountsDescription = document.querySelectorAll(
    "[id^='TextBox_222_8']"
  );
  for (let i = 0; i < forgiveAmounts.length; i++) {
    newCalcOBject.forgiveAmounts.amounts[i] = forgiveAmounts[i].value;
    newCalcOBject.forgiveAmounts.description[i] =
      forgiveAmountsDescription[i].value;
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
function triggerEvent(element, eventName) {
  var event = new Event(eventName);
  element.dispatchEvent(event);
}


////////////////////////////////////////
// Load Pay Schedule Feature
// Pre-fills the plan payment section based on values. 
/////////////////////////////////////////

function loadPaySchedules() {
  // Lets get the pay schedule table values, probably into an object
  // then let's add the data to the inputs 
  // unhide previously hidden inputs that may contain values. 

  // get values of pay schedule
  //getPayScheduleValues();
  setPayScheduleValues();
}

function setPayScheduleValues(){
  let basePayments = getPayScheduleValues();
  let keyLength = Object.keys( basePayments.paySchedules.startdate ).length
    // loop through the basePayments object and set the values in Plan Payments based on the pay schedules. 
    for (let i = 0; i < keyLength; i++) {
      if (i < 10) {
      document.getElementById("TextBox_222_10" + [i]).value = remove_financial(basePayments.paySchedules.amount[i])
      triggerEvent(document.getElementById("TextBox_222_10" + [i]), 'change')
      
      
      // calculate approximate months remaining to convert 999 to actual number of periods remaining. 
      if (basePayments.paySchedules.numberperiods[i] == '999.00'){
        for (let j = 0; j < keyLength; j++){
          let currentFrequency = basePayments.paySchedules.frequency[j]
          let monthsRemain = document.getElementById("monthsRemainingInPlan").innerText
          // Take current frequency and months remaining, multiple frequency by months remaining to get approximate number of periods
          let remainingPeriods = parseFloat(currentFrequency) * parseFloat(monthsRemain)
          let finalScheduleValue =  document.getElementById("TextBox_222_20" + [i]).id

          document.getElementById("TextBox_222_20" + [i]).value = remainingPeriods
          // Set title tag
          $("#"+finalScheduleValue).closest('td').css("background-color", "goldenrod").attr('title', 'This value is approximate and calculated based on pay period and remaining months')
           $("#"+finalScheduleValue).attr('title', 'This value is approximate and calculated based on pay period and remaining months')

          //triggerEvent to record change 
          triggerEvent(document.getElementById("TextBox_222_20" + [i]), 'change')  
        }
      } else {
        document.getElementById("TextBox_222_20" + [i]).value = (basePayments.paySchedules.numberperiods[i])
        triggerEvent(document.getElementById("TextBox_222_20" + [i]), 'change')  
      }


      document.getElementById("TextBox_222_30" + [i]).value = (basePayments.paySchedules.frequency[i])
      triggerEvent(document.getElementById("TextBox_222_30" + [i]), 'change')
      document.getElementById("TextBox_222_60" + [i]).value = (basePayments.paySchedules.startdate[i])
      triggerEvent(document.getElementById("TextBox_222_60" + [i]), 'change')

      // update select drop down 
      let selectDropID = document.getElementById("select10" + [i]).id
        let selection = basePayments.paySchedules.frequency[i]
      switch(selection) {
        case '1': 
        $("#" + selectDropID).val("1").change();
          break;
        case '2': 
        $("#" + selectDropID).val("2").change();
          break;
        case '2.166':
        $("#" + selectDropID).val("3").change();
          break;
        case '4.33':
        $("#" + selectDropID).val("4").change();
          break;
        case '0.166':
          $("#" + selectDropID).val("5").change();
          break;
        case '0.33':
          $("#" + selectDropID).val("6").change();
          break;
        case '0.0833':
          $("#" + selectDropID).val("7").change();
          break;
        default:
          $("#" + selectDropID).val("0").change();
          break;
       }

    }
    else {
      document.getElementById("TextBox_222_1" + [i]).value = remove_financial(basePayments.paySchedules.amount[i])
      triggerEvent(document.getElementById("TextBox_222_1" + [i]), 'change')
      document.getElementById("TextBox_222_2" + [i]).value = (basePayments.paySchedules.numberperiods[i])
      triggerEvent(document.getElementById("TextBox_222_2" + [i]), 'change')
      document.getElementById("TextBox_222_3" + [i]).value = (basePayments.paySchedules.frequency[i])
      triggerEvent(document.getElementById("TextBox_222_3" + [i]), 'change')
      document.getElementById("TextBox_222_6" + [i]).value = (basePayments.paySchedules.startdate[i])
      triggerEvent(document.getElementById("TextBox_222_6" + [i]), 'change')

      // update select drop down 
      let selectDropID = document.getElementById("select10" + [i]).id
        let selection = basePayments.paySchedules.frequency[i]
      switch(selection) {
        case '1': 
        $("#" + selectDropID).val("1").change();
          break;
        case '2': 
        $("#" + selectDropID).val("2").change();
          break;
        case '2.166':
        $("#" + selectDropID).val("3").change();
          break;
        case '4.33':
        $("#" + selectDropID).val("4").change();
          break;
        case '0.166':
          $("#" + selectDropID).val("5").change();
          break;
        case '0.33':
          $("#" + selectDropID).val("6").change();
          break;
        case '0.0833':
          $("#" + selectDropID).val("7").change();
          break;
        default:
          $("#" + selectDropID).val("0").change();
          break;
       }
    }
    }
  // Update each row of the Plan Payments Table
  // Note: May need to add function that clears values first... 


  // Unhide rows that are no longer empty
    tableCleanup();

}

function getPayScheduleValues() {
  let payScheduleObject = {
    paySchedules: {
        startdate: {},
        numberperiods: {},
        frequency: {},
        amount:{}

    },
  }
  // reverse the date so it can go into the input:date field in the correct format. 
  let startDates = document.querySelectorAll("[data-start-date]")
  for (let i = 0; i < startDates.length; i++) {
    let date = startDates[i].innerText
    let newdate = date.split("/")
    let returnDate = `${newdate[2]}-${newdate[0]}-${newdate[1]}`
    payScheduleObject.paySchedules.startdate[i] = returnDate;
  }

  let numberPeriods = document.querySelectorAll("[data-number-periods]")
for (let i = 0; i < numberPeriods.length; i++) {
    
    payScheduleObject.paySchedules.numberperiods[i] = numberPeriods[i].innerText

}

  let frequency = document.querySelectorAll("[data-schedule-description]")
for (let i = 0; i < frequency.length; i++){
    let selection = frequency[i].innerText
    switch(selection) {
      case 'MONTHLY': 
      payScheduleObject.paySchedules.frequency[i] = '1'
        break;
      case 'SEMI-MONTHLY': 
      payScheduleObject.paySchedules.frequency[i] = '2'
        break;
      case 'BI-WEEKLY':
        payScheduleObject.paySchedules.frequency[i] = '2.166'
        break;
      case 'WEEKLY':
        payScheduleObject.paySchedules.frequency[i] = '4.33'
        break;
      case 'SEMI-ANNUALLY':
        payScheduleObject.paySchedules.frequency[i] = '0.166'
        break;
      case 'QUARTERLY':
        payScheduleObject.paySchedules.frequency[i] = '0.33'
        break;
      case 'ANNUALLY':
        payScheduleObject.paySchedules.frequency[i] = '0.0833'
        break;
      default:
        payScheduleObject.paySchedules.frequency[i] = ''
        break;
     }
}

let amount = document.querySelectorAll("[data-payment-amount]")
for (let i = 0; i < amount.length; i++){
  payScheduleObject.paySchedules.amount[i] = amount[i].innerText
}

  // let planPaymentAmounts = document.querySelectorAll("[id^='TextBox_222_1']");
  // for (let i = 0; i < planPaymentAmounts.length; i++) {
  //   newCalcOBject.planPayments.amounts[i] = planPaymentAmounts[i].value;
  // }
  console.log(payScheduleObject)
  return payScheduleObject;
}

function tableCleanup(){
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
}
