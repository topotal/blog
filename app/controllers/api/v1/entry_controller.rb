module Api
  module V1
    class EntryController < ::Api::V1::BaseController
      before do
        authorization!
      end

      get "/" do
        json Entry.order("id DESC").paginate(per_page: 20, page: params[:page]).map do |record|
          ::Api::Resources::EntryResource.new(record)
        end
      end

      get "/:id" do |id|
        json ::Api::Resources::EntryResource.new(Entry.find_by_id(id))
      end

      post "/" do
        entry = User.find_by!(name: @payload["name"]).entries.create(parse_json_or_halt(request.body.read))
        entry.valid? ? [201, ::Api::Resources::EntryResource.new(entry).to_json] : [400, entry.errors.messages.to_json]
      end

      post "/:id" do |id|
        entry = Entry.find_by_id(id)
        if entry.update_attributes(parse_json_or_halt(request.body.read))
          [201, ::Api::Resources::EntryResource.new(entry).to_json]
        else
          [400, entry.errors.messages.to_json]
        end
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
    end
  end
end
