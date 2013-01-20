module ApplicationHelper

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end
  
  def login_page?
    request.fullpath == '/login'
  end
  
  def link_to_like_button(event, location)
    link_to('Like',
            event_like_path(event_id: event.id, location: location),
            remote: true,
            class: "comment_like_button comment_id_#{event.id}_like_button",
            data: {id: event.id})
  end
  
  def link_to_unlike_button(event)
    link_to('Unlike',
            event_unlike_path(event_id: event.id),
            remote: true,
            class: "comment_like_button comment_id_#{event.id}_like_button",
            data: {id: event.id})
  end
  
  def link_to_more_comments(event, location, offset, page)
    link_to("View all #{event.comments.count} comments", {controller: 'events', action: 'load_comments', location: location, offset: offset, page: page, event_id: event.id}, remote: true, class: "load_more_id_#{event.id}", data: {location: location})
  end
  
end
