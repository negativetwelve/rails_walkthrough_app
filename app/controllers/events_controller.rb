class EventsController < ApplicationController

  def new
  end
  
  def create
    @event = Event.new(params[:event])
    @user = current_user
    @event.user_id = @user.id
    @event.kind = params[:kind]
    
    case @event.kind
    when 'status'
    when 'comment'
      @event.parent_event_id = params[:parent_event_id].to_i
    end
    
    if @event.save
      case @event.kind
      when 'status'
        Pusher['news_feed'].trigger('new_status', {
          :new_status => (render :partial => "events/new_status", :locals => {:event => @event}),
          :parent => "#feed-items"
        })
      when 'comment'
        Pusher['news_feed'].trigger('new_comment', {
          new_comment: (render :partial => "events/comment", :locals => {:comment => @event}),
          parent: "#comments-of-#{@event.parent_event_id}"
        })
      end
    end
  end
  
  def load_comments
    @event = Event.find(params[:event_id])
    @per_page = 25
    @page_num = params[:page].to_i
    @offset = 4 + @per_page * (params[:page].to_i - 1)
    @comments = @event.comments.order('created_at DESC').paginate(page: @page_num, per_page: @per_page, offset: @offset).reverse
  end
  
end