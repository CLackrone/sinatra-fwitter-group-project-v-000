class TweetController < ApplicationController

	get '/tweets' do 
		if logged_in?
			@tweets = Tweet.all
			erb :'/tweets/tweets'
		else
			redirect to '/login'
		end
	end

	get '/tweets/new' do 
		if logged_in?
		erb :'/tweets/create_tweet'
	else 
		redirect to '/login'
	end
	end

	post '/tweets' do 

		tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
		if tweet.save
			redirect to :'/tweets'
		else
			redirect to :'/tweets/new'
		end
	end

	get '/tweets/:id' do 
		if logged_in?
			@tweet = Tweet.find_by_id(params[:id])
			erb :'tweets/show_tweet'
		else
			redirect to '/login'
		end
	end

	get '/tweets/:id/edit' do 
		@tweet = Tweet.find_by_id(params[:id])
		if logged_in? && @tweet.user_id == current_user.id
			erb :'tweets/edit_tweet'
		else
			redirect to '/login'
		end
	end

	post '/tweets/:id' do 
		if params[:content].empty?
			redirect to "/tweets/#{params[:id]}/edit"
		else
			@tweet = Tweet.find_by_id(params[:id])
			@tweet.update(content: params[:content])
		end
	end

	delete '/tweets/:id/delete' do
			@tweet = Tweet.find_by_id(params[:id])
			if session[:id] == @tweet.user_id
				@tweet.delete
				redirect to '/tweets/tweets'
			else
				redirect to '/tweets/tweets'
			end
	end

end




