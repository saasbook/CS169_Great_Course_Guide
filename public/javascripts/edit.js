$(function() {
  $(".takenBox").change(function() {
    var split = this.id.split("-");
    $("#" + split[0] + "-choice").prop('checked', true);
  });

  $(".addBox").change(function() {
    var split = this.id.split("-");
    $("#" + split[0] + "-taken").prop('checked', false);
  });

  $('#saveInFilter').click(function() {
    $('#save').click();
  });
});
