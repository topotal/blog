class Entry < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :eye_catch_image_url, presence: true
  validates :publish_date, presence: true
  belongs_to :user, foreign_key: "user_id"
  self.per_page = 3

  def render_content
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      fenced_code_blocks: true,
      tables: true
    )
    markdown.render(self.content) if self.content
  end

  def summarize_content(length = 100)
    Nokogiri::HTML(self.render_content).inner_text.truncate(length)
  end
end
