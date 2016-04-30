$(function() {

  $('#test').change(function() {
    console.log("Card has changed");

    var ee = $('#ee').is(":checked");
    var cs = $('#cs').is(":checked");
    var lower = $('#lower').is(":checked");
    var upper = $('#upper').is(":checked");
    var grad = $('#grad').is(":checked");
    var token = $('#authenticity_token').val();
    console.log(token);

    $.ajax({
      method: "POST",
      url: "/updateFilters",
      data: { filter_settings: {"ee": ee, "cs": cs, "lower": lower, "upper": upper, "grad": grad},
              "authenticity_token": token}
    });
  });
});
