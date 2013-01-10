class Photo < ActiveRecord::Base
  attr_accessible :caption, :image
  belongs_to :user
  
  has_attached_file :image,
                    styles: {
                      medium: '300x300>',
                      medium_square: '300x300#',
                      small: '100x100>',
                      small_square: '100x100#',
                      thumb: '60x60>',
                      thumb_square: '60x60#'
                    },
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
