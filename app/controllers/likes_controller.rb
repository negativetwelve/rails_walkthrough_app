class LikesController < ApplicationController
  
  def create
    @like = Like.new(params[:like])
    @like.user_id = current_user.id
    @like.event_id = params[:event_id].to_i
    if !Like.find_by_event_id_and_user_id(@like.event_id, @like.user_id) && @like.save
      case @like.event.kind
      when 'status', 'wall_post'
        Pusher['news_feed'].trigger('new_status_like', {
          selected_event: "#comment_like_id_#{@like.event_id}",
          count: @like.event.likes.count,
          ul: "#action_bar_of_#{@like.event_id}",
          likes_bar: (render_to_string :partial => "events/likes_bar", :locals => {:event => @like.event}),
          event_id: @like.event_id
        })
      when 'comment'
        Pusher['news_feed'].trigger('new_comment_like', {
          selected_event: "#comment_like_id_#{@like.event_id}",
          count: @like.event.likes.count,
          thumbs_up: (render_to_string :partial => "events/comment_like", :locals => {:comment => @like.event}),
          parent: "#comment_likes_parent_#{@like.event_id}"
        })
      end
    end
    render nothing: true
  end
  
  def destroy
    @like = Like.find_by_event_id_and_user_id(params[:event_id], current_user.id)
    @event_id = @like.event_id
    if @like.destroy
      case @like.event.kind
      when 'status', 'wall_post'
        Pusher['news_feed'].trigger('new_status_unlike', {
          selected_event: "#comment_like_id_#{@like.event_id}",
          count: Event.find(@event_id).likes.count,
          likes_bar: "#likes_bar_id_#{@event_id}"
        })
      when 'comment'
        Pusher['news_feed'].trigger('new_comment_unlike', {
          selected_event: "#comment_like_id_#{@event_id}",
          count: Event.find(@event_id).likes.count,
          thumbs_up: "#comment_likes_id_#{@event_id}"
        })
      end
    end
    render nothing: true
  end
  
end
