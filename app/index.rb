require "sinatra/base"
require "mysql2"
require "active_record"
require "sinatra/activerecord"
require "will_paginate"
require "redcarpet"
require "securerandom"
require_relative "models/article"
require_relative "models/image"
require_relative "models/users"

class Index < Sinatra::Base
  register WillPaginate::Sinatra

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  set :public_folder, File.expand_path(
    File.join(root, "..", "public")
  )
  set :database_file, "config/database.yml"

  def article(id)
    return nil if id.nil?
    Article.find id
  end

  def articles(page)
    Article.order("id DESC").page(page)
  end

  get "/" do
    @articles = articles(params[:page])
    erb :index
  end

  get "/diary" do
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      fenced_code_blocks: true,
      tables: true
    )
    @article = article(params[:id])
    @article.content = markdown.render(@article.content)
    erb :diary
  end

  get "/edit" do
    @article = article(params[:id])
    erb :edit
  end

  get "/upload" do
    erb :upload
  end

  get "/v1/articles" do
    content_type :json, charset: "utf-8"
    return {
      status: 200,
      total: Article.count,
      articles: Article.order("id DESC").paginate(per_page: 20, page: params[:page]),
    }.to_json
  end

  get "/v1/article" do
    content_type :json, charset: "utf-8"
    return article(params[:id]).to_json
  end

  post "/v1/article" do
    content_type :json, charset: "utf-8"
    if params[:id].blank?
      target = Article.create(
        title: params[:title].to_s,
        content: params[:content].to_s,
        eye_catching: params[:eye_catching]
      )
    else
      target = article(params[:id])
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
