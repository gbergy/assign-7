class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:notice] = "Welcome kiddo, please Log In now."
  		redirect_to "/"
  	else
  		flash[:alert] = "There was a problem creating your account whomps"
  		redirect_to :back
  	end
  end

  def destroy
    @user = User.where(id: params[:id]).first#.destroy
    if @user && @user.destroy
      flash[:notice] = "User #{@user.fname} #{@user.lname} deleted successfully!"
    else
      flash[:alert] = "there was a problem destroying #{@user.fname}"
    end
    redirect_to root_path
  end

  def edit
     @user = User.find(params[:id])
  end

  def update  #process data and update user record 
    @user = User.where(id: params[:id]).first #REMEMBER   .where returns an array we want the .first one even if there is only one
    if @user.update_attributes(user_params)
      flash[:notice] = "Your account was updated
      successfully."
      redirect_to user_path(@user) 
    else
      flash[:alert] = "There was a problem saving your
      account."
      redirect_to new_user_path #or :back to go back to where u just came from 
    end
  end

  private 
  
  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation, :fname, :lname) 
  end
end
