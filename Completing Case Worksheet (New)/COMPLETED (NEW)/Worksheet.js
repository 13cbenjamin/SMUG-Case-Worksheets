function wsOnLoad(){ 
    //<!--
    $('textarea').css('white-space' , 'pre-wrap').css('width', '100%');
    $('input[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to TextBox elements
    $('input[name*="CheckBox_"]').addClass("form-check-input"); // add bootstrap form-check-input class to CheckBox elements
    $('textarea[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to CommentBox elements


    const collapseSections = document.querySelectorAll("[data-collapse-area]");

    // On load, collapse all sections
    // $(collapseSections).each(function () {
    //     $(collapseSections).toggleClass("collapse");
    //   });

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
      // Toggle section 214
    $("#section_214_title").on("click", function () {
        $("#section_214_collapse").fadeToggle().toggleClass("collapse");
      }); 
      // Toggle section tax Data
    $("#section_taxdata_title").on("click", function () {
        $("#section_taxdata_collapse").fadeToggle().toggleClass("collapse");
      }); 
      // Toggle section tax Data in plan review
    $("#section_3taxdata_title").on("click", function () {
        $("#section_3taxdata_collapse").fadeToggle().toggleClass("collapse");
      }); 


////////////////////////////////////////////////////////////////
// CHECKBOX ON CLICK FUNCTIONS
///////////////////////////////////////////////////////////////

// SATISIFED BOXES -  When a Satisifed Checkbox is Checked, change closest TR to Green background 
      $("[id^=CheckBox_212_1]").on("click",function () {
        // buttons with class .tac_btnDel when clicked
        //var row_index = $(this).closest("tr"); // this row index value
        var td_id = this.id;
        var checkbox_id = td_id.replace("_1", "_2");
        if ($(this).is(":Checked")) {
            $(this).closest("tr").css("background", "#00AA00"); // change background color
            $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
          } else {
            $(this).closest("tr").css("background", "#FFF"); // change background color
            $("#"+checkbox_id).removeAttr("disabled"); // remove disable on N/A box 
          }
      })

      $("[id^=CheckBox_213_1]").on("click",function () {
        // buttons with class .tac_btnDel when clicked
        //var row_index = $(this).closest("tr"); // this row index value
        var td_id = this.id;
        var checkbox_id = td_id.replace("_1", "_2");
        if ($(this).is(":Checked")) {
            $(this).closest("tr").css("background", "#00AA00"); // change background color
            $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
          } else {
            $(this).closest("tr").css("background", "#FFF"); // change background color
            $("#"+checkbox_id).removeAttr("disabled"); // remove disable on N/A box 
          }
      })
    //   Section X
    $("[id^=CheckBox_213_8]").on("click",function () {
        // buttons with class .tac_btnDel when clicked
        //var row_index = $(this).closest("tr"); // this row index value
        var td_id = this.id;
        var checkbox_id = td_id.replace("_8", "_9");
        if ($(this).is(":Checked")) {
            $(this).closest("tr").css("background", "#00AA00"); // change background color
            $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
          } else {
            $(this).closest("tr").css("background", "#FFF"); // change background color
            $("#"+checkbox_id).removeAttr("disabled"); // remove disable on N/A box 
          }
      })

      // TAX DATA
    $("[id^=CheckBox_214_8]").on("click",function () {
        // buttons with class .tac_btnDel when clicked
        //var row_index = $(this).closest("tr"); // this row index value
        var td_id = this.id;
        var checkbox_id = td_id.replace("_8", "_9");
        if ($(this).is(":Checked")) {
            $(this).closest("tr").css("background", "#00AA00"); // change background color
            $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
          } else {
            $(this).closest("tr").css("background", "#FFF"); // change background color
            $("#"+checkbox_id).removeAttr("disabled"); // remove disable on N/A box 
          }
      })

  $("[id^=CheckBox_214_1]").on("click",function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("_1", "_2"); // get N/A box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#00AA00"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked

      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on N/A box 
      }
  })

// N/A BOXES -  When a N/A Checkbox is Checked, change closest TR to Grey background 
  $("[id^=CheckBox_212_2]").on("click",function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_212_2", "CheckBox_212_1"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#C0C0C0"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked

      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
  })

  $("[id^=CheckBox_213_2]").on("click",function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_213_2", "CheckBox_213_1"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#C0C0C0"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
  })
//   Section X
$("[id^=CheckBox_213_9]").on("click",function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_213_9", "CheckBox_213_8"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#C0C0C0"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
  })
  // Tax data
$("[id^=CheckBox_214_9]").on("click",function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_214_9", "CheckBox_214_8"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#C0C0C0"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } else {
        $(this).closest("tr").css("background", "#FFF"); // change background color
        $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
      }
  })

$("[id^=CheckBox_214_2]").on("click",function () {
// buttons with class .tac_btnDel when clicked
//var row_index = $(this).closest("tr"); // this row index value
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_214_2", "CheckBox_214_1"); // get satisifed box ID from This ID 
if ($(this).is(":Checked")) {
    $(this).closest("tr").css("background", "#C0C0C0"); // change background color
    $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked

  } else {
    $(this).closest("tr").css("background", "#FFF"); // change background color
    $("#"+checkbox_id).removeAttr("disabled"); // remove disable on Satisfied box 
  }
})

////////////////////////////////////////////////////////////////
// CHECKBOX ON LOAD FUNCTIONS
///////////////////////////////////////////////////////////////

$("[id^=CheckBox_212_1]").each(function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("_1", "_2");
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#00AA00"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
      }
  })

$("[id^=CheckBox_213_1]").each(function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("_1", "_2");
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#00AA00"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
      } 
  })
  // Section X
  $("[id^=CheckBox_213_8]").each(function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("_8", "_9");
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#00AA00"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
      } 
  })

$("[id^=CheckBox_214_1]").each(function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("_1", "_2"); // get N/A box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#00AA00"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the N/A Box to prevent both from being checked
      } 
  })

$("[id^=CheckBox_212_2]").each(function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_212_2", "CheckBox_212_1"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#C0C0C0"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked

      } 
      
      
  })

$("[id^=CheckBox_213_2]").each(function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_213_2", "CheckBox_213_1"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#C0C0C0"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
  })

//   Section X
$("[id^=CheckBox_213_9]").each(function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
    var td_id = this.id;
    var checkbox_id = td_id.replace("CheckBox_213_9", "CheckBox_213_8"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#C0C0C0"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
  })

$("[id^=CheckBox_214_2]").each(function () {
    // buttons with class .tac_btnDel when clicked
    //var row_index = $(this).closest("tr"); // this row index value
        //var row_index = $(this).closest("tr"); // this row index value
        var td_id = this.id;
        var checkbox_id = td_id.replace("CheckBox_214_2", "CheckBox_214_1"); // get satisifed box ID from This ID 
    if ($(this).is(":Checked")) {
        $(this).closest("tr").css("background", "#C0C0C0"); // change background color
        $("#"+checkbox_id).attr("disabled", true); // Disable the Satisfied Box to prevent both from being checked
      } 
    })

}