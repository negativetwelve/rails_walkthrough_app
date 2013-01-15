class PagesController < ApplicationController
  
  def home
    if signed_in?
      @events = Event.where("kind IN('status', 'wall_post')").
                      paginate(page: params[:page], per_page: 30).
                      order('created_at DESC')
    else
      @user = User.new
    end
  end
  
end