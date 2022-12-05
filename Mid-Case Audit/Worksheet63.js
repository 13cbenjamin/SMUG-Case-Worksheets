function wsOnLoad(){ 
    //<!--
    $('textarea').css('white-space' , 'pre-wrap').css('width', '100%');
    $('input[name*="TextBox_"]').css('min-width', '250px').css('width', '100%');
    $('input[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to TextBox elements
    $('input[name*="CheckBox_"]').addClass("form-check-input"); // add bootstrap form-check-input class to CheckBox elements
    $('textarea[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to CommentBox elements

    $("#CheckBox_221_3216").hover().prop("title", "Alert: Please double check that you have checked all of the Corrected/Verified boxes in the worksheet. Each row must have at least 1 checkbox before you can mark this worksheet as completed. The 4 checkboxes in this section do not apply.")
    
  // Set effective date values to input  type date
  $("[id^=TextBox_218_996]").each(function () {
    $(this).attr({type:"date"})
  })


      // Toggle section 1
    $("#section_1_title").on("click", function () {
        $("#section_1_collapse").fadeToggle().toggleClass("collapse");
      }); 

      // Toggle section 3
    $("#section_3_title").on("click", function () {
        $("#section_3_collapse").fadeToggle().toggleClass("collapse");
      }); 
      // Toggle section 4
    $("#section_4_title").on("click", function () {
        $("#section_4_collapse").fadeToggle().toggleClass("collapse");
      }); 
      // Toggle section 42
    $("#section_42_title").on("click", function () {
        $("#section_42_collapse").fadeToggle().toggleClass("collapse");
      }); 
      // Toggle section 220
    $("#section_220_title").on("click", function () {
        $("#section_220_collapse").fadeToggle().toggleClass("collapse");
      }); 
      // Toggle section tax Data
    $("#section_taxdata_title").on("click", function () {
        $("#section_taxdata_collapse").fadeToggle().toggleClass("collapse");
      }); 

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


////////////////////////////////////////////////////////////////
// CHECKBOX ON CLICK FUNCTIONS
///////////////////////////////////////////////////////////////

// SATISIFED BOXES -  When a Satisifed Checkbox is Checked, change closest TR to Green background 
      $("[id^=CheckBox_218_1],[id^=CheckBox_219_1],[id^=CheckBox_220_1]").on("click",function () {
        var td_id = this.id;
        var checkbox_id = td_id.replace("_1", "_2");
        var na_checkbox_id = td_id.replace("_1", "_3");
      
        if ($(this).is(":Checked")) {
            $(this).closest("tr").css("background", "#00AA00"); // change background color
            $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
            $("#"+na_checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
          } else {
            $(this).closest("tr").css("background", "#FFF"); // change background color
            $("#"+checkbox_id).removeAttr("disabled"); // remove disable on N/A box 
            $("#"+na_checkbox_id).removeAttr("disabled"); // remove disable on N/A box 
          }
          completedCheck()
      })
    //   Section X
    $("[id^=CheckBox_218_8],[id^=CheckBox_220_8]").on("click",function () {
      
       
        var td_id = this.id;
        var checkbox_id = td_id.replace("_8", "_9");
        if ($(this).is(":Checked")) {
            $(this).closest("tr").css("background", "#00AA00"); // change background color
            $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
          } else {
            $(this).closest("tr").css("background", "#FFF"); // change background color
            $("#"+checkbox_id).removeAttr("disabled"); // remove disable on N/A box 
          }
          completedCheck()
      })



// N/A BOXES -  When a Corrected Checkbox is Checked, change closest TR to Yellow background 
  $("[id^=CheckBox_218_2]").on("click",function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("218_2", "218_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("218_2", "218_3"); // get satisifed box ID from This ID 
    // //console.log(td_id, checkbox_id, na_checkbox_id)
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked

      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
        $("#"+na_checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
      completedCheck()
  })
  $("[id^=CheckBox_219_2]").on("click",function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("219_2", "219_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("219_2", "219_3"); // get satisifed box ID from This ID 
    // //console.log(td_id, checkbox_id, na_checkbox_id)
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked

      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
        $("#"+na_checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
      completedCheck()
  })
  $("[id^=CheckBox_220_2]").on("click",function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("220_2", "220_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("220_2", "220_3"); // get satisifed box ID from This ID 
    //console.log(td_id, checkbox_id, na_checkbox_id)
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked

      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
        $("#"+na_checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
      completedCheck()
  })

  // The N/A Boxes
  $("[id^=CheckBox_218_3],[id^=CheckBox_219_3],[id^=CheckBox_220_3]").on("click",function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("_3", "_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("_3", "_2"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#8f8f8f"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked

      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
        $("#"+na_checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
      completedCheck()
  })
//   Section X
$("[id^=CheckBox_218_9],[id^=CheckBox_220_9]").on("click",function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("_9", "_8"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
      completedCheck()
  })


$("[id^=CheckBox_220_2]").on("click",function () {
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_220_2", "CheckBox_220_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("CheckBox_220_2", "CheckBox_220_3"); // get satisifed box ID from This ID 
if ($(this).is(":Checked")) {
    $(this).closest("tr").css("background", "#fff9a7"); // change background color
    $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
    $("#"+na_heckbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked

  } else {
    $(this).closest("tr").css("background", "#FFF"); // change background color
    $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
    $("#"+na_checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
  }
  completedCheck()
})

$("[id^=CheckBox_221_2]").on("click",function () {
  //var row_index = $(this).closest("tr"); // this row index value
  if ($(this).is(":Checked")) {
      $(this).closest("tr").css("background", "#fff9a7"); // change background color
    } else {
      $(this).closest("tr").css("background", "#FFF"); // change background color
    }
  })

  $("[id^=CheckBox_221_2215]").on("click", function () {
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#auditDateTimeStamp").show();
        $("#CheckBox_221_3216").attr("disabled", true)
      } 
      else {
        $(this).closest("tr").css("background", "#FFF");
        $("#auditDateTimeStamp").hide();
        $("#CheckBox_221_3216").attr("disabled", false)
      }
    })



  $("#CheckBox_221_3216").on("click", function (event) {
    if (completedCheck() == false ){
      return;
    }
    else {
       if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#00AA00"); // change background color
        $("#completedDateTimeStamp").show();
        $("#CheckBox_221_2215").attr("disabled", true)
      } 
      else {
        $(this).closest("tr").css("background", "#FFF");
        $("#completedDateTimeStamp").hide();
        $("#CheckBox_221_2215").attr("disabled", false)

      }
    }
    })
   


////////////////////////////////////////////////////////////////
// CHECKBOX ON LOAD FUNCTIONS
///////////////////////////////////////////////////////////////


$("[id^=CheckBox_218_1],[id^=CheckBox_219_1],[id^=CheckBox_220_1]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("_1", "_2");
    var na_checkbox_id = td_id.replace("_1", "_3");
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#00AA00"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
      } 
      completedCheck()
  })
  // Section X
  $("[id^=CheckBox_218_8],[id^=CheckBox_220_8]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("_8", "_9");
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#00AA00"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
      } 
      completedCheck()

  })


$("[id^=CheckBox_218_2]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("218_2", "218_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("218_2", "218_3"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
      completedCheck()

  })
$("[id^=CheckBox_219_2]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("219_2", "219_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("219_2", "219_3"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
      completedCheck()

  })
$("[id^=CheckBox_220_2]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("220_2", "220_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("220_2", "220_3"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
      completedCheck()

  })
  // NA Boxes
$("[id^=CheckBox_218_3]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("218_3", "218_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("218_3", "218_2"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#8f8f8f"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
      completedCheck()

  })
$("[id^=CheckBox_219_3]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("219_3", "219_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("219_3", "219_2"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#8f8f8f"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
      completedCheck()

  })
$("[id^=CheckBox_220_3]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("220_3", "220_1"); // get satisifed box ID from This ID 
    var na_checkbox_id = td_id.replace("220_3", "220_2"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#8f8f8f"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
      completedCheck()

  })

//   Section X
$("[id^=CheckBox_218_9],[id^=CheckBox_220_9]").each(function () {
  
   
    var td_id = this.id;
    var checkbox_id = td_id.replace("_9", "_8"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
      completedCheck()

  })

$("[id^=CheckBox_220_2]").each(function () {
        var td_id = this.id;
        var checkbox_id = td_id.replace("CheckBox_220_2", "CheckBox_220_1"); // get satisifed box ID from This ID 
        var na_checkbox_id = td_id.replace("CheckBox_220_2", "CheckBox_220_3"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#fff9a7"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
        $("#"+na_checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
      completedCheck()

    })

    $("[id^=CheckBox_221_2]").each(function () {
      if ($(this).is(":Checked")) {
          $(this).closest("tr").css("background", "#fff9a7"); // change background color
        } 
      completedCheck()

      })

      $("[id^=CheckBox_221_2215]").each(function () {
        if ($(this).is(":Checked")) {
            $(this).closest("tr").css("background", "#fff9a7"); // change background color
            $("#auditDateTimeStamp").show(); // show name and date/time stamp
          $("#CheckBox_221_3216").attr("disabled", true)

          } 
          else {
            $("#auditDateTimeStamp").hide(); // hide name and date/time stamp
            $("#CheckBox_221_3216").attr("disabled", false)
  
          }
      completedCheck()

        })

    $("[id^=CheckBox_221_3216]").each(function () {
      if ($(this).is(":Checked")) {
          $(this).closest("tr").css("background", "#00AA00"); // change background color
          $("#completedDateTimeStamp").show(); // show name and date/time stamp
          $("#CheckBox_221_2215").attr("disabled", true)
         
        } 
        else {
          $("#completedDateTimeStamp").hide(); // hide name and date/time stamp
          $("#CheckBox_221_2215").attr("disabled", false)

        }
      })



/////////////////////////////////////
// Table Manipulation
/////////////////////////////////////

  // Show next closest hidden row when "Add Row" button clicked.
  $("[id^=addrow_]").click(function () {
    $(this)
      .closest("table")
      .find("tr:hidden")
      .first()
      .show()
      .find('input[name*="TextBox_"]')
      .first()
      .focus(); // show the first hidden row when "Add Row" button clicked, set the focus to the first input on the shown row
  });

    // Hide table rows and clear all input fields in the row when the "Delete" button is clicked.
    $("[id^=delrow_]").click(function (event) {
      // buttons with class .tac_btnDel when clicked
      var row_index = $(this).closest("tr").index(); // this row index value
      if (row_index > 0) {
        // second row and on
        $(this).closest("tr").hide(); // hide this row
      }
      // Find all textboxes in the table row and then remove the contents, dispatching an event which will cause TNG to save the change to the tblCaseWorksheetData
      $(this)
        .closest("tr")
        .find('input[name*="TextBox_"]')
        .each(function () {
          // loop through each TextBox in this row
          var element = document.getElementById(this.id);
          var event;
          if (typeof Event === "function") {
            // non IE browsers
            event = new Event("change");
          } else {
            // IE
            event = document.createEvent("Event");
            event.initEvent("change", true, true);
          }
          $(this).val(""); // clear the contents of each TextBox
          element.dispatchEvent(event); // trigger the TextBox onchange() event. required to update worksheet sql tables
        });
      
    });

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
  $("[id^=baseCalc_delrow_]").click(function () {
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
    // console.log('baseCalc() Calculate button clicked')
    baseCalc();
  });

  
    // Base Calculator Button Collapse
    $("#section_2_title").on('click', function() {
      $("#section_2_collapse").toggleClass('collapse')
      hideCalculatorExtraRows();
      baseCalc();
    })

    // Base Calculator - Additional Payments unhide
    $("#baseCalcAddPayments").on('click', function() {
      $("#table_calculator_9000").toggleClass('collapse')

    })
    // Base Calculator - Forgive Amounts unhide
    $("#baseCalcForgivePayments").on('click', function() {
      $("#table_calculator_7000").toggleClass('collapse')

    })



// When an input in base calc changes, run baseCalc() function to update calculations 
$("[id^=TextBox_218_99]").on("change", function () {
  baseCalc();
})

// on load of the worksheet, we want to loop through all inputs and set the initial value to 0. 
$("[id^=TextBox_218_99]" ).each(function () {
  if ($(this).find('input[name*="TextBox_"]').val() = '') {
    $(this).find('input[name*="TextBox_"]').val(0)
  }

})



function hideCalculatorExtraRows() {
  // //console.log('hideCalculatorExtraRows function running')
  // Hide all blank rows when calculator section shown
  $("[id^=table_calculator_]").each(function () {
    $(this)
      .find("tbody tr")
      .each(function (i) {
        var x = $(this)
          .find('input[name*="TextBox_"]')
          .filter(function () {
            return this.value.length > 0; // filter through TextBox values, returning lengths greather than zero
          }).length; // the total of all non zero length TextBox values in this row
        if (x == 0 && i > 0) {
          // if the total length of all TextBox values for this row is zero, and this row is not the first row, hide the row
          $(this).hide();
        } else {
          $(this).show();
         
        }
      });
  });



// $("#checkedCheckBoxCount").each(function () {
//   $(this).val(document.querySelectorAll('input[type="checkbox"]:checked').length)
// })

//////////////////////////////
// End of wsOnLoad()
//////////////////////////////
}
/////////////////////////////
// Calculations
/////////////////////////////
function baseCalc() {
  // //console.log('baseCalc() running')
  // get the object which will pull new values from the worksheet
  let baseCalcValues = generateObject();
  //  //console.log(baseCalcValues)
  // Call the Calcuation Functions in order
  updateSubtotal();
  updatePlanPaymentTotal();
  updateMonths();
  updateAdditionalPaymentTotal();
  updateForgivePaymentTotal();
  updateBaseTotal();


  // Update Subtotals function for plan payment section
  function updateSubtotal() {
    console.log('updateSubtotal() running')
    let lengthOfAmounts = Object.keys(
      baseCalcValues.planPayments.amounts
    ).length;
    for (let i = 0; i < lengthOfAmounts; i++) {
      let amounts = Number(baseCalcValues.planPayments.amounts[i]);
      let periods = Number(baseCalcValues.planPayments.periods[i]);
      // //console.log(amounts)
      // //console.log(periods)
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
    console.log(baseCalcValues)
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
    let auditorBaseTotalElement = document.querySelector("#baseCalcResult");
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

    auditorBaseTotalElement.innerText = total.toLocaleString("en-US", {
      style: "currency",
      currency: "USD",
    });
  }
}

//  Get the values that will be used to perform calculations and update forum note.
function generateObject() {
  console.log('generating object')
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
  let planPaymentAmounts = document.querySelectorAll("[id^='TextBox_218_991']");
  for (let i = 0; i < planPaymentAmounts.length; i++) {
    newCalcOBject.planPayments.amounts[i] = planPaymentAmounts[i].value;
  }
  // loop through the plan payment periods and add values to the new object periods key
  let planPaymentPeriods = document.querySelectorAll("[id^='TextBox_218_992']");
  for (let i = 0; i < planPaymentPeriods.length; i++) {
    newCalcOBject.planPayments.periods[i] = planPaymentPeriods[i].value;
  }
  // loop through the plan payment per month and add values to the new object per month key
  let planPaymentPerMonth = document.querySelectorAll("[id^='TextBox_218_993']");
  for (let i = 0; i < planPaymentPerMonth.length; i++) {
    newCalcOBject.planPayments.perMonth[i] = planPaymentPerMonth[i].value;
    let months = Number(newCalcOBject.planPayments.perMonth[i])
    let periods = Number(newCalcOBject.planPayments.periods[i])
    newCalcOBject.planPayments.months[i] = Math.floor(periods/months)
  }
  // Effective Date
  let effectiveDate = document.querySelectorAll("[id^='TextBox_218_996");
  for (let i = 0; i < effectiveDate.length; i++){
    newCalcOBject.planPayments.effectiveDate[i] = effectiveDate[i].value;
  }
  // Schedule Type 
  let scheduleType = document.querySelectorAll("[id^='select991']")
  for (let i = 0; i < scheduleType.length; i++) {
    let selector = scheduleType[i].value
    // //console.log(`scheduleType selector: ${selector}`)
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
  let additionalAmounts = document.querySelectorAll("[id^='TextBox_218_999']");
  let additionalAmountsDescription = document.querySelectorAll(
    "[id^='TextBox_218_995']"
  );
  for (let i = 0; i < additionalAmounts.length; i++) {
    newCalcOBject.additionalPayments.amounts[i] = additionalAmounts[i].value;
    newCalcOBject.additionalPayments.description[i] =
      additionalAmountsDescription[i].value;
  }

  /////////////////////////
  // Forgive Amounts
  /////////////////////////
  let forgiveAmounts = document.querySelectorAll("[id^='TextBox_218_997']");
  let forgiveAmountsDescription = document.querySelectorAll(
    "[id^='TextBox_218_998']"
  );
  for (let i = 0; i < forgiveAmounts.length; i++) {
    newCalcOBject.forgiveAmounts.amounts[i] = forgiveAmounts[i].value;
    newCalcOBject.forgiveAmounts.description[i] =
      forgiveAmountsDescription[i].value;
  }

console.log(newCalcOBject);
  //
  // Object Output: Each row will line up by ID. We will be calculating based on object index. Amount.0 * periods.0
  // amounts: {0: '100', 1: '200'}
  // perMonth: {0: '2', 1: '4'}
  // periods: {0: '36', 1: '72'}
  // */

  return newCalcOBject;
}


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


  function completedCheck(){
    let checkedCheckBoxCount = document.querySelectorAll('input[type="checkbox"]:checked').length
    let totalCheckBox = document.querySelectorAll('input[type="checkbox"]').length -1
    //console.log(`checked checkbox count: ${checkedCheckBoxCount} \n totalCheckBox count = ${totalCheckBox}`)
    
    // if the checked checkboxes is less than the total checkboxes minus 5 accounting for last section. 
    if (checkedCheckBoxCount < (totalCheckBox)/3)
    // 16 comes from 5 in the audit area, and the 11 N/A boxes that default. 
    {
      $('#CheckBox_221_3216').attr("disabled", true)
    return false
    }
    else {
      $('#CheckBox_221_3216').attr("disabled", false)
      return true
    }
  }

