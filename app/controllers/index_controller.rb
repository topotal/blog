class IndexController < BaseController
  register WillPaginate::Sinatra

  get "/" do
    @entries = Entry.where(published: true).order("id DESC").page(params[:page])

    @title = ""
    @ogp_title = "YAREKASU BLOG"
    @ogp_image_url = URI::HTTP.build(
      scheme: request.scheme,
      host: request.host,
      path: "/assets/img/top_ogp.png"
    ).to_s

    erb :index
  end

  get "/entry/:yyyy/:mm/:dd/:id" do |_yyyy, _mm, _dd, id|
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      fenced_code_blocks: true,
      tables: true
    )
    @entry = Entry.find_by_id!(id)
    halt(404) unless @entry.published

    @entry.content = markdown.render(@entry.content) if @entry.content

    @title = @entry.title + " | "
    @ogp_title = @entry.title
    @ogp_image_url = URI::HTTP.build(
      scheme: request.scheme,
      host: request.host,
      path: @entry.eye_catch_image_url
    ).to_s

    erb :entry
  end
end
