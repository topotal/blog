class IndexController < BaseController
  register WillPaginate::Sinatra

  get "/" do
    @entries = Entry.where(published: true).order("id DESC").page(params[:page])

    @title = "YAREKASU BLOG"
    @description = "Topotalメンバーで運営している技術ブログ？です。「うだうだ言ってねぇでいいからやれカス。」と言われながらインフラからフロントエンドまで様々な分野のノウハウをアウトプットさせられてます。"
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

    @title = @entry.title + " | YAREKASU BLOG"
    @ogp_image_url = URI::HTTP.build(
      scheme: request.scheme,
      host: request.host,
      path: @entry.eye_catch_image_url
    ).to_s

    erb :entry
  end
end
