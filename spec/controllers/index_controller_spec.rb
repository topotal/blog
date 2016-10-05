require "spec_helper"

describe IndexController do
  def app
    IndexController
  end

  describe "#show" do
    it "token does not pass" do
      get "/"
      expect(last_response).to be_ok
    end
  end
end
