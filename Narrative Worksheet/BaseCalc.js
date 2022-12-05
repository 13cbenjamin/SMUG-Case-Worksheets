// This will be incorporated into Worskheet41.js
function performBaseCalc() {
    // Bootstrap setup
 
    // Set effective date values to input  type date
    $("[id^=TextBox_186_996]").each(function () {
      $(this).attr({type:"date"})
    })
  
    // Load Pay Schedules Button
    // $("#loadPayScheduleButton").on('click', function(){
    //   loadPaySchedules();
    // })
   
    // Select drop down magic
    // set the value of the closest textbox based on the dropdown selection 
    $("[id^=select991]").on('change', function() {
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
  
    $("[id^=TextBox_186_993]").each(function() {
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
    $("[id^=baseCalc_addrow_]").click(function () {
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
          let subtotalElement = document.querySelector("#subtotal9910" + [i]);
          subtotalElement.innerText = (amounts * periods).toLocaleString(
            "en-US",
            { style: "currency", currency: "USD" }
          );
        } else {
          // double digits
          let subtotalElement = document.querySelector("#subtotal991" + [i]);
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
            document.querySelector("#subtotal9910" + [i]).innerText
          );
          total += subtotalValue;
        } else {
          let subtotalValue = remove_financial(
            document.querySelector("#subtotal991" + [i]).innerText
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
          let monthsElement = document.querySelectorAll("#months9910" + [i])[0];
          let monthsCalc = Math.floor(periods / months) || 0;
           var d = new Date(baseCalcValues.planPayments.effectiveDate[i]);
          let approxEndDate = new Date(d.setMonth(d.getMonth() + monthsCalc))
          monthsElement.setAttribute('title', approxEndDate.toLocaleDateString());
          monthsElement.innerText = `${monthsCalc.toString()} \n~${approxEndDate.toLocaleDateString()}`;
  
        } else {
          let monthsElement = document.querySelectorAll("#months991" + [i])[0];
          let monthsCalc = Math.floor(periods / months) || 0;
          var d = new Date(baseCalcValues.planPayments.effectiveDate[i]);
          let approxEndDate = new Date(d.setMonth(d.getMonth() + monthsCalc))
          monthsElement.setAttribute('title', approxEndDate.toLocaleDateString());
          monthsElement.innerText = `${monthsCalc.toString()} \n~${approxEndDate.toLocaleDateString()}`;
  
        }
      }
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
            document.querySelector("#subtotal9910" + [i]).innerText
          );
          total += subtotalValue;
        } else {
          let subtotalValue = remove_financial(
            document.querySelector("#subtotal991" + [i]).innerText
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
    let forumNoteElement = document.querySelector("#TextBox_186_10301");
    for (let i = 0; i < lengthOfPlanPaymentAmounts; i++) {
      let amounts = Number(basePayments.planPayments.amounts[i]);
      let periods = Number(basePayments.planPayments.periods[i]);
      let schedule = basePayments.planPayments.scheduleType[i]
      // The first 10 values, the selector has a 0
      if (i < 10 && amounts > 0) {
        let subtotalElement = document.querySelector("#subtotal9910" + [i]);
        note += `$${amounts} x ${periods} periods = ${subtotalElement.innerHTML} Type: ${schedule} Effective: ${basePayments.planPayments.effectiveDate[i]} <br> \n`;
      } else if (i >= 10 && amounts > 0) {
        // Now its double digits
        let subtotalElement = document.querySelector("#subtotal991" + [i]);
        note += `$${amounts} x ${periods} periods = ${subtotalElement.innerHTML} Type: ${schedule} Effective: ${basePayments.planPayments.effectiveDate[i]} <br> \n`;
      }
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
    let planPaymentAmounts = document.querySelectorAll("[id^='TextBox_186_991']");
    for (let i = 0; i < planPaymentAmounts.length; i++) {
      newCalcOBject.planPayments.amounts[i] = planPaymentAmounts[i].value;
    }
    // loop through the plan payment periods and add values to the new object periods key
    let planPaymentPeriods = document.querySelectorAll("[id^='TextBox_186_992']");
    for (let i = 0; i < planPaymentPeriods.length; i++) {
      newCalcOBject.planPayments.periods[i] = planPaymentPeriods[i].value;
    }
    // loop through the plan payment per month and add values to the new object per month key
    let planPaymentPerMonth = document.querySelectorAll("[id^='TextBox_186_993']");
    for (let i = 0; i < planPaymentPerMonth.length; i++) {
      newCalcOBject.planPayments.perMonth[i] = planPaymentPerMonth[i].value;
      let months = Number(newCalcOBject.planPayments.perMonth[i])
      let periods = Number(newCalcOBject.planPayments.periods[i])
      newCalcOBject.planPayments.months[i] = Math.floor(periods/months)
    }
    // Effective Date
    let effectiveDate = document.querySelectorAll("[id^='TextBox_186_996");
    for (let i = 0; i < effectiveDate.length; i++){
      newCalcOBject.planPayments.effectiveDate[i] = effectiveDate[i].value;
    }
    // Schedule Type 
    let scheduleType = document.querySelectorAll("[id^='select991']")
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
  

  
    //////////////////////////
    // Additional Payments
    /////////////////////////
    let additionalAmounts = document.querySelectorAll("[id^='TextBox_186_994']");
    let additionalAmountsDescription = document.querySelectorAll(
      "[id^='TextBox_186_995']"
    );
    for (let i = 0; i < additionalAmounts.length; i++) {
      newCalcOBject.additionalPayments.amounts[i] = additionalAmounts[i].value;
      newCalcOBject.additionalPayments.description[i] =
        additionalAmountsDescription[i].value;
    }
  
    /////////////////////////
    // Forgive Amounts
    /////////////////////////
    let forgiveAmounts = document.querySelectorAll("[id^='TextBox_186_997']");
    let forgiveAmountsDescription = document.querySelectorAll(
      "[id^='TextBox_186_8']"
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
 