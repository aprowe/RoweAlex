class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def comment
  	Comments.create name: params[:name], body: params[:comment]
  	
  	render text: 'success. Thanks!'
  end

  def deleteComments
  	if params[:all] = true
  		Comments.delete_all
  		render text: 'All Comments Deleted'
  	end

  end

  def viewComments
  	start = params[:start].to_i
  	amount = params[:amount].to_i


  	done = false
  	if start > Comments.count
  		done = true
  		logger.debug(Comments.count)
  		logger.debug(start)
  		logger.debug(amount)
  		comments = Comments.order('id desc').last(Comments.count-start+amount)
  	else
	  	comments = Comments.order('id desc').first(start).last(amount)
  	end
 

  	json = {comments: comments, done: done, count: Comments.count}
  	# comments = Comments.find
  	render json: json
  end
end
