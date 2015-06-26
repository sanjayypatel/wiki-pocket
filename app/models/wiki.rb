class Wiki < ActiveRecord::Base
  belongs_to :user


  scope :by_recently_updated, -> { order('updated_at DESC')}
end
