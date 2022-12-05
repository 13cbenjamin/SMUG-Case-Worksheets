function wsOnLoad() {
    // updated 1/2022 to add toFixed(4) for percent values instead of toFixed(3)
    // updated 2/2022 to remove Pickaday dropdown. 
    // V3 - Collappse Added and validation implemented
  
    //import my custom CSS file
    $("head").append(
      '<link rel="stylesheet" type="text/css" href="tac_styles/tac_style.css"/>'
    );
    $("head").append(
      '<link rel="stylesheet" type="text/css" href="tac_styles/pikaday.css"/>'
    );
    // $('head').append('<link rel="stylesheet" type="text/css" href="tac_styles/jquery-ui.css"/>');
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
  
    // $('.ui-datepicker-calendar').css('display', 'none');
  
    //add stepPayment and date-picker clasd to all of the fiels
    $(
      "#TextBox_186_4001,#TextBox_186_4011,#TextBox_186_4021,#TextBox_186_4031,#TextBox_186_4041,#TextBox_186_4002,#TextBox_186_4012,#TextBox_186_4022,#TextBox_186_4032,#TextBox_186_4042"
    ).addClass("stepPayment");
  
    //get all data-collapse-area titles into a single variable.
    const collapseSections = document.querySelectorAll("[data-collapse-area]");
  
    // var picker = new Pikaday({ field: $("#TextBox_186_4001")[0] });
    // var picker02 = new Pikaday({ field: $("#TextBox_186_4002")[0] });
    // var picker2 = new Pikaday({ field: $("#TextBox_186_4011")[0] });
    // var picker3 = new Pikaday({ field: $("#TextBox_186_4021")[0] });
    // var picker4 = new Pikaday({ field: $("#TextBox_186_4031")[0] });
    // var picker5 = new Pikaday({ field: $("#TextBox_186_4041")[0] });
    // var picker6 = new Pikaday({ field: $("#TextBox_186_4012")[0] });
    // var picker7 = new Pikaday({ field: $("#TextBox_186_4022")[0] });
    // var picker8 = new Pikaday({ field: $("#TextBox_186_4032")[0] });
    // var picker9 = new Pikaday({ field: $("#TextBox_186_4042")[0] });
  
    // $(
    //   "#TextBox_186_4001,#TextBox_186_4011,#TextBox_186_4021,#TextBox_186_4031,#TextBox_186_4041,#TextBox_186_4002,#TextBox_186_4012,#TextBox_186_4022,#TextBox_186_4032,#TextBox_186_4042"
    // ).on("change", function (e) {
    //   //var date, day, month, newYear, value, year;
    //   // let check = /[19..]/g;
    //   value = e.target.value;
    //  // console.log(value);
    //   // if (value.match(check)) {
    //   //   date = e.target.value.split(" ");
    //   //   month = date[1];
    //   //   day = date[2];
    //   //   year = date[3];
  
    //   //   let newYear = year.toString().replace(/^19/g, "20");
    //   //   let space = " ";
  
    //   //   e.target.value =
    //   //     date[0] + space + date[1] + space + date[2] + space + newYear;
    //   // }
    //   $(
    //     "#TextBox_186_4001,#TextBox_186_4011,#TextBox_186_4021,#TextBox_186_4031,#TextBox_186_4041,#TextBox_186_4002,#TextBox_186_4012,#TextBox_186_4022,#TextBox_186_4032,#TextBox_186_4042"
    //   ).each(function () {
    //     // loop through each TextBox in this row
    //     var element = document.getElementById(this.id);
    //     console.log(element);
    //     var event;
    //     if (typeof Event === "function") {
    //       // non IE browsers
    //       event = new Event("change");
    //     } else {
    //       // IE
    //       event = document.createEvent("Event");
    //       event.initEvent("change", true, true);
    //     }
    //     element.dispatchEvent(event); // trigger the TextBox onchange() event. required to update worksheet sql tables
    //   });
    // });
  
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
          var row_tr = $(this).closest("table").attr("tr");
          var summaryDiv = table_id.replace("table_template", "table_summary");
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
  }
  
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
  
  function steppaymentcalc() {
    let month1 = parseInt($("#TextBox_186_4001").val());
    let amount1 = getNumber($("#TextBox_186_4002").val());
    let total1 = document.getElementById("TextBox_186_4003");
    let td_total1 = document.getElementById("td_TextBox_186_4003");
    total1.value = calc(month1, amount1);
    td_total1.value = calc(month1, amount1);
  
    let month2 = parseInt($("#TextBox_186_4011").val());
    let amount2 = getNumber($("#TextBox_186_4012").val());
    let total2 = document.getElementById("TextBox_186_4013");
    let td_total2 = document.getElementById("td_TextBox_186_4013");
    total2.value = calc(month2, amount2);
    td_total2.value = calc(month2, amount2);
  
    let month3 = parseInt($("#TextBox_186_4021").val());
    let amount3 = getNumber($("#TextBox_186_4022").val());
    let total3 = document.getElementById("TextBox_186_4023");
    let td_total3 = document.getElementById("td_TextBox_186_4023");
    total3.value = calc(month3, amount3);
    td_total3.value = calc(month3, amount3);
  
    let month4 = parseInt($("#TextBox_186_4031").val());
    let amount4 = getNumber($("#TextBox_186_4032").val());
    let total4 = document.getElementById("TextBox_186_4033");
    let td_total4 = document.getElementById("td_TextBox_186_4033");
    total4.value = calc(month4, amount4);
    td_total4.value = calc(month4, amount4);
  
    let month5 = parseInt($("#TextBox_186_4041").val());
    let amount5 = getNumber($("#TextBox_186_4042").val());
    let total5 = document.getElementById("TextBox_186_4043");
    let td_total5 = document.getElementById("td_TextBox_186_4043");
    total5.value = calc(month5, amount5);
    td_total5.value = calc(month5, amount5);
  
    let grandTotal = document.getElementById("TextBox_186_4055");
    let td_GrandTotal = document.getElementById("td_TextBox_186_4055");
    grandTotal.value = grandtotalCalc(
      getNumber(total1.value),
      getNumber(total2.value),
      getNumber(total3.value),
      getNumber(total4.value),
      getNumber(total5.value)
    );
    td_GrandTotal.value = grandtotalCalc(
      getNumber(total1.value),
      getNumber(total2.value),
      getNumber(total3.value),
      getNumber(total4.value),
      getNumber(total5.value)
    );
  
    function getNumber(n) {
      return Number(n.replace(/[^0-9.-]+/g, ""));
    }
  
    function calc(a, b) {
      if (a != "" && b != "") {
        return (a * b).toLocaleString("en-US", {
          style: "currency",
          currency: "USD",
        });
      }
      return 0;
    }
  
    function grandtotalCalc(a, b, c, d, e) {
      return (a + b + c + d + e).toLocaleString("en-US", {
        style: "currency",
        currency: "USD",
      });
    }
  }