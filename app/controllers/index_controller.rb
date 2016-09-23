class IndexController < Base
  register WillPaginate::Sinatra

  get "/" do
    @articles = Article.order("id DESC").page(params[:page])
    erb :index
  end

  get "/diary/:id" do
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      fenced_code_blocks: true,
      tables: true
    )
    @article = Article.find_by_id!(params[:id])

    @article.content = markdown.render(@article.content)
    erb :diary
  end

  get "/edit/" do
    @article = Article.new
    erb :edit
  end

  get "/edit/:id" do
    @article = Article.find_by_id!(params[:id])
    erb :edit
  end

  get "/upload" do
    erb :upload
  end
end
