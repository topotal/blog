require "spec_helper"

describe ApiController do
  let(:app) { ApiController.new }
  let(:valid_token) { JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i + 36000, iss: ENV["JWT_ISSUER"] }, ENV["JWT_SECRET"], "HS256") }
  let(:valid_header) { { "HTTP_AUTHORIZATION" => "Bearer #{valid_token}", "JWT_SECRET" => ENV["JWT_SECRET"] } }
  let!(:entries) { FactoryGirl.create_list(:entry, 10) }

  shared_examples_for "authorization!" do |path|
    it "403 when token has expired" do
      token = JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i, iss: ENV["JWT_ISSUER"] }, ENV["JWT_SECRET"], "HS256")
      get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"] }
      expect(last_response.status).to eq 403
      expect(last_response.body).to eq "Signature has expired"
    end

    it "403 when token has invalid issuer" do
      token = JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i + 3600, iss: "invalid" }, ENV["JWT_SECRET"], "HS256")
      get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"], "JWT_ISSUER" => ENV["JWT_ISSUER"] }
      expect(last_response.status).to eq 403
      expect(last_response.body).to eq "Invalid issuer. Expected #{ENV["JWT_ISSUER"]}, received invalid"
    end

    it "403 when token has invalid iat" do
      token = JWT.encode({ iat: nil, exp: Time.now.to_i + 3600, iss: ENV["JWT_ISSUER"] }, ENV["JWT_SECRET"], "HS256")
      get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"], "JWT_ISSUER" => ENV["JWT_ISSUER"] }
      expect(last_response.status).to eq 403
      expect(last_response.body).to eq "Invalid iat"
    end

    it "401 when token not provided" do
      get path
      expect(last_response.status).to eq 401
      expect(last_response.body).to eq "Nil JSON web token"
    end
  end

  describe "/v1/entries" do
    it_should_behave_like "authorization!", "/v1/entries"

    it "render all entries" do
      get "/v1/entries", nil, valid_header
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body).length).to eq entries.length
    end
  end

  describe "/v1/entries/:id" do
    it_should_behave_like "authorization!", "/v1/entries/1"

    it "show entry" do
      entry = entries.sample
      get "/v1/entries/#{entry.id}", nil, valid_header

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to eq entry.as_json
    end
  end
end
