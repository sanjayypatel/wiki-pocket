class Link < ActiveRecord::Base
  belongs_to :user
  has_many :references
  has_many :wikis, through: :references

  acts_as_taggable
end
