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
    'Castle'
  end

  get '/listings' do
    @spaces = Space.show_listings
    erb :'listings'
  end

end
