module ApplicationHelper

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end
  
  def login_page?
    request.fullpath == '/login'
  end
  
  def link_to_like_button(event)
    link_to('Like',
            event_like_path(event_id: event.id),
            remote: true,
            id: "comment_id_#{event.id}_like_button",
            class: "comment_like_button",
            data: {id: event.id})
  end
  
  def link_to_unlike_button(event)
    link_to('Unlike',
            event_unlike_path(event_id: event.id),
            remote: true,
            id: "comment_id_#{event.id}_like_button",
            class: "comment_like_button",
            data: {id: event.id})
  end
  
  def link_to_more_comments(event, offset, page)
    link_to('View previous comments', {controller: 'events', action: 'load_comments', offset: offset, page: page, event_id: event.id}, remote: true, id: "load_more_id_#{event.id}")
  end
  
end
