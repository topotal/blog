module Api
  module V1
    class UserProfileController < ::Api::V1::BaseController
      helpers do
        def parse_data_url(data)
          URI::Data.new(data)
        rescue StandardError => e
          halt(400, { errors: e.to_s }.to_json)
        end
      end

      before do
        return if request.request_method == "OPTIONS"
        authorization!
      end

      get "/" do
        halt(404) unless (user = User.find_by(name: @payload["name"]))
        json ::Api::Resources::UserProfileResource.new(UserProfile.find_by(user_id: user.id))
      end

      post "/register" do
        halt(404) unless (user = User.find_by(name: @payload["name"]))
        screen_name, description, content = parse_json_or_halt(request.body.read).values_at(:screen_name, :description, :content)
        data_uri = parse_data_url(content)

        user_profile = UserProfile.create(
          screen_name: screen_name,
          description: description,
          image: StringIO.new(data_uri.data),
          image_content_type: data_uri.content_type,
          user_id: user.id,
        )
        user_profile.image_url = File.join(Refile.store.directory.gsub(%r{^public/}, "/"), user_profile.image_id)
        user_profile.valid? ? [201, user_profile.save && ::Api::Resources::UserProfileResource.new(user_profile).to_json] : [400, user_profile.errors.messages.to_json]
      end
    end
  end
end
