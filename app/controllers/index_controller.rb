class IndexController < BaseController
  register WillPaginate::Sinatra

  get "/" do
    @entries = Entry.order("id DESC").page(params[:page])
    erb :index
  end

  get "/diary/:id" do |id|
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      fenced_code_blocks: true,
      tables: true
    )
    @entry = Entry.find_by_id!(id)

    @entry.content = markdown.render(@entry.content)
    erb :diary
  end

  get "/edit/" do
    @entry = Entry.new
    erb :edit
  end

  get "/edit/:id" do |id|
    p id
    @entry = Entry.find_by_id!(id)
    erb :edit
  end

  get "/upload" do
    erb :upload
  end
end
