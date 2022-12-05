function toggle4(showHideDiv, switchImgTag) {
    var ele = document.getElementById(showHideDiv);
    var imageEle = document.getElementById(switchImgTag);
    if(ele.style.display == "block") {
        ele.style.display = "none";
        imageEle.innerHTML = '<img style="padding: 2 0 0 0;height:20px;width:20px;" src="images/tac_plus.png">';
    }
    else {
        ele.style.display = "block";
        imageEle.innerHTML = '<img style="padding: 2 0 0 0;height:20px;width:20px;" src="images/tac_minus.png">';
    }
};
function toggle5(showHideDiv, switchImgTag) {
    var ele = document.getElementById(showHideDiv);
    var imageEle = document.getElementById(switchImgTag);
    if(ele.style.display == "block") {
        ele.style.display = "none";
        imageEle.innerHTML = '<img style="padding: 2 0 0 0;" src="images/tac_plus.png">';
    }
    else {
        ele.style.display = "block";
        imageEle.innerHTML = '<img style="padding: 2 0 0 0;" src="images/tac_minus.png">';
    }
};
function payeeURL(docs) {
  var opened = window.open("",replace=true);
  var url = docs;
  opened.document.body.innerHTML = "<html><head><title>Linked Documents</title></head><body>" + url + "</body></html>";
  opened.focus();
  window.onbeforeunload = function() {
      opened.close();
  };
};
function round(value, decimals) {
  return Number(Math.round(value+'e'+decimals)+'e-'+decimals);
};