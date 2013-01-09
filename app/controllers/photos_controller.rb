class PhotosController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end
  
  def create
    @photo = Photo.new(params[:photo])
    @user = current_user
    @photo.user_id = @user.id
    
    respond_to do |format|
      if @photo.save
        format.html {
          render :json => [@photo.to_jquery(@user)].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: [@photo.to_jquery(@user)].to_json, status: :created, location: user_photo_path(@user, @photo) }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to(:back)
  end

  
end
