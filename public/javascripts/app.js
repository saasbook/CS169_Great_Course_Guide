$(function() {
  $(".sidenav-overlay").click(function() {
    $(".button-collapse").sideNav('hide')
  });

  $(".dropdown-button").dropdown({hover: true, belowOrigin: true});
  $(".button-collapse").sideNav({
    edge: 'left',
    closeOnClick: 'true'
  });
  $('.collapsible').collapsible();
});
