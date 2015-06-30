class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :most_recently_updated, -> { order('updated_at DESC').limit(5)}
end
