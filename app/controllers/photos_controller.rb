class PhotosController < ApplicationController

  def create
    @photo = Photo.new(params[:photo])
    @photo.user_id = current_user.id
    if @photo.save
      flash[:success] = "Successfully uploaded photo!"
    else
      flash[:error] = "Error uploading photo."
    end
    redirect_to root_path
  end
  
end
