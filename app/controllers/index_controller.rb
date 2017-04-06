class IndexController < BaseController
  register WillPaginate::Sinatra

  get "/" do
    @entries = Entry.where(published: true).order("id DESC").page(params[:page])

    @title = "Topotal Tech Blog"
    @description = "Topotal のメンバーがお届けする技術ブログです。"
    @ogp_image_url = URI::HTTP.build(
      scheme: request.scheme,
      host: request.host,
      path: "/assets/img/top_ogp.png"
    ).to_s

    erb :index
  end

  get "/entry/:yyyy/:mm/:dd/:id" do |_yyyy, _mm, _dd, id|
    @entry = Entry.find_by_id!(id)
    halt(404) unless @entry.published

    @entry.content = @entry.render_content
    @description = @entry.summarize_content

    @title = @entry.title + " | Topotal Tech Blog"
    @ogp_image_url = URI::HTTP.build(
      scheme: request.scheme,
      host: request.host,
      path: @entry.eye_catch_image_url
    ).to_s

    erb :entry
  end
end
