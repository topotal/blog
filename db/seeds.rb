# coding: utf-8
require "bundler/setup"
Bundler.require(:default)

Rack::Builder.parse_file("config.ru")

(1..100).each do |i|
  Entry.create(
    :title => "テストタイトル",
    :content => "テストテキストです。",
    :eye_catching => "test.png",
    :publish_date => "2012-07-26T01:00:00+09:00",
    :user => User.create(name: "test_user", password: "password", password_confirmation: "password")
  )
end
