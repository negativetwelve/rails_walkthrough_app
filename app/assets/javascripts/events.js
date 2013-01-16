$(document).ready(function() {
  
  $('.comment_input').live("keydown", function(e) {
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

function show_status() {
  $('#home_page_update .update_form').hide();
  $('#home_page_update #status_update_form').show();
};
  
function show_uploader() {
  $('#home_page_update .update_form').hide();
  $('#home_page_update #upload_photos_form').show();
};
  
function show_status_submit() {
  $('#status_submit_button').show();
};

function show_comment_box(event_id) {
  var comment_box = "#comment-box-" + event_id + " .comment_wrapper";
  $(comment_box).fadeIn('fast');
  $(comment_box + " #event_body").focus();
};