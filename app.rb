# frozen_string_literal: true

require 'sinatra/base'
require './lib/space.rb'
require './lib/user.rb'
require './lib/request.rb'

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
    if session[:user]
      erb :'add-listing'
    else
      redirect '/'
    end 
  end

  post '/add-listing' do
    @user = session[:user].id
    Space.new_listing(params[:name], params[:description], params[:price], @user)
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

  post '/send_request' do
    if session[:user]
      @user = session[:user].id
      session[:space] = Space.find(space_id: params[:space_id])
      session[:current_request] = Request.create(space_id: params[:space_id], guest_id: @user, check_in: params[:check_in], check_out: params[:check_out], confirmed: false)
      
      # p session[:current_request]
      # p session[:current_request].check_in
      result = session[:current_request].check_full_availability(space_id: params[:space_id], check_in: params[:check_in], check_out: params[:check_out])

      if result == true
        redirect '/confirm_request'
      else
        redirect '/dates_unavailable'
      end
    else
      redirect '/'
    end
  end

  get '/dates_unavailable' do
    erb :dates_unavailable
  end

  get '/confirm_request' do
    @user = session[:user]
    @space = session[:space]
    @current_request = session[:current_request]
    erb :confirm_request
  end

  post '/log-out' do
    session.clear
    redirect '/'
  end

  get '/manage_bookings' do
    erb :manage_bookings
  end

  post '/confirm_booking' do
    redirect '/manage_bookings'
  end

  post '/reject_booking' do
    redirect '/manage_bookings'
  end
end
