require 'bundler'
require 'coffee-script'
require 'httparty'
require 'sinatra/base'
require 'sinatra/config_file'

class Instagram
  include HTTParty
  base_uri 'https://api.instagram.com/v1'

  def initialize(default_params)
    self.class.default_params default_params
  end

  def media_popular()
    self.class.get('/media/popular')
  end
end

class Instagralley < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'

  register Sinatra::ConfigFile
  config_file 'config.yml'

  get '/' do
    instagram = Instagram.new(:client_id => settings.instagram['client_id'])
    erb :index, :locals => { :photos => instagram.media_popular['data'] }
  end

  get '/instagralley.js' do
    coffee :instagralley
  end
end
