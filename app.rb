require 'sinatra'
require 'json'

set :port, 8080
set :bind, '0.0.0.0'

before do
  content_type :json
end

error JSON::ParserError do
  status 400
  { error: 'Invalid JSON' }.to_json
end

# Health routes
get '/health' do
  { status: 'ok', version: '0.1.0' }.to_json
end

get '/health/ready' do
  { status: 'ready', version: '0.1.0' }.to_json
end

# In-memory data store
USERS = [
  { id: 1, name: 'Alice', email: 'alice@example.com' },
  { id: 2, name: 'Bob', email: 'bob@example.com' }
]

# User routes
get '/users' do
  USERS.to_json
end

get '/users/:id' do
  user = USERS.find { |u| u[:id] == params[:id].to_i }
  halt 404, { error: 'User not found' }.to_json unless user
  user.to_json
end

post '/users' do
  data = JSON.parse(request.body.read)
  data['id'] = 1
  status 201
  data.to_json
end

put '/users/:id' do
  user = USERS.find { |u| u[:id] == params[:id].to_i }
  halt 404, { error: 'User not found' }.to_json unless user
  data = JSON.parse(request.body.read)
  data['id'] = params[:id].to_i
  data.to_json
end

delete '/users/:id' do
  user = USERS.find { |u| u[:id] == params[:id].to_i }
  halt 404, { error: 'User not found' }.to_json unless user
  status 204
  ''
end

get '/users/:user_id/posts' do
  user = USERS.find { |u| u[:id] == params[:user_id].to_i }
  halt 404, { error: 'User not found' }.to_json unless user
  [{ id: 1, userId: params[:user_id].to_i, title: 'User Post', body: 'Content' }].to_json
end

POSTS = [
  { id: 1, userId: 1, title: 'First Post', body: 'Hello world' },
  { id: 2, userId: 1, title: 'Second Post', body: 'Another post' }
]

# Post routes
get '/posts' do
  POSTS.to_json
end

get '/posts/:id' do
  post = POSTS.find { |p| p[:id] == params[:id].to_i }
  halt 404, { error: 'Post not found' }.to_json unless post
  post.to_json
end

post '/posts' do
  data = JSON.parse(request.body.read)
  data['id'] = 1
  status 201
  data.to_json
end
