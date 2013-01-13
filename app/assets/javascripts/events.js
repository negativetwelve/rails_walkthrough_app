$(document).ready(function() {
  
  $('.comment-input').live("keydown", function(e) {
    if (e.keyCode == 13 && !e.shiftKey) {
      if (this.value.match("^\\s*$") == null) {
        var parent = '#new_comment_form_' + $(this).data('id');
        $(parent).submit();
        e.preventDefault();
        this.value = '';
      } else {
        e.preventDefault();
      }
    }
  });
  
  $("#new_event").live("ajax:beforeSend", function(event, xhr, status) {
    $('#new_status')[0].value = '';
  });
  
  $('.comment_like_button').live("ajax:success", function(event, xhr, status) {
    var like_button = "#comment_id_" + String(this.dataset.id) + "_like_button";
    var word;
    if (this.text == "Unlike") {
      word = "Like";
    } else {
      word = "Unlike";
    }
    $(like_button)[0].innerHTML = word;
    $(like_button)[0].href = '/events/' + String(this.dataset.id) + '/' + word.toLowerCase();
  });
  
});