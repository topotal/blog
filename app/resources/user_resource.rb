module Api
  module Resources
    class UserResource
      include JsonWorld::DSL

      title "User object"
      description "A user object for topotal blog"

      property(
        :id,
        type: Integer,
        description: "User id",
        example: 1
      )

      property(
        :name,
        type: String,
        description: "User name",
        example: "topotan"
      )

      property(
        :access_key,
        type: String,
        pattern: "[a-z0-9]{10}",
        example: "5bf74f334a53a6636229"
      )

      property(
        :access_secret_key,
        type: String,
        pattern: "[a-z0-9]{10}",
        example: "9bf31d7c631aabf3ed72"
      )

      link(
        :register,
        method: "POST",
        description: "User registration",
        path: "/api/v1/users/register",
        parameters: {
          username: { example: "topotan", type: String },
          password: { example: "p@ssw0rd", type: String },
        },
        rel: "create"
      )

      link(
        :login,
        method: "POST",
        description: "User information if authenticate",
        path: "/api/v1/users/login",
        parameters: {
          username: { example: "topotan", type: String },
          password: { example: "p@ssw0rd", type: String },
        },
        rel: "self"
      )

      attr_reader :id, :name, :access_key, :access_secret_key
      def initialize(user)
        @id = user.id
        @name = user.name
        @access_key = user.access_key
        @access_secret_key = user.access_secret_key
      end
    end
  end
end
