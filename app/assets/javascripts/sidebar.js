
var ready = function() {
    // run test on initial page load
    checkSize();

    // run test on resize of the window
    $(window).resize(checkSize);
};

$(document).ready(ready);
$(document).on('page:load', ready);

function checkSize(){
  var sidebar = $(".sidebar");
    if (sidebar.css("float") == "none" ){
        sidebar.height(60);
    } else {
      sidebar.height(60);
      sidebar.height($(document).height() + 60);
  }
}