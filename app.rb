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
    @spaces = Space.show_listings

    erb :listings
  end
end
