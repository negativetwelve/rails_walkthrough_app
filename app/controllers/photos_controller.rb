class PhotosController < ApplicationController
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.user_id = current_user.id
    
    respond_to do |format|
      if @photo.save
        format.html {
          render :json => [@photo.to_jquery].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: [@photo.to_jquery].to_json, status: :created, location: @photo }
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
