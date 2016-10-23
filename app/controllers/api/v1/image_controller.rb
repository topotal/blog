module Api
  module V1
    class ImageController < ::Api::V1::BaseController
      helpers do
        def parse_data_url(data)
          URI::Data.new(data)
        rescue StandardError => e
          halt(400, { errors: e.to_s }.to_json)
        end
      end

      before do
        return if request.request_method == "OPTIONS"
        authorization!
      end

      get "/" do
        json(
          Image.order("id DESC").paginate(per_page: 20, page: params[:page]).map do |record|
            ::Api::Resources::ImageResource.new(record)
          end
        )
      end

      get "/:id" do |id|
        json ::Api::Resources::ImageResource.new(Image.find_by_id(id))
      end

      post "/" do
        json = parse_json_or_halt(request.body.read)
        data_uri = parse_data_url(json[:content])
        image = Image.create(image: StringIO.new(data_uri.data), image_content_type: data_uri.content_type)
        image.url = File.join(Refile.store.directory.gsub(%r{^public/}, ""), image.image_id)
        image.valid? ? [201, image.save && ::Api::Resources::ImageResource.new(image).to_json] : [400, image.errors.messages.to_json]
      end

      post "/:id" do |id|
        image = Image.find_by_id(id)
        json = parse_json_or_halt(request.body.read)
        data_uri = parse_data_url(json[:content])
        if image.update_attributes(image: StringIO.new(data_uri.data), image_content_type: data_uri.content_type)
          [201, ::Api::Resources::ImageResource.new(image).to_json]
        else
          [400, image.errors.messages.to_json]
        end
      end
    end
  end
end
