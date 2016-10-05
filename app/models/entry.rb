class Entry < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :eye_catching, presence: true
  validates :publish_date, presence: true
  self.per_page = 3
end
