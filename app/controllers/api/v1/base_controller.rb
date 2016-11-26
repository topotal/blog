module Api
  module V1
    class BaseController < ::BaseController
      helpers do
        def tokenize(name, issuer: ENV["JWT_ISSUER"], expire: 28800)
          header = { iat: Time.now.to_i, exp: Time.now.to_i + expire, iss: ENV["JWT_ISSUER"] }
          content = { scopes: ["*"], name: name }
          JWT.encode(header.merge(content), ENV["JWT_SECRET"], "HS256")
        end

        def parse_json_or_halt(body)
          JSON.parse(body, symbolize_names: true)
        rescue StandardError => e
          halt([400, { errors: e.to_s }.to_json])
        end

        def authorization!
          options = { algorithm: "HS256", iss: ENV["JWT_ISSUER"], verify_iss: true, verify_iat: true }
          bearer = request.env.fetch("HTTP_AUTHORIZATION", "").slice(7..-1)
          begin
            @payload, @header = JWT.decode(bearer, ENV["JWT_SECRET"], true, options)
          rescue JWT::ExpiredSignature, JWT::InvalidIssuerError, JWT::InvalidIatError => e
            halt([403, { token: e.to_s }.to_json])
          rescue JWT::DecodeError => e
            halt([401, { token: e.to_s }.to_json])
          end
        end
      end

      before do
        content_type :json, charset: "utf-8"
      end

      options "*" do
        200
      end
    end
  end
end
