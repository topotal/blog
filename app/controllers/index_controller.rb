class IndexController < BaseController
  register WillPaginate::Sinatra

  get "/" do
    @entries = Entry.order("id DESC").page(params[:page])

    @ogp_title = "YAREKASU BLOG | Topotal.com"
    @ogp_image_url = File.join(request.host, "/assets/img/top_ogp.png")

    erb :index
  end

  get "/entry/:yyyy/:mm/:dd/:id" do |_yyyy, _mm, _dd, id|
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      fenced_code_blocks: true,
      tables: true
    )
    @entry = Entry.find_by_id!(id)
    @entry.content = markdown.render(@entry.content) if @entry.content

    @ogp_title = File.join(@entry.title, " | Topotal.com")
    @ogp_image_url = File.join(request.host, @entry.eye_catch_image_url)

    erb :entry
  end
end
