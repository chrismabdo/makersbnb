# frozen_string_literal: true

require 'sinatra/base'
require './lib/space.rb'

class MakersBnB < Sinatra::Base
  enable :sessions

  get '/' do
    p 'Hello World'
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
