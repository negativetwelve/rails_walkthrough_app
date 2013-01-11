class PagesController < ApplicationController
  
  def home
    if signed_in?
      @events = Event.where(kind: 'status').order('created_at DESC')
    else
      @user = User.new
    end
  end
  
end