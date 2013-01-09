class Photo < ActiveRecord::Base
  attr_accessible :caption, :image
  belongs_to :user
  
  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    storage: :Dropboxstorage,
                    path: "/#{Rails.env}/:attachment/:id/:style/:filename"
  
  include Rails.application.routes.url_helpers
  
  def to_jquery(user)
    {
      name: read_attribute(:image_file_name),
      size: read_attribute(:image_file_size),
      url: image.url(:original),
      thumbnail_url: image.url(:thumb),
      delete_url: user_photo_path(user, self),
      delete_type: 'DELETE'
    }
  end
end
