class UsersController < ApplicationController
  
  def new
  end
    
  def create
    @user = User.new(params[:user])
    
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Rails Walkthrough App!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
    
end
