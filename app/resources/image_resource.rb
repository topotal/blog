module Api
  module Resources
    class ImageResource
      include JsonWorld::DSL

      title "Image object"
      description "A image object of topotal blog. All APIs requirements token with `Authorization: Bearer` HTTP header."

      property(:id, type: Integer, description: "image id", example: 1)
      property(
        :url,
        type: String,
        description: "Image url path",
        example: "assets/img/upload/8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9"
      )
      property(
        :image_id,
        type: String,
        description: "image data id",
        example: "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9"
      )
      property(:image_content_type, type: String, description: "Image content type", example: "image/jpeg")

      link(
        :images,
        method: "GET",
        description: "List exisiting images",
        path: "/api/v1/images",
        parameters: {
          page: { example: 1, type: Integer },
        },
        rel: "instances"
      )

      link(
        :images,
        method: "GET",
        description: "Information an exisiting image find by id",
        path: "/api/v1/images/:id",
        rel: "self"
      )

      link(
        :images,
        method: "POST",
        description: "Create a new image",
        path: "/api/v1/images",
        parameters: {
          content: { example: "data:image/jpeg;base64,base64encodedstring......", type: String },
        },
        rel: "create"
      )

      link(
        :images,
        method: "POST",
        description: "Update an exisiting image",
        path: "/api/v1/images/:id",
        parameters: {
          content: { example: "data:image/jpeg;base64,base64encodedstring......", type: String },
        },
        rel: "create"
      )

      link(
        :images,
        method: "DELETE",
        description: "Delete an exisiting image",
        path: "/api/v1/images/:id",
        rel: "destroy"
      )

      attr_reader :id, :url, :image_id, :image_content_type
      def initialize(image)
        @id = image.id
        @url = image.url
        @image_id = image.image_id
        @image_content_type = image.image_content_type
      end
    end
  end
end
