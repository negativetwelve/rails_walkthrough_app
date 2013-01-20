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
  
  scope :without_events_by, lambda{|user| where('user_id <> ?', user.id)}
  
  class << self

  end
  
  def is_comment?
    kind == 'comment'
  end
  
  def receiver?
    !receiver.nil?
  end
  
  def parent?
    !parent_event.nil?
  end
  
  def ticker_wall_post_text
    body.length > 50 ? body[0, 50] + "..." : body
  end
  
  def ticker_comment_text
    body.length > 32 ? body[0, 32] + "..." : body
  end
  
  def ownership_text(current_user)
    if user == current_user
      "your"
    elsif receiver? && user == receiver
      "his own"
    elsif parent?
      if parent_event.user == user
        "his own"
      else
        parent_event.ownership_text(current_user)
      end
    else
      user.name + "'s"
    end
  end 
  
end