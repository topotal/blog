require "spec_helper"

describe Api::V1::ImageController do
  let(:app) { Api::V1::ImageController.new }
  let!(:images) { FactoryGirl.create_list(:image, 10) }
  let!(:image) { images.sample }

  describe "GET /" do
    let(:method) { get }
    let(:path) { "/" }
    it_should_behave_like "authorization!"

    it "render all images" do
      get path, nil, valid_header
      expect(last_response.status).to eq 200
      expect(last_response.headers["X-Total-Count"]).to eq "10"
      expect(JSON.parse(last_response.body).length).to eq images.length
    end
  end

  describe "GET /:id" do
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

  describe "DELETE /:id" do
    let(:method) { delete }
    let(:path) { "/#{image.id}" }
    it_should_behave_like "authorization!"

    it "can delete new image and return 200 if deleted" do
      expect { delete path, nil, valid_header }.to change(Image, :count).by(-1)
      expect(last_response.status).to eq 200
    end

    it "can not show deleted image" do
      delete path, nil, valid_header
      get path, nil, valid_header
      expect(last_response.status).to eq 404
    end
  end
end
