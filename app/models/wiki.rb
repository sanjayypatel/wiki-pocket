class Wiki < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_taggable

  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  scope :most_recently_updated, -> { order('updated_at DESC') }
  scope :only_private, -> { where(:private => true) }
  after_initialize :init

  validates :title, presence: true, uniqueness: true


  def public?
    !private?
  end

  def make_public
    self.update_attribute(:private, false)
  end

  def init
    self.private = false if self.private.nil?
  end

  def is_owned_by?(user)
    self.users.include?(user)
  end

  def self.search(keyword)
    title_matched_wikis = Wiki.where('title LIKE ?', "%#{keyword}%")
    body_matched_wikis = Wiki.where('body LIKE ?', "%#{keyword}%")
    search_tags = keyword.split(' ')
    tag_matched_wikis = Wiki.tagged_with(search_tags, any: true)
    return title_matched_wikis + body_matched_wikis + tag_matched_wikis
  end

end

