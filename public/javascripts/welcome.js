var first_name = null;
var last_name = null;
var email = null;
var selected_classes = [];
alert = swal;

$(function () {
  var all_emails = [];
  function validateEmail(email) {
    var regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return regex.test(email) && all_emails.indexOf(email) < 0;
  }
  $.get("/users/all", function(data) {
    all_emails = JSON.parse(data);
  });

  $('#selected-classes').addClass("hide")
  $("#continue").click(function() {

    first_name = $('#first_name').val();
    last_name = $('#last_name').val();
    email = $('#email').val();

    if (!validateEmail(email)) {
      alert("Oops", "Please enter a valid and unique email.", "error")
      return
    }

    if (first_name == "" || last_name == "" || email == "") {
      alert("Oops", "Please fill-in all fields.", "error");
      return
    }

    $('#details-form').removeClass("slideInUp").addClass("fadeOutLeft")
    setTimeout(function() {
      $('#details-form').addClass("hide")
      $('#class-form').removeClass("fadeOutRight").addClass("animated fadeInRight").removeClass("hide");
    }, 400);
  });

  $('#addClass').click(function() {
    $('#selected-classes').removeClass("hide")
    var item = $('#class-search');
    value = item.val();

    if (value === "") {
      alert("Oops", "Please select a class.", "error");
      return
    }
    if ($.inArray(value, all_classes) == -1) {
      alert("Oops", "That isn't a valid class.", "error");
      return;
    }
    if ($.inArray(value, selected_classes) !== -1) {
      alert("Oops", "Class already added.", "error");
      return
    }

    item.val(""); // Clear textfield
    var list = $('#selected-classes');
    var class_selections = $('#class-selections');
    if ($.inArray(value, selected_classes) == -1) {
      list.append("<li class='collection-item'>" + value + "</li>");
      class_selections.append("<option value='" + value + "' selected>" + value + "</option>");
      selected_classes.push(value);
      var i = all_classes.indexOf(value);
      if(i != -1) {
        all_classes.splice(i, 1);
      }
    }
  });

  $('#class-search').keypress(function(e) {
    if (e.which == 13) {
      $('#addClass').click();
      return false;
    }
  });

  $('#first_name, #last_name, #email').keypress(function (e) {
    if (e.which == 13) {
      $('#continue').click();
      return false;
    }
  });

  $('#back').click(function() {
    $('#class-form').addClass("fadeOutRight");
    setTimeout(function() {
      $('#class-form').addClass("hide");
      $('#details-form').removeClass("fadeOutLeft").addClass("animated fadeInLeft").removeClass("hide");
    }, 400);
  });

  // Getting All Courses
  var all_classes = [];
  $.get("/courses/all", function(data) {
    data = JSON.parse(data);
    for (var i = 0; i < data.length; i++) {
      all_classes.push(data[i]["number"] + ": " + data[i]["title"]);
    }
  });

  var input = document.getElementById("class-search");
  if (input != null) {
    new Awesomplete(input, {
      list: all_classes,
      autoFirst: true
    });
  };
});
