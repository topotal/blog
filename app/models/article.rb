require 'active_record'
require 'will_paginate/active_record'

class Article < ActiveRecord::Base
  # １ページに表示する件数を10件とする
  self.per_page = 3
end
