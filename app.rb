require 'sinatra'
require 'json'

set :port, 8080
set :bind, '0.0.0.0'

before do
  content_type :json
end

# Health routes
get '/health' do
  { status: 'ok', version: '0.1.0' }.to_json
end

get '/health/ready' do
  { status: 'ready', version: '0.1.0' }.to_json
end

# User routes
get '/users' do
  [
    { id: 1, name: 'Alice', email: 'alice@example.com' },
    { id: 2, name: 'Bob', email: 'bob@example.com' }
  ].to_json
end

get '/users/:id' do
  { id: params[:id].to_i, name: 'Sample User', email: 'user@example.com' }.to_json
end

post '/users' do
  data = JSON.parse(request.body.read)
  data['id'] = 1
  status 201
  data.to_json
end

put '/users/:id' do
  data = JSON.parse(request.body.read)
  data['id'] = params[:id].to_i
  data.to_json
end

delete '/users/:id' do
  status 204
  ''
end

get '/users/:user_id/posts' do
  [{ id: 1, userId: params[:user_id].to_i, title: 'User Post', body: 'Content' }].to_json
end

# Post routes
get '/posts' do
  [
    { id: 1, userId: 1, title: 'First Post', body: 'Hello world' },
    { id: 2, userId: 1, title: 'Second Post', body: 'Another post' }
  ].to_json
end

get '/posts/:id' do
  { id: params[:id].to_i, userId: 1, title: 'Sample Post', body: 'Post body' }.to_json
end

post '/posts' do
  data = JSON.parse(request.body.read)
  data['id'] = 1
  status 201
  data.to_json
end
