module Api
  module V1
    class UserController < ::Api::V1::BaseController
      post "/" do
        name, password = parse_json_or_halt(request.body.read).values_at(:name, :password)
        user = User.create(name: name, password: password, password_confirmation: password)
        user.valid? ? [201, { token: tokenize(name) }.to_json] : [400, user.errors.messages.to_json]
      end

      post "/login" do
        name, password = parse_json_or_halt(request.body.read).values_at(:name, :password)
        halt(404) unless (user = User.find_by(name: name))
        halt(401) unless user.authenticate(password)
        json({ token: tokenize(name) })
      end
    end
  end
end
