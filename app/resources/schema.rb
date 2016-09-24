require "json_world"

require_relative "./user_resource.rb"

module Api
  class Schema
    include JsonWorld::DSL

    title "Topotal blog API v1"
    description "Topotal API v1 interface document written in JSON Hyper Schema draft v4"

    property :users, links: true, type: Api::Resources::UserResource
    link href: "https://blog.topotal.com", rel: "self"
  end
end
