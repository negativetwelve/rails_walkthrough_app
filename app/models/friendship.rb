class Friendship < ActiveRecord::Base
  attr_accessible :status, :friend_id, :user_id
  
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  
  validates_presence_of :user_id, :friend_id
  
  def self.friends?(user, friend)
    return false if user == friend
    return true unless find_by_user_id_and_friend_id(user, friend).nil?
    return true unless find_by_user_id_and_friend_id(friend, user).nil?
    false
  end
  
  def self.request(user, friend)
    return false if friends?(user, friend)
    return false if user == friend
    f1 = new(user_id: user.id, friend_id: friend.id, status: 'pending')
    f2 = new(user_id: friend.id, friend_id: user.id, status: 'requested')
    transaction do
      f1.save
      f2.save
    end
  end
  
  def self.accept(user, friend)
    f1 = find_by_user_id_and_friend_id(user, friend)
    f2 = find_by_user_id_and_friend_id(friend, user)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.update_attributes(:status => "accepted")
        f2.update_attributes(:status => "accepted")
      end
    end
    return true
  end
  
  def self.reject(user, friend)
    f1 = find_by_user_id_and_friend_id(user, friend)
    f2 = find_by_user_id_and_friend_id(friend, user)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.destroy
        f2.destroy
        return true
      end
    end
  end
  
end
