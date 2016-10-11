require "spec_helper"

describe Api::V1::ImageController do
  let(:app) { Api::V1::ImageController.new }

  describe "GET /" do
    let!(:images) { FactoryGirl.create_list(:image, 10) }
    let(:method) { get }
    let(:path) { "/" }
    it_should_behave_like "authorization!"

    it "render all images" do
      get path, nil, valid_header
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body).length).to eq images.length
    end
  end

  describe "GET /:id" do
    let!(:image) { FactoryGirl.create(:image) }
    let(:method) { get }
    let(:path) { "/#{image.id}" }
    it_should_behave_like "authorization!"

    it "show image" do
      get path, nil, valid_header

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to eq JSON.parse(::Api::Resources::ImageResource.new(image).to_json)
    end
  end

  describe "POST /" do
    let(:image) { FactoryGirl.build(:image) }
    let(:method) { post }
    let(:path) { "/" }
    let(:params) { { content: "data:text/plain;base64,base64encodedstring" } }
    it_should_behave_like "authorization!"
    it_should_behave_like "invalid_body!"

    it "can create new image" do
      expect { post path, params.to_json, valid_header }.to change(Image, :count).by(1)
    end

    it "return 201 if created" do
      post path, params.to_json, valid_header
      expect(last_response.status).to eq 201
    end

    it "error messages if invalid parameters" do
      post path, {}.to_json, valid_header
      expect(last_response.status).to eq 400
    end
  end

  describe "POST /:id" do
    let!(:image) { FactoryGirl.create(:image) }
    let(:method) { post }
    let(:path) { "/#{image.id}" }
    let(:params) { { content: "data:text/plain;base64,base64encodedstring" } }
    it_should_behave_like "authorization!"
    it_should_behave_like "invalid_body!"

    it "not increase image counts" do
      expect { post path, params.to_json, valid_header }.not_to change(Image, :count)
    end

    it "return 201 if updated" do
      post path, params.to_json, valid_header
      expect(last_response.status).to eq 201
    end
  end
end
