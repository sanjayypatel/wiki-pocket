
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
      sidebar.css("min-height", "10px");
    } else {
      sidebar.css("min-height", $(document).height() + 60);
  }
}