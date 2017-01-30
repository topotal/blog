class Entry < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :eye_catch_image_url, presence: true
  validates :publish_date, presence: true
  belongs_to :user, foreign_key: "user_id"
  self.per_page = 3

  def summarize
    Nokogiri::HTML(self.content).inner_text
  end
end
