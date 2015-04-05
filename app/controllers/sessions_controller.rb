class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to '/posts'
    else
	  flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end

  end

  def destroy
  	log_out if logged_in?
  	redirect_to '/posts'
  end
end
