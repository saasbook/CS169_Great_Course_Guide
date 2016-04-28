$(function() {
  console.log("Hello World");

  $(".takenBox").change(function() {
    var checked = $(this).is(":checked");
    var split = this.id.split("-");
    var courseNumber = split[1];
    if (checked) {
      $("#" + courseNumber + "-sp17-row").addClass('hide');
    } else {
      $("#" + courseNumber + "-sp17-row").removeClass('hide');
    }
  });

});
