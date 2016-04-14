$(function() {

  $(window).bind("pageshow", function(event) {
    if (event.originalEvent.persisted) {
      $('.mainContent').removeClass('fadeOut').addClass('fadeIn')
    }
  });
  $('.mainContent').addClass('fadeIn');

  $(window).on('beforeunload', function() {
    $('.mainContent').removeClass('fadeIn').addClass('fadeOut');
  });
});
