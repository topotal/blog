class ApiController < BaseController
  helpers do
    def tokenize(name, expire = 3600)
      header = { iat: Time.now.to_i, exp: Time.now.to_i + expire, iss: ENV["JWT_ISSUER"] }
      content = { scopes: ["*"], name: name }
      JWT.encode(header.merge(content), ENV["JWT_SECRET"], "HS256")
    end

    def authorization!
      options = { algorithm: "HS256", iss: ENV["JWT_ISSUER"] }
      bearer = request.env.fetch("HTTP_AUTHORIZATION", "").slice(7..-1)
      begin
        @payload, @header = JWT.decode(bearer, ENV["JWT_SECRET"], true, options)
      rescue JWT::DecodeError
        halt([401, { "Content-Type" => "text/plain" }, ["A token must be passed."]])
      rescue JWT::ExpiredSignature
        halt([403, { "Content-Type" => "text/plain" }, ["The token has expired."]])
      rescue JWT::InvalidIssuerError
        halt([403, { "Content-Type" => "text/plain" }, ["The token does not have a valid issuer."]])
      rescue JWT::InvalidIatError
        halt([403, { "Content-Type" => "text/plain" }, ["The token does not have a valid 'issued at' time."]])
      end
    end
  end

  before do
    content_type :json, charset: "utf-8"
  end

  before "/v1/entries*" do
    authorization!
  end

  get "/v1/entries" do
    json Entry.order("id DESC").paginate(per_page: 20, page: params[:page]).map do |record|
      ::Api::Resources::EntryResource.new(record)
    end
  end

  get "/v1/entries/:id" do |id|
    json ::Api::Resources::EntryResource.new(Entry.find_by_id(id))
  end

  post "/v1/entries" do
    params = JSON.parse(request.body.read, symbolize_names: true)
    title, content, eye_catching = params.values_at(:title, :content, :eye_catching)
    json Entry.create(title: title, content: content, eye_catching: eye_catching)
  end

  post "/v1/entries/:id" do |id|
    params = JSON.parse(request.body.read, symbolize_names: true)
    title, content, eye_catching = params.values_at(:title, :content, :eye_catching)
    json Entry.find_by_id(id).update(title: title, content: content, eye_catching: eye_catching)
  end

  post "/v1/users/register" do
    params = JSON.parse(request.body.read, symbolize_names: true)
    name, password = params.values_at(:name, :password)
    User.create!(name: name, password: password, password_confirmation: password)
  end

  post "/v1/users/login" do
    params = JSON.parse(request.body.read, symbolize_names: true)
    name, password = params.values_at(:name, :password)

    halt(401) unless User.find_by!(name: name).authenticate(password)
    json({ token: tokenize(name) })
  end

  post "/v1/image" do
    return unless params[:file]
    access_path = "img/upload/#{params[:file][:filename]}"
    save_path = "./public/" + access_path
    File.open(save_path, "wb") do |f|
      p params[:file][:tempfile]
      f.write params[:file][:tempfile].read
      Image.create(
        url: access_path
      )
    end
  end
end
