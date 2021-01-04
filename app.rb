# frozen_string_literal: true

require 'sinatra/base'

class MakersBnB < Sinatra::Base
  get '/' do
    p 'Hello World'
  end

  get '/add-listing' do
    erb :'add-listing'
  end

  post '/add-listing' do
    'Castle'
  end

end
