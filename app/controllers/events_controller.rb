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
      @event.parent_kind = @event.parent_event.kind
    when 'wall_post'
      @event.receiver_id = params[:user_id].to_i
    end
    
    if @event.save
      case @event.kind
      when 'status'
        Pusher['news_feed'].trigger('new_status', {
          :new_status => (render :partial => "events/feed/new_status", :locals => {:event => @event}),
          :parent => "#feed-items"
        })
      when 'comment'
        Pusher['news_feed'].trigger('new_comment', {
          new_comment: (render :partial => "events/comment", :locals => {:comment => @event}),
          parent: ".comments-of-#{@event.parent_event_id}",
          link: ".load_more_id_#{@event.parent_event_id}"
        })
      when 'wall_post'
        Pusher['news_feed'].trigger('new_wall_post', {
          :new_wall_post => (render :partial => "events/feed/new_wall_post", :locals => {:event => @event}),
          :parent => "#feed-items"
        })
      end
    else
      render nothing: true
    end
  end
  
  def load_comments
    @event = Event.find(params[:event_id])
    @per_page = 50
    @page_num = params[:page].to_i
    @offset = 4 + @per_page * (params[:page].to_i - 1) + params[:offset].to_i
    @end = @offset + @per_page * @page_num > @event.comments.count
    @location = params[:location]
    @comments = @event.comments.order('created_at DESC').paginate(page: @page_num, per_page: @per_page, offset: @offset).reverse
  end
  
  def likers
    @likers = Event.find(params[:event_id]).likers.uniq
  end
  
  def show
    @event = Event.find(params[:id])
    render partial: 'sidebar/event_snippet'
  end
  
end