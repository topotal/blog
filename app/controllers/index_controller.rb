class IndexController < BaseController
  register WillPaginate::Sinatra

  get "/" do
    @entries = Entry.order("id DESC").page(params[:page])

    scheme_and_host = request.scheme + "://" + request.host
    @ogp_title = "YAREKASU BLOG | Topotal.com"
    @ogp_image_url = File.join(scheme_and_host, "/assets/img/top_ogp.png")

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

    scheme_and_host = request.scheme + "://" + request.host
    @ogp_title = File.join(@entry.title, " | Topotal.com")
    @ogp_image_url = File.join(scheme_and_host, @entry.eye_catch_image_url)

    erb :entry
  end
end
