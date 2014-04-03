class SessionsController < ApplicationController
  def new
  end

  	def create
  		@user = User.authenticate(params[:email], params[:password]) #try to authenticate the user - if they authenticate successfully, an instance of the User model is returned
	  	if @user
	  		flash[:notice] = "You've been logged in."
	  		#THIS IS THE MOST IMPORTANT PART. Actually log the user in by storing their ID in the session hash with the [:user_id] key!
	  		session[:user_id] = @user.id
	  		redirect_to user_path(@user)
	  	else
	  		flash[:alert] = "There was a problem"
	  		redirect_to log_in_path
	  	end
  	end
 
  def destroy
  	session[:user_id] = nil
  	flash[:notice] = "You've been logged out successfully"
  	redirect_to "/"
  end
end
