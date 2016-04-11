$(document).ready(function () {
  $('.wp-reveal').on('click', function() {
    console.log('reveal menu')
    $('.wp-collapse').slideToggle();
  })
});