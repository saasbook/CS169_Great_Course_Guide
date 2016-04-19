$(function() {
  var filters = {"cs": $("#cs"), "ee": $("#ee"), "upper": $("#upper"), "lower": $("#lower")}
  $("#show-filters").change(function() {
  	$('.EE_UPPER_DIV').hide();
  	$('.EE_LOWER_DIV').hide();
  	$('.CS_LOWER_DIV').hide();
  	$('.CS_UPPER_DIV').hide();
  	var cs = filters["cs"].is(':checked');
  	var lower = filters["lower"].is(':checked');
  	var ee = filters["ee"].is(':checked');
  	var upper = filters["upper"].is(':checked');
  	if (cs) {
  		if (lower) {
  			$('.CS_LOWER_DIV').show();
  		}
  		if (upper) {
  			$('.CS_UPPER_DIV').show();
  		}
  	}
  	if (ee) {
  		if (lower) {
  			$('.EE_LOWER_DIV').show();
  		}
  		if (upper) {
  			$('.EE_UPPER_DIV').show();
  		}
  	}
  });

  // Fixed Scrolling
  scrollDivWithPage = function() {
    if ($(window).width() <= 950) {
      $('#show-filters').removeAttr('style');
      $('#show-all').removeAttr('style');
    } else {
      var containerWidth = $('.container').width()
      $('#show-filters').css({'position': 'fixed', 'top': '64px', 'width': 180});
      var filterWidth = $('#show-filters').width()
      $('#show-all').css({'position': 'absolute', 'top': '64px', 'margin-left': (filterWidth + 10).toString() + 'px', 'width': containerWidth - filterWidth - 10});
    }
  }
  $(window).resize(scrollDivWithPage);
  scrollDivWithPage();

  $('#saveInFilter').click(function() {
    $('#save').click();
  });

});
