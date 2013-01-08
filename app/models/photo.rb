class Photo < ActiveRecord::Base
  attr_accessible :caption, :image
  belongs_to :user
  
  has_attached_file :image,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    storage: :Dropboxstorage,
                    path: "/#{Rails.env}/:attachment/:id/:style/:filename"
end
