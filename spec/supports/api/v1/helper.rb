module ApiHelpers
  def valid_header(name = nil)
    token = JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i + 36000, iss: ENV["JWT_ISSUER"], name: name }, ENV["JWT_SECRET"], "HS256")
    { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"] }
  end
end
