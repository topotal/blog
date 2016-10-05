require "spec_helper"

describe ApiController do
  let(:app) { ApiController.new }
  let(:valid_token) { JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i + 36000, iss: ENV["JWT_ISSUER"] }, ENV["JWT_SECRET"], "HS256") }
  let(:valid_header) { { "HTTP_AUTHORIZATION" => "Bearer #{valid_token}", "JWT_SECRET" => ENV["JWT_SECRET"] } }

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

  describe "GET /v1/entries" do
    let!(:entries) { FactoryGirl.create_list(:entry, 10) }
    it_should_behave_like "authorization!", "/v1/entries"

    it "render all entries" do
      get "/v1/entries", nil, valid_header
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body).length).to eq entries.length
    end
  end

  describe "GET /v1/entries/:id" do
    let!(:entry) { FactoryGirl.create(:entry) }
    it_should_behave_like "authorization!", "/v1/entries/1"

    it "show entry" do
      get "/v1/entries/#{entry.id}", nil, valid_header

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to eq JSON.parse(::Api::Resources::EntryResource.new(entry).to_json)
    end
  end

  describe "POST /v1/entries" do
    let(:params) { FactoryGirl.build(:entry).slice(:title, :content, :eye_catching, :publish_date) }
    it_should_behave_like "authorization!", "/v1/entries"

    it "can create new entry" do
      expect { post "/v1/entries", params.to_json, valid_header }.to change(Entry, :count).by(1)
    end

    it "return 201 if created" do
      post "/v1/entries", params.to_json, valid_header
      expect(last_response.status).to eq 201
    end
  end

  describe "POST /v1/entries/:id" do
    let!(:entry) { FactoryGirl.create(:entry) }
    let!(:params) { FactoryGirl.build(:entry).slice(:title, :content, :eye_catching, :publish_date) }
    it_should_behave_like "authorization!", "/v1/entries/1"

    it "not increase entry counts" do
      expect { post "/v1/entries/#{entry.id}", params.to_json, valid_header }.not_to change(Entry, :count)
    end

    it "return 201 if updated" do
      post "/v1/entries/#{entry.id}", params.to_json, valid_header
      expect(last_response.status).to eq 201
    end

    it "entry update according to params" do
      post "/v1/entries/#{entry.id}", params.to_json, valid_header
      expect(entry.reload.attributes).to include params
    end
  end
end
