module Api
  module V1
    class EntryController < ::Api::V1::BaseController
      before do
        return if request.request_method == "OPTIONS"
        authorization!
      end

      get "/" do
        headers "X-total-count" => Entry.count.to_s
        json(
          Entry.order("id DESC").paginate(per_page: 20, page: params[:page]).map do |entry|
            ::Api::Resources::EntryResource.new(entry)
          end
        )
      end

      get "/:id" do |id|
        halt(404) unless (entry = Entry.find_by_id(id))
        json ::Api::Resources::EntryResource.new(entry)
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

      delete "/:id" do |id|
        json ::Api::Resources::EntryResource.new(Entry.destroy(id))
      end
    end
  end
end
