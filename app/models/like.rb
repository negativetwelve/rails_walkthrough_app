class Like < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :user
  belongs_to :event
  
  class << self

  end
end
