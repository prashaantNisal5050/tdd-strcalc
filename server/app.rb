# app.rb
require 'sinatra'
require 'json'
require 'sinatra/cross_origin'
require_relative './add'

# === Static File Setup ===
set :public_folder, File.expand_path('../client/build', __dir__)
set :static, true
enable :cross_origin

# === Serve React App ===
get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

# Handle all other client-side routes (for SPA routing)
get '/*' do
  if File.exist?(File.join(settings.public_folder, request.path_info))
    send_file File.join(settings.public_folder, request.path_info)
  else
    send_file File.join(settings.public_folder, 'index.html')
  end
end

# === API Routes ===
before do
  content_type :json
end

# Allow preflight requests for CORS
options '*' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
  200
end

# POST /add
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
