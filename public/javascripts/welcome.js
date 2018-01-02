var first_name = null;
var last_name = null;
var email = null;
var selected_classes = [];
alert = swal;

$(function () {
  function validateEmail(email) {
    var regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (regex.test(email))
      $.get("/users/email/?email=" + email.toString(), function(data) {
        if (!data.resp) {
          alert("Oops", "Please enter a valid and unique email.", "error");
          return;
        } else {
          $('#details-form').removeClass("slideInUp").addClass("fadeOutLeft")
          setTimeout(function() {
              $('#details-form').addClass("hide")
              $('#class-form').removeClass("fadeOutRight").addClass("animated fadeInRight").removeClass("hide");
          }, 400);
        }
      });
  }

  // Make welcome page work without JS by default
  var first_name_label = $('<label for="first_name">First Name</label>');
  var last_name_label = $('<label for="last_name">Last Name</label>');
  var email_label = $('<label data-error="wrong" data-success="right" for="email">Email</label>');
  first_name_label.insertAfter('#first_name');
  last_name_label.insertAfter('#last_name');
  email_label.insertAfter('#email');

  var continue_button = $('<input class="btn blue waves-effect waves-light" id="continue" type="button" value="Continue"></input>');
  continue_button.insertBefore('#submit_nojs');
  $('#submit_nojs').hide();
  // End

  $('#selected-classes').addClass("hide");
  $("#continue").click(function() {
    first_name = $('#first_name').val();
    last_name = $('#last_name').val();
    email = $('#email').val();

    if (first_name == "" || last_name == "" || email == "") {
        alert("Oops", "Please fill-in all fields.", "error");
        return;
    }
    validateEmail(email);
  });

  $('#addClass').click(function() {
    $('#selected-classes').removeClass("hide")
    var item = $('#class-search');
    value = item.val()
    if (value === "") {
      alert("Oops", "Please select a class.", "error");
      return
    }
    if ($.inArray(value, all_classes) == -1) {
      value = item.data('oldVal');
      if ($.inArray(value, all_classes) == -1) {
        alert("Oops", "That isn't a valid class.", "error");
        return;
      }
    }
    if ($.inArray(value, selected_classes) !== -1) {
      alert("Oops", "Class already added.", "error");
      return
    }

    item.val(""); // Clear textfield
    item.removeData('oldVal')
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

  $('#class-search').each(function() {
    var elem = $(this);
    elem.bind("keyup", function(event){
      if (elem.val().length >= 2) {
        value = $("li[aria-selected='true']")
        elem.data('oldVal', value.text())
      }
    });
  });

  $('#class-search').keypress(function(e) {
    if (e.which == 13) {
      $('#addClass').click();
      $('#class-search').removeData('oldVal');
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
