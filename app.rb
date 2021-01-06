# frozen_string_literal: true

require 'sinatra/base'
require './lib/space.rb'
require './lib/user.rb'


class MakersBnB < Sinatra::Base
  enable :sessions

  get '/' do
    erb :sign_up
  end

  post '/sign_up' do
    if User.copy_check(params['username'], params['email']) == false
      User.create(params['username'], params['password'], params['email'])
      redirect '/sign_up_welcome'
    else
      redirect '/user_exists'
    end
  end

  get '/login' do
    erb :login
  end

  post '/login_details' do
    if User.check_password(params[:email], params[:password])
      session[:user] = User.find(params[:email])
      redirect '/logged_in'
    else
      redirect '/login_failure'
    end
  end

  get '/logged_in' do
    @user = session[:user]
    erb :homepage
  end

  get '/login_failure' do
    erb :login_failure
  end

  get '/sign_up_welcome' do
    erb :sign_up_welcome
  end

  get '/user_exists' do
    erb :user_exists
  end

  get '/add-listing' do
    erb :'add-listing'
  end

  post '/add-listing' do
    Space.new_listing(params[:name], params[:description], params[:price])

    redirect '/listings'
  end

  get '/listings' do
    @spaces = Space.show_listings

    erb :'listings'
  end

end
