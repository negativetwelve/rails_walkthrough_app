class Event < ActiveRecord::Base
  attr_accessible :body, :kind
  
  belongs_to :parent_event, class_name: 'Event'
  belongs_to :user
  
  has_many :comments, :foreign_key => :parent_event_id, :class_name => 'Event'
  has_many :commenters, :through => :comments, :source => 'user'
  
  validates_presence_of :body, if: :is_comment?
  
  def is_comment?
    kind == 'comment'
  end
end