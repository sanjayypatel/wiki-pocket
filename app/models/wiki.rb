class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :most_recently_updated, -> { order('updated_at DESC') }
  scope :only_private, -> { where(:private => true) }
  after_initialize :init

  def public?
    !self.private
  end

  def make_public
    self.update_attribute(:private, false)
  end

  def init
    self.private = false if self.private.nil?
  end

end

