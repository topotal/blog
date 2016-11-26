class UserProfile < ActiveRecord::Base
  validates :screen_name, presence: true
  validates :description, presence: false
  belongs_to :user, foreign_key: "user_id"
  belongs_to :image, foreign_key: "image_id"
end
