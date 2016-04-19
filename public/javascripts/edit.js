$(function() {
  $(".takenBox").change(function() {
    var split = this.id.split("-");
    $("#" + split[0] + "-choice").prop('checked', true);
  });

  $(".addBox").change(function() {
    var split = this.id.split("-");
    $("#" + split[0] + "-taken").prop('checked', false);
  });
  var filters = {"cs": $("#cs"), "ee": $("#ee"), "upper": $("#upper"), "lower": $("#lower")}
  $("#filters").change(function() {
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
      $('#filters').removeAttr('style');
      $('#selections').removeAttr('style');
    } else {
      var containerWidth = $('.container').width()
      $('#filters').css({'position': 'fixed', 'top': '64px', 'width': 180});
      var filterWidth = $('#filters').width()
      $('#selections').css({'position': 'absolute', 'top': '64px', 'margin-left': (filterWidth + 10).toString() + 'px', 'width': containerWidth - filterWidth - 10});
    }
  }
  $(window).resize(scrollDivWithPage);
  scrollDivWithPage();

  $('#saveInFilter').click(function() {
    $('#save').click();
  });

});
