require 'sinatra/base'
require 'sinatra/param'
require 'sinatra/json'
require 'shotgun'

require 'mongoid'
require 'dotenv'
require 'sinatra-initializers'
require 'active_model_serializers'


Dotenv.load

class Sin < Sinatra::Application

  register Sinatra::Initializers
    configure do
    set :raise_sinatra_param_exceptions, true
    set show_exceptions: false
  end

  before do
    content_type 'application/json'
  end


  get '/' do
    'Hello worlds!'
  end

  post '/operations' do
    "Hello"
  end

  post '/task' do
    param :task, String, in: ['resize'], required: true
    param :params, Hash, required: true

    task = Task.new(params)
    task.save

    json task
  end


  error Sinatra::Param::InvalidParameterError do
    {error: "#{env['sinatra.error'].param} is invalid"}.to_json 
  end


end