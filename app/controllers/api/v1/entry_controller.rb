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
        halt(404) unless (user = User.find_by(name: @payload["name"]))
        entry = user.entries.create(parse_json_or_halt(request.body.read))
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
    end
  end
end
