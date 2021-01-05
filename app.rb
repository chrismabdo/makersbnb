# frozen_string_literal: true

require 'sinatra/base'
require './lib/user.rb'

class MakersBnB < Sinatra::Base
  get '/' do
    erb :sign_up
  end

  post '/sign_up' do
    User.create(params['username'], params['password'], params['email'])
    redirect '/sign_up_welcome'
  end

  get '/sign_up_welcome' do
    erb :sign_up_welcome
  end
end
