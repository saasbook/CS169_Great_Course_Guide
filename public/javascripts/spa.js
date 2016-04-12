$(function() {
  $('.mainContent').addClass('fadeIn');

  $(window).on('beforeunload', function() {
    $('.mainContent').removeClass('fadeIn').addClass('fadeOut');
  });
});
