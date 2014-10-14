class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def comment
  	Comments.create name: params[:name], body: params[:comment]
  	
  	render text: 'success. Thanks!'
  end
end
