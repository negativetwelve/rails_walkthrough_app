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
      flash[:success] = 'Status update posted!'
      redirect_to root_path
    else
      render 'new'
    end
  end
end
