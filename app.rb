# frozen_string_literal: true

require 'sinatra/base'

class MakersBnB < Sinatra::Base
  get '/' do
    p 'Hello World'
  end
end
