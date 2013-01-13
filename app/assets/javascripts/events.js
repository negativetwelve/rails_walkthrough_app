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
  
});