require 'sinatra/base'
require 'sinatra/reloader'
require 'active_record'
require 'will_paginate'
require 'mysql2'
require 'redcarpet'
require_relative 'models/article'
require_relative 'models/image'


# DB設定ファイルの読み込み
ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(:development)


class Index < Sinatra::Base

  register WillPaginate::Sinatra

  configure do
    register Sinatra::Reloader
  end

  set :public_folder, File.expand_path(
    File.join(root, '..', 'public')
  )


  ### メソッド ###

  # 記事取得
  def article(id)
    if id.nil?
      return nil
    end
    return Article.find id
  end

  # 記事一覧取得
  def articles(page)
    return Article.order('id DESC').page(page)
  end


  ### ページ ###

  # トップページ
  get '/' do
    @articles = articles(params[:page])
    erb :index
  end

  # 記事詳細ページ
  get '/dialy' do
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      :fenced_code_blocks => true,
      :tables => true
    )
    @article = article(params[:id])
    @article.content = markdown.render(@article.content)
    erb :dialy
  end

  # 記事編集ページ
  get '/edit' do
    puts params
    @article = article(params[:id])
    erb :edit
  end

  # 画像アップロードページ
  get '/upload' do
    erb :upload
  end


  ### API ###

  # 記事一覧取得
  get '/v1/articles' do
    content_type :json, :charset => 'utf-8'
    return {
      status: 200,
      total: Article.count,
      articles: Article.order('id DESC').paginate(:per_page => 20, :page => params[:page])
    }.to_json
  end

  # 記事取得
  get '/v1/article' do
    content_type :json, :charset => 'utf-8'
    return article(params[:id]).to_json()
  end

  post '/v1/article' do
    content_type :json, :charset => 'utf-8'
    if params[:id].blank?
      # 記事作成
      target = Article.create(
        title: "#{params[:title]}",
        content: "#{params[:content]}",
        eye_catching: params[:eye_catching]
      )
    else
      # 記事の更新
      target = article(params[:id])
      target.update(
        title: "#{params[:title]}",
        content: "#{params[:content]}",
        eye_catching: "#{params[:eye_catching]}"
      )
    end

    return {
      status: 200,
      article: target
    }.to_json
  end

  # 記事に使う画像を登録
  post '/v1/image' do
    if params[:file]
      access_path = "img/upload/#{params[:file][:filename]}"
      save_path = "./public/" + access_path
      File.open(save_path, 'wb') do |f|
        p params[:file][:tempfile]
        f.write params[:file][:tempfile].read
        Image.create(
          url: access_path
        )
      end
    end
  end

  # 記事に使う画像を取得
  get '/v1/image' do
    print 'bbbb';
  end

end
