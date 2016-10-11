shared_examples_for "invalid_body!" do
  it "400 when body is invalid" do
    post path, nil, valid_header(defined?(entry) ? entry.user.name : nil)
    expect(last_response.status).to eq 400
  end
end

shared_examples_for "authorization!" do
  it "403 when token has expired" do
    token = JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i, iss: ENV["JWT_ISSUER"] }, ENV["JWT_SECRET"], "HS256")
    get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"] }
    expect(last_response.status).to eq 403
    expect(JSON.parse(last_response.body)["token"]).to eq "Signature has expired"
  end

  it "403 when token has invalid issuer" do
    token = JWT.encode({ iat: Time.now.to_i, exp: Time.now.to_i + 3600, iss: "invalid" }, ENV["JWT_SECRET"], "HS256")
    get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"], "JWT_ISSUER" => ENV["JWT_ISSUER"] }
    expect(last_response.status).to eq 403
    expect(JSON.parse(last_response.body)["token"]).to eq "Invalid issuer. Expected #{ENV["JWT_ISSUER"]}, received invalid"
  end

  it "403 when token has invalid iat" do
    token = JWT.encode({ iat: nil, exp: Time.now.to_i + 3600, iss: ENV["JWT_ISSUER"] }, ENV["JWT_SECRET"], "HS256")
    get path, nil, { "HTTP_AUTHORIZATION" => "Bearer #{token}", "JWT_SECRET" => ENV["JWT_SECRET"], "JWT_ISSUER" => ENV["JWT_ISSUER"] }
    expect(last_response.status).to eq 403
    expect(JSON.parse(last_response.body)["token"]).to eq "Invalid iat"
  end

  it "401 when token not provided" do
    get path
    expect(last_response.status).to eq 401
    expect(JSON.parse(last_response.body)["token"]).to eq "Nil JSON web token"
  end
end
