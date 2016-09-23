class ApiController < BaseController
  before do
    content_type :json, charset: "utf-8"
  end

  get "/v1/articles" do
    return {
      status: 200,
      total: Article.count,
      articles: Article.order("id DESC").paginate(per_page: 20, page: params[:page]),
    }.to_json
  end

  get "/v1/article" do
    Article.find_by_id(params[:id]).to_json
  end

  post "/v1/article" do
    if params[:id].blank?
      target = Article.create(
        title: params[:title].to_s,
        content: params[:content].to_s,
        eye_catching: params[:eye_catching]
      )
    else
      target = Article.find_by_id(params[:id])
      target.update(
        title: params[:title].to_s,
        content: params[:content].to_s,
        eye_catching: params[:eye_catching].to_s
      )
    end

    return {
      status: 200,
      article: target,
    }.to_json
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

  post "/v1/register" do
    name = params[:name]
    password = params[:password]
    user = User.new(name: name, password: password, password_confirmation: password, access_key: SecureRandom.hex(10), access_secret_key: SecureRandom.hex(10))
    user.save
    return {
      access_key: user.access_key,
      access_secret_key: user.access_secret_key,
    }.to_json
  end

  post "/v1/login" do
    name = params[:name]
    password = params[:password]
    return 401 unless name && password

    user = User.find_by(name: name)
    return 401 unless user.authenticate(password)

    return {
      access_key: user.access_key,
      access_secret_key: user.access_secret_key,
    }.to_json
  end
end
