class UserController < ApplicationController

	get '/signup' do 
		erb :'/users/create_user'
	end

	post '/signup' do 
		user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
		erb :'/tweets/tweets'
	end
end