class ApplicationController < ActionController::Base
  protect_from_forgery
	
	# helper_method :current_user
  
 #  def current_user
 #  	p "22222"
 #   p current_user = User.where("id= ?",session[:user_id]).last if session[:user_id]
 #  end
end
