class LikesController < ApplicationController
  
  def create
    @like = Like.new(params[:like])
    @like.user_id = current_user.id
    @like.event_id = params[:event_id].to_i
    if !Like.find_by_event_id_and_user_id(@like.event_id, @like.user_id) && @like.save
      render 'create'
      Pusher['news_feed'].trigger('new_like', {
        selected_event: "#comment_like_id_#{@like.event_id}",
        like_button: "#comment_id_#{@like.event_id}_like_button",
        unlike_path: event_unlike_path(event_id: @like.event_id),
        count: @like.event.likes.count,
        ul: "#comments-of-#{@like.event_id}",
        likes_bar: (render_to_string :partial => "events/likes_bar", :locals => {:event => @like.event})
      })
    end
  end
  
  def destroy
    @like = Like.find_by_event_id_and_user_id(params[:event_id], current_user.id)
    @event_id = @like.event_id
    if @like.destroy
      Pusher['news_feed'].trigger('new_unlike', {
        selected_event: "#comment_like_id_#{@like.event_id}",
        like_button: "#comment_id_#{@like.event_id}_like_button",
        like_path: event_like_path(event_id: @event_id),
        count: Event.find(@event_id).likes.count,
        likes_bar: "#likes_bar_id_#{@event_id}"
      })
    end
  end
  
end
