var first_name = null;
var last_name = null;
var email = null;
var selected_classes = [];
alert = swal;

$(function () {
  $("#continue").click(function() {

    first_name = $('#first_name').val();
    last_name = $('#last_name').val();
    email = $('#email').val();

    if (first_name == "" || last_name == "" || email == "") {
      alert("Oops", "Please fill-in all fields.", "error");
      return
    }

    $('#details-form').removeClass("slideInUp").addClass("fadeOutLeft")
    setTimeout(function() {
      $('#details-form').addClass("hide")
      $('#class-form').addClass("animated fadeInRight").removeClass("hide");
    }, 400);
  });

  $('#addClass').click(function() {
    var item = $('#class-search');
    value = item.val();

    if ($.inArray(value, all_classes) == -1) {
      alert("Oops", "That isn't a valid class.", "error");
      return;
    }

    if (value == "") {
      alert("Oops", "Please select a class.", "error");
      return
    }

    if ($.inArray(value, selected_classes) !== -1) {
      alert("Oops", "Class already added.", "error");
      return
    }

    item.val(""); // Clear textfield
    var list = $('#selected-classes');
    var class_selections = $('#class-selections');
    if (value != "" && $.inArray(value, selected_classes) == -1) {
      list.append("<li class='collection-item'>" + value + "</li>");
      class_selections.append("<option value='" + value + "' selected>" + value + "</option>");
      selected_classes.push(value);
    } else {
      alert("");
    }
  });

  // Getting All Courses
  var all_classes = null;
  $.get("/courses/all", function(data) {
    all_classes = JSON.parse(data);
  });

  var input = document.getElementById("class-search");
  //var all_classes = ["EE16A", "EE16B", "CS61A", "CS61B", "CS61C", "CS70", "CS169", "CS188"]
  new Awesomplete(input, {
    list: all_classes
  });
});
