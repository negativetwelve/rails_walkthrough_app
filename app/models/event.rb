class Event < ActiveRecord::Base
  attr_accessible :body, :kind, :photos
  
  belongs_to :parent_event, class_name: 'Event'
  belongs_to :user
  belongs_to :receiver, class_name: 'User'
  
  has_many :comments, :foreign_key => :parent_event_id, :class_name => 'Event'
  has_many :commenters, :through => :comments, :source => 'user'
  
  has_many :likes, dependent: :destroy
  has_many :likers, :through => :likes, :source => 'user'
  
  has_many :photos
  
  validates_presence_of :body, if: :is_comment?
  
  accepts_nested_attributes_for :photos
  
  def is_comment?
    kind == 'comment'
  end
end