# app.rb
require 'sinatra'
require 'json'
require 'sinatra/cross_origin'
require_relative './add'
require 'byebug'
set :public_folder, File.expand_path('../../client/build', __FILE__)

configure do
  enable :cross_origin
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

before do
  content_type :json
end

# Allow preflight requests (important for POST requests from browsers)
options '*' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
  200
end

post '/add' do
  headers 'Access-Control-Allow-Origin' => '*'
  begin
    input = JSON.parse(request.body.read)['input']
    result = StringCalculator.new(input).add
    { result: result }.to_json
  rescue => e
    status 400
    { error: e.message }.to_json
  end
end
