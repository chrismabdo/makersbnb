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
    if User.copy_check(username: params[:username], email: params[:email]) == false
      User.create(username: params[:username], password: params['password'], email: params['email'])
      redirect '/sign_up_welcome'
    else
      redirect '/user_exists'
    end
  end

  get '/login' do
    erb :login
  end

  post '/login_details' do
    if User.check_password(login_email: params[:login_email], login_password: params[:login_password])
      session[:user] = User.find(email: params[:login_email])
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
    Space.new_listing(params[:name], params[:description], params[:price], params[:user_id])
    redirect '/listings'
  end

  get '/listings' do
    @user = if session[:user]
              session[:user].username
            else
              'Stranger'
            end
    @spaces = Space.show_listings
    erb :listings
  end

  post '/log-out' do
    session.clear
    redirect '/listings'
  end

end
