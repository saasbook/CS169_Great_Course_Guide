$(function() {
  var filters = {"cs": $("#cs"), "ee": $("#ee"), "upper": $("#upper"), "lower": $("#lower"), "grad": $("#grad")}
  $("#filters").change(function() {
    $("tr").hide()
    console.log("hooplay");
    var cs = filters["cs"].is(':checked');
    var lower = filters["lower"].is(':checked');
    var ee = filters["ee"].is(':checked');
    var upper = filters["upper"].is(':checked');
    var grad = filters["grad"].is(':checked');
    if (cs) {
      if (lower) {
        $('.CS_LOWER_DIV').show();
      }
      if (upper) {
        $('.CS_UPPER_DIV').show();
      }
      if (grad) {
        $('.CS_GRAD').show();
      }
    }
    if (ee) {
      if (lower) {
        $('.EE_LOWER_DIV').show();
      }
      if (upper) {
        $('.EE_UPPER_DIV').show();
      }
      if (grad) {
        $('.EE_GRAD').show();
      }
    }
  });

  // Fixed Scrolling
  scrollDivWithPage = function() {
    if ($(window).width() <= 950) {
      $('#filters').removeAttr('style');
      $('#selections').removeAttr('style');
      $('#filterDivider').css({"margin-top": "0px",  "margin-bottom": "30px"});
    } else {
      var containerWidth = $('.container').width()
      $('#filters').css({'position': 'fixed', 'top': '64px', 'width': 180});
      var filterWidth = $('#filters').width()
      $('#selections').css({'position': 'absolute', 'top': '64px', 'margin-left': (filterWidth + 10).toString() + 'px', 'width': containerWidth - filterWidth - 10});
      $('#filterDivider').css({"margin-top": "30px",  "margin-bottom": "20px"});
    }
  }
  $(window).resize(scrollDivWithPage);
  scrollDivWithPage();


});
