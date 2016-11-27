module Api
  module Resources
    class UserProfileResource
      include JsonWorld::DSL

      title "UserProfile object"
      description "A user object for topotal blog"

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
        :url,
        type: String,
        description: "Image url path",
        example: "assets/img/upload/8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9"
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
        :register,
        method: "GET",
        description: "A user profile",
        path: "/api/v1/user_profiles",
        parameters: {},
        target_schema: {
          screen_name: { example: "Topotan da Silva Santos Júnior", type: String},
          description: { example: "Super awesome bot", type: String },
          url: { example: "assets/img/upload/8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9", type: String },
          image_id: { example: "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9" },
          image_content_type: { example: "image/jpeg" },
        },
        rel: "instances"
      )

      link(
        :register,
        method: "POST",
        description: "User profile registration",
        path: "/api/v1/user_profiles/register",
        parameters: {
          screen_name: { example: "Topotan da Silva Santos Júnior", type: String},
          description: { example: "Super awesome bot", type: String },
          content: { example: "data:image/jpeg;base64,base64encodedstring......", type: String },
        },
        rel: "create"
      )

      attr_reader :id, :screen_name, :description, :url, :image_id, :image_content_type, :user_id
      def initialize(user)
        @id = user_profile.id
        @screen_name = user_profile.screen_name
        @description = user_profile.description
        @url = user_profile.image_url
        @image_id = user_profile.image_id
        @image_content_type = user_profile.image_content_type
        @user_id = user_profile.user.id
      end
    end
  end
end
