require_relative 'spec_helper'

RSpec.describe "Health API" do
  describe "GET /health" do
    it "returns ok status" do
      get '/health'

      expect(last_response).to be_ok
      expect(last_response.content_type).to include('application/json')

      body = JSON.parse(last_response.body)
      expect(body['status']).to eq('ok')
      expect(body['version']).to eq('0.1.0')
    end
  end

  describe "GET /health/ready" do
    it "returns ready status" do
      get '/health/ready'

      expect(last_response).to be_ok
      expect(last_response.content_type).to include('application/json')

      body = JSON.parse(last_response.body)
      expect(body['status']).to eq('ready')
      expect(body['version']).to eq('0.1.0')
    end
  end
end
