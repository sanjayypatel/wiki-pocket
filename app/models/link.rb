class Link < ActiveRecord::Base
  belongs_to :user
  has_many :references
  has_many :wikis, through: :references

  acts_as_taggable

  def self.search(query)
    search_tags = query.split(' ')
    tag_matched_links = Link.tagged_with(search_tags, :any => true)
    title_matched_links = Link.where("title LIKE ?", "%#{query}%")
    url_matched_links = Link.where("url LIKE ?", "%#{query}%")
    return tag_matched_links + title_matched_links + url_matched_links
  end

end
