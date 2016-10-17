require "spec_helper"

describe Api::V1::EntryController do
  let(:app) { Api::V1::EntryController.new }
  let!(:entries) { FactoryGirl.create_list(:entry, 10, :with_user) }
  let!(:entry) { entries.sample }

  describe "GET /" do
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
