module Api
  module Resources
    class UserProfileResource
      include JsonWorld::DSL

      title "UserProfile object"
      description "A user profile object for topotal blog"

      property(
        :id,
        type: Integer,
        description: "User profile id",
        example: 1
      )

      property(
        :screen_name,
        type: String,
        description: "Screen name",
        example: "Topotan da Silva Santos Júnior"
      )

      property(
        :description,
        type: String,
        description: "User description",
        example: "Topotan"
      )

      property(
        :image_url,
        type: String,
        description: "Image url path",
        example: "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg"
      )

      property(
        :image_id,
        type: String,
        description: "Image id",
        example: "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9"
      )

      property(
        :image_content_type,
        type: String,
        description: "Image content type",
        example: "image/jpeg"
      )

      link(
        :user_profiles,
        method: "GET",
        description: "A user profile",
        path: "/api/v1/user_profiles",
        rel: "self"
      )

      link(
        :user_profiles,
        method: "POST",
        description: "User profile registration",
        path: "/api/v1/user_profiles",
        parameters: {
          screen_name: { example: "Topotan da Silva Santos Júnior", type: String },
          description: { example: "Super awesome bot", type: String },
          content: { example: "data:image/jpeg;base64,base64encodedstring......", type: String },
        },
        rel: "create"
      )

      link(
        :user_profiles,
        method: "PATCH",
        description: "User profile update",
        path: "/api/v1/user_profiles",
        parameters: {
          screen_name: { example: "Topotan da Silva Santos Júnior", type: String },
          description: { example: "Super awesome bot", type: String },
          content: { example: "data:image/jpeg;base64,base64encodedstring......", type: String },
        },
        rel: "update"
      )

      attr_reader :id, :screen_name, :description, :image_url, :image_id, :image_content_type, :user_id
      def initialize(user_profile)
        @id = user_profile.id
        @screen_name = user_profile.screen_name
        @description = user_profile.description
        @image_url = user_profile.image_url
        @image_id = user_profile.image_id
        @image_content_type = user_profile.image_content_type
        @user_id = user_profile.user.id
      end
    end
  end
end
