class ApiController < BaseController
  helpers do
    def tokenize(name, issuer: ENV["JWT_ISSUER"], expire: 3600)
      header = { iat: Time.now.to_i, exp: Time.now.to_i + expire, iss: ENV["JWT_ISSUER"] }
      content = { scopes: ["*"], name: name }
      JWT.encode(header.merge(content), ENV["JWT_SECRET"], "HS256")
    end

    def parse_json_or_halt(body)
      JSON.parse(body, symbolize_names: true)
    rescue StandardError => e
      halt([400, { "Content-Type" => "text/plain" }, e.to_s])
    end

    def authorization!
      options = { algorithm: "HS256", iss: ENV["JWT_ISSUER"], verify_iss: true, verify_iat: true }
      bearer = request.env.fetch("HTTP_AUTHORIZATION", "").slice(7..-1)
      begin
        @payload, @header = JWT.decode(bearer, ENV["JWT_SECRET"], true, options)
      rescue JWT::ExpiredSignature => e
        halt([403, { "Content-Type" => "text/plain" }, e.to_s])
      rescue JWT::InvalidIssuerError => e
        halt([403, { "Content-Type" => "text/plain" }, e.to_s])
      rescue JWT::InvalidIatError => e
        halt([403, { "Content-Type" => "text/plain" }, e.to_s])
      rescue JWT::DecodeError => e
        halt([401, { "Content-Type" => "text/plain" }, e.to_s])
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
    entry = User.find_by!(name: @payload["name"]).entries.create(parse_json_or_halt(request.body.read))
    entry.valid? ? [201, ::Api::Resources::EntryResource.new(entry).to_json] : [400, entry.errors.messages.to_json]
  end

  post "/v1/entries/:id" do |id|
    entry = Entry.find_by_id(id)
    if entry.update_attributes(parse_json_or_halt(request.body.read))
      [201, ::Api::Resources::EntryResource.new(entry).to_json]
    else
      [400, entry.errors.messages.to_json]
    end
  end

  post "/v1/users/register" do
    name, password = parse_json_or_halt(request.body.read).values_at(:name, :password)
    User.create!(name: name, password: password, password_confirmation: password)
  end

  post "/v1/users/login" do
    name, password = parse_json_or_halt(request.body.read).values_at(:name, :password)
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
