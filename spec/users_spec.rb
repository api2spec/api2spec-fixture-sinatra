require_relative 'spec_helper'

RSpec.describe "Users API" do
  describe "GET /users" do
    it "returns a list of users" do
      get '/users'

      expect(last_response).to be_ok
      expect(last_response.content_type).to include('application/json')

      body = JSON.parse(last_response.body)
      expect(body).to be_an(Array)
      expect(body.size).to eq(2)
      expect(body.first).to include('id', 'name', 'email')
    end
  end

  describe "GET /users/:id" do
    context "when user exists" do
      it "returns the user" do
        get '/users/1'

        expect(last_response).to be_ok

        body = JSON.parse(last_response.body)
        expect(body['id']).to eq(1)
        expect(body).to include('name', 'email')
      end
    end

    context "when user does not exist" do
      it "returns 404 not found" do
        get '/users/999'

        expect(last_response.status).to eq(404)

        body = JSON.parse(last_response.body)
        expect(body['error']).to eq('User not found')
      end
    end
  end

  describe "POST /users" do
    context "with valid data" do
      it "creates a user and returns 201" do
        post '/users', { name: 'Charlie', email: 'charlie@example.com' }.to_json, 'CONTENT_TYPE' => 'application/json'

        expect(last_response.status).to eq(201)

        body = JSON.parse(last_response.body)
        expect(body['id']).to eq(1)
        expect(body['name']).to eq('Charlie')
        expect(body['email']).to eq('charlie@example.com')
      end
    end

    context "with invalid JSON" do
      it "returns 400 bad request" do
        post '/users', 'not valid json', 'CONTENT_TYPE' => 'application/json'

        expect(last_response.status).to eq(400)
      end
    end
  end

  describe "PUT /users/:id" do
    context "with valid data" do
      it "updates the user" do
        put '/users/1', { name: 'Alice Updated', email: 'alice.updated@example.com' }.to_json, 'CONTENT_TYPE' => 'application/json'

        expect(last_response).to be_ok

        body = JSON.parse(last_response.body)
        expect(body['id']).to eq(1)
        expect(body['name']).to eq('Alice Updated')
        expect(body['email']).to eq('alice.updated@example.com')
      end
    end

    context "when user does not exist" do
      it "returns 404 not found" do
        put '/users/999', { name: 'Nobody', email: 'nobody@example.com' }.to_json, 'CONTENT_TYPE' => 'application/json'

        expect(last_response.status).to eq(404)

        body = JSON.parse(last_response.body)
        expect(body['error']).to eq('User not found')
      end
    end

    context "with invalid JSON" do
      it "returns 400 bad request" do
        put '/users/1', 'not valid json', 'CONTENT_TYPE' => 'application/json'

        expect(last_response.status).to eq(400)
      end
    end
  end

  describe "DELETE /users/:id" do
    context "when user exists" do
      it "deletes the user and returns 204" do
        delete '/users/1'

        expect(last_response.status).to eq(204)
        expect(last_response.body).to be_empty
      end
    end

    context "when user does not exist" do
      it "returns 404 not found" do
        delete '/users/999'

        expect(last_response.status).to eq(404)

        body = JSON.parse(last_response.body)
        expect(body['error']).to eq('User not found')
      end
    end
  end

  describe "GET /users/:user_id/posts" do
    context "when user exists" do
      it "returns posts for a user" do
        get '/users/1/posts'

        expect(last_response).to be_ok

        body = JSON.parse(last_response.body)
        expect(body).to be_an(Array)
        expect(body.first['userId']).to eq(1)
        expect(body.first).to include('id', 'title', 'body')
      end
    end

    context "when user does not exist" do
      it "returns 404 not found" do
        get '/users/999/posts'

        expect(last_response.status).to eq(404)

        body = JSON.parse(last_response.body)
        expect(body['error']).to eq('User not found')
      end
    end
  end
end
