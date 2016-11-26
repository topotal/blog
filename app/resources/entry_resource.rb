module Api
  module Resources
    class EntryResource
      include JsonWorld::DSL

      title "Entry object"
      description "A entry object of topotal blog. All APIs requirements token with `Authorization: Bearer` HTTP header."

      property(:id, type: Integer, description: "Entry id", example: 1)
      property(:title, type: String, description: "Entry title", example: "Blog title")
      property(:content, type: String, description: "Entry content", example: "Awesome blog content written in markdown")
      property(:eye_catch_image_url, type: String, description: "Entry eye-catching image url", example: "Awesome blog entry eye-catching image url")
      property(:created_at, type: Time, description: "Entry created at", example: "2012-07-26T01:00:00+09:00")
      property(:updated_at, type: Time, description: "Entry updated at", example: "2012-07-26T01:00:00+09:00")
      property(:publish_date, type: Time, description: "Entry publish time", example: "2012-07-26T01:00:00+09:00")
      property(:published, type: TrueClass, description: "Entry is published", example: true)
      property(:author, type: String, description: "Entry author name", example: "topotan")

      link(
        :entries,
        method: "GET",
        description: "List exisiting entries",
        path: "/api/v1/entries",
        parameters: {
          page: { example: 1, type: String, optional: true, pattern: /[0-9]+/ },
        },
        rel: "instances"
      )

      link(
        :entries,
        method: "GET",
        description: "Information an exisiting entry find by id",
        path: "/api/v1/entries/:id",
        rel: "self"
      )

      link(
        :entries,
        method: "POST",
        description: "Create a new entry",
        path: "/api/v1/entries",
        parameters: {
          title: { example: "Awesome blog title", type: String },
          eye_catch_image_url: { example: "Awesome blog eye-catching image url", type: String },
          content: { example: "Awesome blog content written in markdown", type: String },
          publish_date: { example: "2012-07-26T01:00:00+09:00", type: Date },
          published: { example: "true", type: TrueClass, optional: true },
        },
        rel: "create"
      )

      link(
        :entries,
        method: "POST",
        description: "Update an exisiting entry",
        path: "/api/v1/entries/:id",
        parameters: {
          title: { example: "Awesome blog title", type: String },
          eye_catch_image_url: { example: "Awesome blog eye-catching image url", type: String },
          content: { example: "Awesome blog content written in markdown", type: String },
          publish_date: { example: "2012-07-26T01:00:00+09:00", type: Date },
          published: { example: "true", type: TrueClass, optional: true },
        },
        rel: "create"
      )

      link(
        :entries,
        method: "DELETE",
        description: "Delete an exisiting entry",
        path: "/api/v1/entries/:id",
        rel: "destroy"
      )

      attr_reader :id, :title, :content, :eye_catch_image_url, :created_at, :updated_at, :publish_date, :author, :published
      def initialize(entry)
        @id = entry.id
        @title = entry.title
        @content = entry.content
        @eye_catch_image_url = entry.eye_catch_image_url
        @created_at = entry.created_at
        @updated_at = entry.updated_at
        @publish_date = entry.publish_date
        @published = entry.published
        @author = entry.user.name
      end
    end
  end
end
