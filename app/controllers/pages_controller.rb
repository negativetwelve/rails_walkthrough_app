class PagesController < ApplicationController
  
  def home
    @events = Event.where(kind: 'status').order('created_at DESC')
  end
  
end