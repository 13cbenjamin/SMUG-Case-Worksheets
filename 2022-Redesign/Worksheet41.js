function wsOnLoad() {
  // updated 1/2022 to add toFixed(4) for percent values instead of toFixed(3)
  // updated 2/2022 to remove Pickaday dropdown. 
  // updated 6/27/2022 to add date input functionality for edge
  // updated 6/28/2022 to fix loading the date to date picker if already existed and formatting for summary section date. 
  // Updated 10/11/2022 to add base calculator section 

  //import my custom CSS file
  $("head").append(
    '<link rel="stylesheet" type="text/css" href="tac_styles/tac_style.css"/>'
  );
  //set background image
  $("body").css(
    "background-image",
    'url("/13Software_app_tac/images/gplaypattern.png")'
  );
  //set whitespace on text areas
  $("textarea").css("white-space", "pre-wrap").css("width", "100%");
  //set comment boxes to have 4 rows
  $("textarea").attr("rows", "4");
  //add form control bootstrap
  $('textarea[name*="TextBox_"]').addClass("form-control");
  //add form control bootstrap
  $('input[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to TextBox elements
  //style the summary tables
  $("summarytable").addClass("table table-bordered"); // add bootstrap table-dark to class Summary Table
  $('table[name*="table_summary_"]').addClass(
    "table table-bordered table-responsive"
  );
  //add stepPayment and date-picker clasd to all of the fiels
  $(
    "#TextBox_186_4001,#TextBox_186_4011,#TextBox_186_4021,#TextBox_186_4031,#TextBox_186_4041,#TextBox_186_4002,#TextBox_186_4012,#TextBox_186_4022,#TextBox_186_4032,#TextBox_186_4042"
  ).addClass("stepPayment");

    //get saved value of the date plan filed and update it
let date = $("#TextBox_186_3").val();
    if (date == null || date == undefined || date == ''){
      let today = new Date();
      today = today.toISOString().substr(0, 10);
        $("#TextBox_186_3").attr({type:"date"}).val(today)
    }    // send to reverseString function to get proper format
    else {
      let myDateReversed = reverseDate(date);
        //update value with new reversed value, set attribute to date type, and if necessary update value again
        $("#TextBox_186_3").val(myDateReversed).attr({type:"date"}).val(myDateReversed);
    }


    // Base Calculator Button Collapse
    $("#baseCalcCollapseButton").on('click', function() {
      $("#baseCalculator").toggleClass('collapse')
      hideCalculatorExtraRows();
      performBaseCalc();
    })

    // Base Calculator - Additional Payments unhide
    $("#baseCalcAddPayments").on('click', function() {
      $("#table_calculator_9000").toggleClass('collapse')

    })
    // Base Calculator - Forgive Amounts unhide
    $("#baseCalcForgivePayments").on('click', function() {
      $("#table_calculator_7000").toggleClass('collapse')

    })

  

  //get all data-collapse-area titles into a single variable.
  const collapseSections = document.querySelectorAll("[data-collapse-area]");

  //Set all date pickers in step payments to date pickers. 
  $("#TextBox_186_4001,#TextBox_186_4011,#TextBox_186_4021,#TextBox_186_4031,#TextBox_186_4041,#TextBox_186_4002,#TextBox_186_4012,#TextBox_186_4022,#TextBox_186_4032,#TextBox_186_4042").attr({type:"month"})
 
  //expand all / collapse all button
  $("#controlCollapse").on("click", function () {
    $(collapseSections).fadeToggle().toggleClass("collapse");
  });

  //collapse toggles for all section titles.
  $("#section_0_title").on("click", function () {
    $("#section_0_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_1_title").on("click", function () {
    $("#section_1_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_2_title").on("click", function () {
    $("#section_2_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_3_title").on("click", function () {
    $("#section_3_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_4_title").on("click", function () {
    $("#section_4_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_5_title").on("click", function () {
    $("#section_5_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_6_title").on("click", function () {
    $("#section_6_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_7_title").on("click", function () {
    $("#section_7_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_8_title").on("click", function () {
    $("#section_8_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_9_title").on("click", function () {
    $("#section_9_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_9_1_title").on("click", function () {
    $("#section_9_1_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to
  $("#section_9_2_title").on("click", function () {
    $("#section_9_2_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to
  $("#section_10_title").on("click", function () {
    $("#section_10_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_11_title").on("click", function () {
    $("#section_11_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_12_title").on("click", function () {
    $("#section_12_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_13_title").on("click", function () {
    $("#section_13_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_IV_title").on("click", function () {
    $("#section_IV_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to CheckBox_182_2
  $("#section_III_title").on("click", function () {
    $("#section_III_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to
  $("#section_II_title").on("click", function () {
    $("#section_II_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to
  $("#section_I_title").on("click", function () {
    $("#section_I_collapse").fadeToggle().toggleClass("collapse");
  }); // add bootstrap data-toggle="collapse" to

  //this disables the snapshot and delete buttons at the top -right
  $("#table23")
    .find("tbody > tr > td:nth-child(4)")
    .find("a:nth-child(3),a:nth-child(4),img:eq(4)")
    .each(function () {
      // disable worksheet flatten, snapshot, and PDF buttons
      $(this).prop("onclick", null).attr("onclick", "");
    });

  // convert numbers entered into TextBox input fields to currency format.
  $(".tac_money")
    .find('input[name*="TextBox_"]')
    .each(function () {
      // convert TextBox value to currency
      $(this).bind("change", function () {
        let currentValue = $(this).val();
        if (
          !isNaN($(this).val().toString().replace(/[$,]+/g, "")) &&
          $(this).val() != ""
        ) {
          // remove '$' and ',' check if the value is a number
          $(this).val(tac_financial($(this).val())); // if the value is a number, convert it to currency format
        } else {
          //If the field is not Money or Blank then see if it's even valid text using checkValid()
          //if invalid then set the textbox color to Red and display an error message
          if (checkValid(currentValue) === false) {
            $(this).css("background-color", "red");
            alert(
              "Please remove any symbols, only Letters, Numbers, Periods, $, % and () are allowed. \n Examples of Allowed Values: 4500 | $4500 | $4,500 | $4,500.23 | 23% | All Available | See Prov X. | (blank)"
            );
          }
        }
      });
    });

  //this function checks each time tac_money and tac_percent fields are changed to ensure only valid characters are entered
  //it will return true if all characters are valid and return false if it finds an invalid character
  //this was implemented to ensure forum note creates and no invalid symbols are allowed

  function checkValid(inputText) {
    var letters = "^[a-zA-Z0-9.%()$,;/\\s]+$";
    if (inputText.match(letters)) {
      return true;
    } else {
      return false;
    }
  }

  $(".tac_money")
    .find('input[name*="td_TextBox_"]')
    .each(function () {
      // convert TextBox value to currency
      $(this).bind("change", function () {
        if (
          !isNaN($(this).val().toString().replace(/[$,]+/g, "")) &&
          $(this).val() != ""
        ) {
          // remove '$' and ',' check if the value is a number
          $(this).val(tac_financial($(this).val())); // if the value is a number, convert it to currency format
        } else {
          if (checkValid(currentValue) === false) {
            $(this).css("background-color", "red");
            alert(
              "Please remove any symbols, only Letters, Numbers, Periods, $, % and () are allowed. \n Examples of Allowed Values: 4500 | $4500 | $4,500 | $4,500.23 | 23% | All Available | See Prov X. | (blank)"
            );
          }
        }
      });
    });

  // convert numbers entered into TextBox input fields to percentage format.
  $(".tac_percent")
    .find('input[name*="TextBox_"]')
    .each(function () {
      // convert TextBox value to percentage
      $(this).bind("change", function () {
        if (
          !isNaN($(this).val().toString().replace(/[%,]+/g, "")) &&
          $(this).val() != ""
        ) {
          // remove '%' and ',' check if the value is a number
          $(this).val(tac_percentage($(this).val())); // if the value is a number, convert it to percent
        } else {
          //if not a percent then check the value entered for invalid characters
          if (checkValid(currentValue) === false) {
            $(this).css("background-color", "red");
            alert(
              "Please remove any symbols, only Letters, Numbers, Periods, $, % and () are allowed. \n Examples of Allowed Values: 4500 | $4500 | $4,500 | $4,500.23 | 23% | All Available | See Prov X. | (blank)"
            );
          }
        }
      });
    });

  // Hide table rows and clear all input fields in the row when the "Delete" button is clicked.
  $("[id^=table_template_]").on("click", ".tac_btnDel", function (event) {
    // buttons with class .tac_btnDel when clicked
    var table_id = $(this).closest("table").attr("id"); // this table id
    var row_index = $(this).closest("tr").index(); // this row index value
    if (row_index > 0) {
      // second row and on
      $(this).closest("tr").hide(); // hide this row
      $(
        "#" +
          table_id.replace("template", "summary") +
          " tbody tr:eq(" +
          row_index +
          ")"
      ).hide(); // hide empty rows in corresponding summary table
    }
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
    $(this)
      .closest("tr")
      .find('textarea[name*="TextBox_"]')
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

  $("[id^=tablex_template_]").on("click", ".tac_btnDel", function (event) {
    // buttons with class .tac_btnDel when clicked
    var table_id = $(this).closest("table").attr("id"); // this table id
    var row_index = $(this).closest("tr").index(); // this row index value
    if (row_index > 0) {
      // second row and on
      $(this).closest("tr").hide(); // hide this row
      $(
        "#" +
          table_id.replace("template", "summary") +
          " tbody tr:eq(" +
          row_index +
          ")"
      ).hide(); // hide empty rows in corresponding summary table
    }
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
    $(this)
      .closest("tr")
      .find('textarea[name*="TextBox_"]')
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

  // Show next closest hidden row when "Add Row" button clicked.
  $("[id^=addrow_]").click(function () {
    var table_id = $(this).closest("table").attr("id"); // this table id
    $(this)
      .closest("table")
      .find("tr:hidden")
      .first()
      .show()
      .find('input[name*="TextBox_"]')
      .first()
      .focus(); // show the first hidden row when "Add Row" button clicked, set the focus to the first input on the shown row
    $("#" + table_id.replace("template", "summary") + " tbody tr:hidden")
      .first()
      .show(); // hide empty rows in corresponding summary table
  });

  

  // Hide all blank rows when the worksheet loads. Expand TextBox width to fill table cell.
  $("[id^=table_template_]").each(function () {
    $(this)
      .find("tbody tr")
      .each(function (i) {
        var table_id = $(this).closest("table").attr("id"); // this table id
        var row_index = $(this).index(); // this row index value
        var x = $(this)
          .find('input[name*="TextBox_"]')
          .filter(function () {
            return this.value.length > 0; // filter through TextBox values, returning lengths greather than zero
          }).length; // the total of all non zero length TextBox values in this row
        if (x == 0 && i == 0) {
          hideMenu(table_id.replace("table_template", "collapse_summary"));
        } else if (x == 0 && i > 0) {
          // if the total length of all TextBox values for this row is zero, and this row is not the first row, hide the row
          $(this).hide();
          $(
            "#" +
              table_id.replace("template", "summary") +
              " tbody tr:eq(" +
              row_index +
              ")"
          ).hide();
        } else {
          $(this).show();
          $(
            "#" +
              table_id.replace("template", "summary") +
              " tbody tr:eq(" +
              row_index +
              ")"
          ).show();
          showMenu(table_id.replace("table_template", "collapse_summary"));
        }
        $(this)
          .find('input[name*="TextBox_"]')
          .css("width", "100%")
          .css("text-align", "left"); // expand TextBox width to fill table cell
      });
  });

  // Hide all blank rows when the worksheet loads. Expand TextBox width to fill table cell.
  $("[id^=tablex_template_]").each(function () {
    $(this)
      .find("tbody tr")
      .each(function (i) {
        var table_id = $(this).closest("table").attr("id"); // this table id
        var row_index = $(this).index(); // this row index value
        var x = $(this)
          .find('textarea[name*="TextBox_"]')
          .filter(function () {
            return this.value.length > 0; // filter through TextBox values, returning lengths greather than zero
          }).length; // the total of all non zero length TextBox values in this row
        if (x == 0 && i == 0) {
          hideMenu(table_id.replace("tablex_template", "collapsex_summary"));
        } else if (x == 0 && i > 0) {
          // if the total length of all TextBox values for this row is zero, and this row is not the first row, hide the row
          $(this).hide();
          $(
            "#" +
              table_id.replace("template", "summary") +
              " tbody tr:eq(" +
              row_index +
              ")"
          ).hide();
        } else {
          $(this).show();
          $(
            "#" +
              table_id.replace("template", "summary") +
              " tbody tr:eq(" +
              row_index +
              ")"
          ).show();
          showMenu(table_id.replace("tablex_template", "collapsex_summary"));
        }
        $(this)
          .find('textarea[name*="TextBox_"]')
          .css("width", "100%")
          .css("text-align", "left"); // expand TextBox width to fill table cell
      });
  });

  //function to collapse summary tables
  function hideMenu(elmnt) {
    document.getElementById(elmnt).style.visibility = "collapse"; // collapses table
    var element = document.getElementById(elmnt); // collapses entire div
    element.classList.add("collapse"); // adds class Collapse to div
  }

  //function to show summary tables. Called when text boxes change and on form load
  function showMenu(elmnt) {
    document.getElementById(elmnt).style.visibility = "visible"; //sets visibility state to visibible
    var element = document.getElementById(elmnt); // grab element ID
    element.classList.remove("collapse"); //remove the collapse class if it exists in the event it was previously collapsed and now needs to show.
  }

  function updateTableRows() {
    $("[id^=table_template_]").each(function () {
      $(this)
        .find("tbody tr")
        .each(function (i) {
          var table_id = $(this).closest("table").attr("id"); // this table id
          var row_tr = $(this).closest("table").attr("tr");
          var summaryDiv = table_id.replace("table_template", "table_summary");
          var row_index = $(this).index(); // this row index value
          var x = $(this)
            .find('input[name*="TextBox_"]')
            .filter(function () {
              return this.value.length > 0; // filter through TextBox values, returning lengths greather than zero
            }).length; // the total of all non zero length TextBox values in this row
          if (x == 0 && i == 0) {
            // if text value is 0 and row is 0, then hide table using hideMenu fuction
            hideMenu(table_id.replace("table_template", "collapse_summary"));
          } else if (x == 0 && i > 0) {
            // if the total length of all TextBox values for this row is zero, and this row is not the first row, hide the row
            $(this).hide();
            $(
              "#" +
                table_id.replace("template", "summary") +
                " tbody tr:eq(" +
                row_index +
                ")"
            ).hide();
          } else {
            // if table contains something in the cells then we want the table to show so we will show the template, summary, and tthe summary table
            $(this).show();
            $(
              "#" +
                table_id.replace("template", "summary") +
                " tbody tr:eq(" +
                row_index +
                ")"
            ).show();
            showMenu(table_id.replace("table_template", "collapse_summary")); //show sumary table if table contains any information at all
          } //This section compares TextArea's to perform the same function

          $(this)
            .find('input[name*="TextBox_"]')
            .css("width", "100%")
            .css("text-align", "left"); // expand TextTextArea width to fill table cell
        });
    });

    $("[id^=tablex_template_]").each(function () {
      $(this)
        .find("tbody tr")
        .each(function (i) {
          var table_id = $(this).closest("table").attr("id"); // this table id
          var row_tr = $(this).closest("table").attr("tr");
          var summaryDiv = table_id.replace(
            "tablex_template",
            "tablex_summary"
          );
          var row_index = $(this).index(); // this row index value
          var x = $(this)
            .find('textarea[name*="TextBox_"]')
            .filter(function () {
              return this.value.length > 0; // filter through TextBox values, returning lengths greather than zero
            }).length; // the total of all non zero length TextBox values in this row
          if (x == 0 && i == 0) {
            // if text value is 0 and row is 0, then hide table using hideMenu fuction
            hideMenu(table_id.replace("tablex_template", "collapsex_summary"));
          } else if (x == 0 && i > 0) {
            // if the total length of all TextBox values for this row is zero, and this row is not the first row, hide the row
            $(this).hide();
            $(
              "#" +
                table_id.replace("template", "summary") +
                " tbody tr:eq(" +
                row_index +
                ")"
            ).hide();
          } else {
            // if table contains something in the cells then we want the table to show so we will show the template, summary, and tthe summary table
            $(this).show();
            $(
              "#" +
                table_id.replace("template", "summary") +
                " tbody tr:eq(" +
                row_index +
                ")"
            ).show();
            showMenu(table_id.replace("tablex_template", "collapsex_summary")); //show sumary table if table contains any information at all
          } //This section compares TextArea's to perform the same function

          $(this)
            .find('textarea[name*="TextBox_"]')
            .css("width", "100%")
            .css("text-align", "left"); // expand TextTextArea width to fill table cell
        });
    });
  }

  // Update summary tables when the worksheet loads. Exclude the first two TextBox input fields.
  $("[id^=td_TextBox_]").each(function () {
    // update summary table on page load
    var td_id = this.id;
    var textbox_id = td_id.replace("td_", "");
    if ($("#" + textbox_id).val() != "") {
      $(this).html($("#" + textbox_id).val()); // convert "td_TextBox_" to "TextBox_" and grab the value
    }
    // updateTableRows();
  });

  // Update summary tables in real time as the worksheet is populated by the user.
  $("[id^=TextBox_]").on("change", function () {
    // update summary table <td> on each TextBox input change

    // $('#td_' + this.id).addClass('amended') //This will tag the class with Amended which should add yello highlight to it
    $("#td_" + this.id).css("background", "yellow");

    if (
      $(this).val() == "" &&
      $(this).closest("td").attr("class") == "tac_money"
    ) {
      $("#td_" + this.id).html(""); //removed unknown word to stop filling empty tables with Unknown
    } else {
      $("#td_" + this.id).html($(this).val());
    }
    updateTableRows(); // perform Update Table Rows to collapse or show entire summary tables after textbox is changed
  });

  $("#CheckBox_186_100").each(function () {
    let steppaymentdiv = document.getElementById("ppStepPayment");
    if ($(this).is(":Checked")) {
      steppaymentdiv.classList.remove("collapse");
    } else {
      steppaymentdiv.classList.add("collapse");
    }
  });

  $("#CheckBox_186_100").on("change", function () {
    let steppaymentdiv = document.getElementById("ppStepPayment");

    steppaymentdiv.classList.toggle("collapse");
  });

  // Update summary checkboxs on form load
  $("[id^=CheckBox_]").on("change", function () {
    // update summary table <td> on each TextBox input change
    //  $('#td_' + this.id).addClass('amended') //This will tag the class with Amended which should add yello highlight to it
    $("#td_" + this.id).css("background", "yellow");
    if ($(this).is(":checked")) {
      $("#td_" + this.id).html("X");
    } else {
      $("#td_" + this.id).html("");
    }
  });
  //-->

  // Update summary checkbox tables when the worksheet loads. Exclude the first two TextBox input fields.
  $("[id^=td_CheckBox_]").each(function () {
    // update summary table on page load
    var td_id = this.id;
    var checkbox_id = td_id.replace("td_", "");
    if ($("#" + checkbox_id).is(":checked")) {
      $(this).html("X");
    } else {
      $(this).html(""); // convert "td_TextBox_" to "TextBox_" and grab the value
    }
  });

  $("#collapse_summary_186_66").each(function () {
    showMenu(this.id);
  });

  //Live Updating .on('Change')
  // Show and hide Comment Box text areas when box is checked. If Checked then show CommnetBox
  //If not checked, pass to ShowMenu/HideMenu function to hide or show the menu
  $(
    "#CheckBox_186_900,#CheckBox_186_901,#CheckBox_186_902,#CheckBox_186_903,#CheckBox_186_904,#CheckBox_186_905,#CheckBox_186_906,#CheckBox_186_907,#CheckBox_186_908,#CheckBox_186_909,#CheckBox_186_910,#CheckBox_186_911,#CheckBox_186_912,#CheckBox_186_913,#CheckBox_186_914,#CheckBox_186_915,#CheckBox_186_916, #CheckBox_186_402"
  ).on("change", function () {
    // update summary table <td> on each TextBox input change
    var td_id = this.id; //Get ID of current checkbox script is working on
    var checkbox_id = td_id.replace("CheckBox_186_", "TextBox_186_10"); //replace CheckBox_186_ with TextBox_186_10 for passing DIV ID to Show/Hide function
    var summary_id = td_id.replace("CheckBox_", "td_CommentBox_"); //Replace CheckBox_186_900 with td_CommentBox_186_900    id='td_CommentBox_186_900
    if ($(this).is(":checked")) {
      showMenu(checkbox_id);
      showMenu(summary_id);
    } else {
      hideMenu(checkbox_id);
      hideMenu(summary_id);
    }
  });
  //When worksheet loads update comment box areas that are checked to be shown .each()
  // Show and hide Comment Box text areas when box is checked. If Checked then show CommnetBox
  //If not checked, pass to ShowMenu/HideMenu function to hide or show the menu
  //<div id='td_CommentBox_186_900'><h7>Plan Payment Comments </h7> <strong><h7 id="td_TextBox_186_10900"></h7></strong></div></br>
  $(
    "#CheckBox_186_900,#CheckBox_186_901,#CheckBox_186_902,#CheckBox_186_903,#CheckBox_186_904,#CheckBox_186_905,#CheckBox_186_906,#CheckBox_186_907,#CheckBox_186_908,#CheckBox_186_909,#CheckBox_186_910,#CheckBox_186_911,#CheckBox_186_912,#CheckBox_186_913,#CheckBox_186_914,#CheckBox_186_915,#CheckBox_186_916,#CheckBox_186_402"
  ).each(function () {
    // update summary table on page load
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_186_", "TextBox_186_10");
    var summary_id = td_id.replace("CheckBox_", "td_CommentBox_"); //Replace CheckBox_186_900 with td_CommentBox_186_900    id='td_CommentBox_186_900
    if ($("#" + td_id).is(":checked")) {
      showMenu(checkbox_id);
      showMenu(summary_id);
    } else {
      hideMenu(checkbox_id);
      hideMenu(summary_id);
    }
  });

$("#TextBox_186_3").each(function() {

  let filedDate = $("#TextBox_186_3").val();
  let reversedVal = reverseString(filedDate)
  $("#summ_TextBox_186_3").text(reversedVal)
})

$("#TextBox_186_3").on('change', function() {
  $("#summ_TextBox_186_3").css("background", "yellow");
  let filedDate = $("#TextBox_186_3").val();
  let reversedVal = reverseString(filedDate)
  $("#summ_TextBox_186_3").text(reversedVal)
 
})

////////////////////////////////////////////////////
// BASE CALC ON LOAD FUNCTIONS
///////////////////////////////////////////////////

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

  $("#generateButton").on("click", function () {
    generateNote();
  });


///////////////////////////////////////////////////
// END OF WS_ONLOAD
///////////////////////////////////////////////////
}


function reverseString(str){
    let newDate = new Date(str);
    let convertedDate = newDate.toISOString().slice(0, 10);
    let newArr = convertedDate.split("-");
    let reversedArr = [];
    reversedArr.push(newArr[1],'/',newArr[2],'/',newArr[0]);
    return reversedArr.join("");
};

//take passed in date and return in proper format
function reverseDate(str){
  let newDate = new Date(str);
  let convertedDate = newDate.toISOString().slice(0, 10)
  let reverseDate = convertedDate.split("/").reverse().join("");
  return convertedDate.split("/").reverse().join("")
};

function tac_financial(x) {
  var num = Number(x.toString().replace(/[$,]+/g, ""));
  return num.toLocaleString("en-US", { style: "currency", currency: "USD" });
}

// function called by onChange event to convert entered percentage to float value for visual display
function tac_percentage(x) {
  var num = Number(x.toString().replace(/[%,]+/g, ""));
  return parseFloat(num).toFixed(4) + "%";
}

//Added tac_financial_OnLoad() function for worksheet to update all worksheet fields on worksheet load to be number format.
function tac_financial_OnLoad() {
  // convert numbers entered into TextBox input fields to currency format.
  $(".tac_money")
    .find('input[name*="TextBox_"]')
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

  $(".tac_money")
    .find('input[name*="td_TextBox_"]')
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

//Onload function for updating percentages of tac_percent class called by worksheet
function tac_percentage_OnLoad() {
  // convert numbers entered into TextBox input fields to currency format.
  $(".tac_percent")
    .find('input[name*="TextBox_"]')
    .each(function () {
      // convert TextBox value to currency
      $(this).each(function () {
        if (
          !isNaN($(this).val().toString().replace(/[%]+/g, "")) &&
          $(this).val() != ""
        ) {
          // remove '%' check if the value is a number
          $(this).val(tac_percentage($(this).val())); // if the value is a number, convert it to currency format
        }
      });
    });

  $(".tac_percent")
    .find('input[name*="td_TextBox_"]')
    .each(function () {
      // convert TextBox value to currency
      $(this).each(function () {
        if (
          !isNaN($(this).val().toString().replace(/[%]+/g, "")) &&
          $(this).val() != ""
        ) {
          // remove '%' check if the value is a number
          $(this).val(tac_percentage($(this).val())); // if the value is a number, convert it to currency format
        }
      });
    });
}


function hideCalculatorExtraRows() {
  // console.log('hideCalculatorExtraRows function running')
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




  ////////////////////////
  // End of WS On Load
  ///////////////////////
}


// This will be incorporated into Worskheet41.js
/////////////////////////////
// Calculations
/////////////////////////////
function baseCalc() {
  // console.log('baseCalc() running')
  // get the object which will pull new values from the worksheet
  let baseCalcValues = generateObject();
  //  console.log(baseCalcValues)
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
      // console.log(amounts)
      // console.log(periods)
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
  let currentDate = new Date();
  note +=  ` User: ${document.getElementById('hiddenUserName').innerText} Date: ${currentDate.toLocaleDateString()} <br>\n `
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
  let additionalAmounts = document.querySelectorAll("[id^='TextBox_186_999']");
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
    "[id^='TextBox_186_998']"
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
