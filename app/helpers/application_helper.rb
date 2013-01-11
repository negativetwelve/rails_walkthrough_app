module ApplicationHelper

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end
  
  def login_page?
    request.fullpath == '/login'
  end
  
end
