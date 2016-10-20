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

      link(
        :register,
        method: "POST",
        description: "User registration",
        path: "/api/v1/users/register",
        parameters: {
          name: { example: "topotan", type: String },
          password: { example: "p@ssw0rd", type: String },
        },
        target_schema: {
          token: {
            description: "JWT Token issued by blog.topotal.com",
            example: "secret.token.issued-by-topotal",
            type: String,
          },
        },
        rel: "create"
      )

      link(
        :login,
        method: "POST",
        description: "User information if authenticate",
        path: "/api/v1/users/login",
        parameters: {
          name: { example: "topotan", type: String },
          password: { example: "p@ssw0rd", type: String },
        },
        target_schema: {
          token: {
            description: "JWT Token issued by blog.topotal.com",
            example: "secret.token.issued-by-topotal",
            type: String,
          },
        },
        rel: "self"
      )

      attr_reader :id, :name
      def initialize(user)
        @id = user.id
        @name = user.name
      end
    end
  end
end
