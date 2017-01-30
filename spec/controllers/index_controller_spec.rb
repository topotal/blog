require "spec_helper"

describe IndexController do
  def app
    IndexController
  end

  describe "#show" do
    it "token does not pass" do
      profiles = FactoryGirl.create_list(:user_profile, 10, :with_user)
      10.times do
        FactoryGirl.create(:entry, user_id: profiles.sample.user_id)
      end
      get "/"
      expect(last_response).to be_ok
    end
  end
end
