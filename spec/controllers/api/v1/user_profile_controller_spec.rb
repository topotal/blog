require "spec_helper"

describe Api::V1::UserProfileController do
  let(:app) { Api::V1::UserProfileController.new }
  let!(:user_profiles) { FactoryGirl.create_list(:user_profile, 10, :with_user) }
  let!(:user_profile) { user_profiles.sample }

  describe "GET /" do
    let(:method) { get }
    let(:path) { "/" }
    it_should_behave_like "authorization!"

    it "show user_profile" do
      get path, nil, valid_header(user_profile.user.name)
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to eq JSON.parse(::Api::Resources::UserProfileResource.new(user_profile).to_json)
    end
  end

  describe "POST /" do
    let(:method) { post }
    let(:path) { "/" }
    let(:new_user) { FactoryGirl.create(:user) }
    let!(:params) { FactoryGirl.build(:user_profile).slice(:screen_name, :description).merge({ content: "data:text/plain;base64,base64encodedstring" }) }
    it_should_behave_like "authorization!"

    it "increase user_profile counts" do
      expect { post path, params.to_json, valid_header(new_user.name) }.to change(UserProfile, :count).by(1)
    end

    it "return 201 if updated" do
      post path, params.to_json, valid_header(user_profile.user.name)
      expect(last_response.status).to eq 201
    end

    it "return error messages and not updated if invalid parameters" do
      post path, {}.to_json, valid_header(user_profile.user.name)
      expect(user_profile.reload).to eq user_profile
      expect(last_response.status).to eq 400
    end

    it "update if user already has profile" do
      expect { post path, params.to_json, valid_header(user_profile.user.name) }.to change(UserProfile, :count).by(0)
    end
  end

  describe "PATCH /" do
    let(:method) { patch }
    let(:path) { "/" }
    let!(:params) { FactoryGirl.build(:user_profile).slice(:screen_name, :description).merge({ content: "data:text/plain;base64,base64encodedstring" }) }
    it_should_behave_like "authorization!"

    it "return 200 updated if all parameters" do
      patch path, params.to_json, valid_header(user_profile.user.name)
      expect(last_response.status).to eq 200
    end

    it "return 200 updated if some parameters" do
      screen_name = "updated screen_name"
      description = "updated description"
      patch path, { screen_name: screen_name, description: description }.to_json, valid_header(user_profile.user.name)
      updated_profile = UserProfile.find_by_id(user_profile.id)
      expect(last_response.status).to eq 200
      expect(updated_profile.screen_name).to eq screen_name
      expect(updated_profile.description).to eq description
    end

    it "return 200 and updated if empty parameters" do
      patch path, {}.to_json, valid_header(user_profile.user.name)
      expect(user_profile.reload).to eq user_profile
      expect(last_response.status).to eq 200
    end
  end
end
