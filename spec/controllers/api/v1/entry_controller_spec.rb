require "spec_helper"

describe Api::V1::EntryController do
  def valid_header(name = nil)
    token = JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i + 36000, iss: ENV["JWT_ISSUER"], name: name }, ENV["JWT_SECRET"], "HS256")
    { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"] }
  end

  let(:app) { Api::V1::EntryController.new }

  shared_examples_for "invalid_body!" do
    it "400 when body is invalid" do
      post path, nil, valid_header(entry.user.name)
      expect(last_response.status).to eq 400
    end
  end

  shared_examples_for "authorization!" do
    it "403 when token has expired" do
      token = JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i, iss: ENV["JWT_ISSUER"] }, ENV["JWT_SECRET"], "HS256")
      get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"] }
      expect(last_response.status).to eq 403
      expect(JSON.parse(last_response.body)["token"]).to eq "Signature has expired"
    end

    it "403 when token has invalid issuer" do
      token = JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i + 3600, iss: "invalid" }, ENV["JWT_SECRET"], "HS256")
      get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"], "JWT_ISSUER" => ENV["JWT_ISSUER"] }
      expect(last_response.status).to eq 403
      expect(JSON.parse(last_response.body)["token"]).to eq "Invalid issuer. Expected #{ENV["JWT_ISSUER"]}, received invalid"
    end

    it "403 when token has invalid iat" do
      token = JWT.encode({ iat: nil, exp: Time.now.to_i + 3600, iss: ENV["JWT_ISSUER"] }, ENV["JWT_SECRET"], "HS256")
      get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"], "JWT_ISSUER" => ENV["JWT_ISSUER"] }
      expect(last_response.status).to eq 403
      expect(JSON.parse(last_response.body)["token"]).to eq "Invalid iat"
    end

    it "401 when token not provided" do
      get path
      expect(last_response.status).to eq 401
      expect(JSON.parse(last_response.body)["token"]).to eq "Nil JSON web token"
    end
  end

  describe "GET /" do
    let!(:entries) { FactoryGirl.create_list(:entry, 10, :with_user) }
    let(:method) { get }
    let(:path) { "/" }
    it_should_behave_like "authorization!"

    it "render all entries" do
      get path, nil, valid_header
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body).length).to eq entries.length
    end
  end

  describe "GET /:id" do
    let!(:entry) { FactoryGirl.create(:entry, :with_user) }
    let(:method) { get }
    let(:path) { "/#{entry.id}" }
    it_should_behave_like "authorization!"

    it "show entry" do
      get path, nil, valid_header

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to eq JSON.parse(::Api::Resources::EntryResource.new(entry).to_json)
    end
  end

  describe "POST /" do
    let(:entry) { FactoryGirl.build(:entry, :with_user) }
    let(:method) { post }
    let(:path) { "/" }
    let(:params) { entry.slice(:title, :content, :eye_catching, :publish_date) }
    it_should_behave_like "authorization!"
    it_should_behave_like "invalid_body!"

    it "can create new entry" do
      expect { post path, params.to_json, valid_header(entry.user.name) }.to change(Entry, :count).by(1)
    end

    it "return 201 if created" do
      post path, params.to_json, valid_header(entry.user.name)
      expect(last_response.status).to eq 201
    end

    it "error messages if invalid parameters" do
      post path, {}.to_json, valid_header(entry.user.name)
      expect(last_response.status).to eq 400
    end
  end

  describe "POST /:id" do
    let!(:entry) { FactoryGirl.create(:entry, :with_user) }
    let(:method) { post }
    let(:path) { "/#{entry.id}" }
    let!(:params) { FactoryGirl.build(:entry).slice(:title, :content, :eye_catching, :publish_date) }
    it_should_behave_like "authorization!"
    it_should_behave_like "invalid_body!"

    it "not increase entry counts" do
      expect { post path, params.to_json, valid_header }.not_to change(Entry, :count)
    end

    it "return 201 if updated" do
      post path, params.to_json, valid_header
      expect(last_response.status).to eq 201
    end

    it "entry update according to parameters" do
      post path, params.to_json, valid_header
      expect(entry.reload.attributes).to include params
    end

    it "return error messages and not updated if invalid parameters" do
      post path, { title: nil }.to_json, valid_header
      expect(entry.reload).to eq entry
      expect(last_response.status).to eq 400
    end
  end
end
