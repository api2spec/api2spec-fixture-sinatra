require_relative 'spec_helper'

RSpec.describe "Posts API" do
  describe "GET /posts" do
    it "returns a list of posts" do
      get '/posts'

      expect(last_response).to be_ok
      expect(last_response.content_type).to include('application/json')

      body = JSON.parse(last_response.body)
      expect(body).to be_an(Array)
      expect(body.size).to eq(2)
      expect(body.first).to include('id', 'userId', 'title', 'body')
    end
  end

  describe "GET /posts/:id" do
    context "when post exists" do
      it "returns the post" do
        get '/posts/1'

        expect(last_response).to be_ok

        body = JSON.parse(last_response.body)
        expect(body['id']).to eq(1)
        expect(body).to include('userId', 'title', 'body')
      end
    end

    context "when post does not exist" do
      it "returns 404 not found" do
        get '/posts/999'

        expect(last_response.status).to eq(404)

        body = JSON.parse(last_response.body)
        expect(body['error']).to eq('Post not found')
      end
    end
  end

  describe "POST /posts" do
    context "with valid data" do
      it "creates a post and returns 201" do
        post '/posts', { userId: 1, title: 'New Post', body: 'Post content' }.to_json, 'CONTENT_TYPE' => 'application/json'

        expect(last_response.status).to eq(201)

        body = JSON.parse(last_response.body)
        expect(body['id']).to eq(1)
        expect(body['userId']).to eq(1)
        expect(body['title']).to eq('New Post')
        expect(body['body']).to eq('Post content')
      end
    end

    context "with invalid JSON" do
      it "returns 400 bad request" do
        post '/posts', 'not valid json', 'CONTENT_TYPE' => 'application/json'

        expect(last_response.status).to eq(400)
      end
    end
  end

  describe "DELETE /posts/:id" do
    context "when post exists" do
      it "deletes the post and returns 204" do
        delete '/posts/1'

        expect(last_response.status).to eq(204)
        expect(last_response.body).to be_empty
      end
    end

    context "when post does not exist" do
      it "returns 404 not found" do
        delete '/posts/999'

        expect(last_response.status).to eq(404)

        body = JSON.parse(last_response.body)
        expect(body['error']).to eq('Post not found')
      end
    end
  end
end
