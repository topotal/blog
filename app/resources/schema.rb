require "json_world"

Dir[File.dirname(__FILE__) + "/*.rb"].each(&method(:require))

module Api
  class Schema
    include JsonWorld::DSL

    title "Topotal blog API v1"
    description "Topotal API v1 interface document written in JSON Hyper Schema draft v4"

    property :users, links: true, type: Api::Resources::UserResource
    property :user_profiles, links: true, type: Api::Resources::UserProfileResource
    property :entries, links: true, type: Api::Resources::EntryResource
    property :images, links: true, type: Api::Resources::ImageResource
    link href: "https://blog.topotal.com", rel: "self"
  end
end
