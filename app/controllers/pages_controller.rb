class PagesController < ApplicationController
  
  def home
    @events = Event.order('created_at DESC')
  end
  
end