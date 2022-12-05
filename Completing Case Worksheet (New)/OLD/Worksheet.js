function wsOnLoad(){ 
    //<!--
    $('head').append('<link rel="stylesheet" type="text/css" href="tac_styles/tacwscss.css"/>');
    $('body').append('<script type="text/javascript" src="tac_scripts/tacwsscript.js"><\/script>');
    $('body').css('background-image', 'url("/13Software_app_tac/images/gplaypattern.png")');
    $('textarea').css('white-space' , 'pre-wrap').css('width', '100%');
    $('input[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to TextBox elements
    $('input[name*="CheckBox_"]').addClass("form-check-input"); // add bootstrap form-check-input class to CheckBox elements
    $('textarea[name*="TextBox_"]').addClass("form-control"); // add bootstrap form-control class to CommentBox elements
    $('table').find('input[name*="TextBox_"]').css('width', '100%').css('text-align', 'left'); // expand TextBox width to fill table cell
    $('table').find('caption').css('color', '#000000'); // change table caption to black 
    //-->
}
function tac_checkAll() {
    var a = $('input[name*="CheckBox_144_90"]');
    if(a.length == a.filter(":checked").length){
        $('input[name*="CheckBox_144_90"]').attr('checked', false).each(function(){ // loop through checkboxes with IDs beginning with CheckBox_144_90 
            document.getElementById($(this).attr('id')).onclick(); 
    }); 
    }
    else{
        $('input[name*="CheckBox_144_90"]').attr('checked', true).each(function(){ // loop through checkboxes with IDs beginning with CheckBox_144_90 
            document.getElementById($(this).attr('id')).onclick(); 
    }); 
    }
};