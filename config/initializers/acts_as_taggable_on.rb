# Extends Tag class for use with FriendlyId

ActsAsTaggableOn::Tag.class_eval do  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end

ActsAsTaggableOn.remove_unused_tags = true
ActsAsTaggableOn.force_lowercase = true

if Rails.env.development?
  ActsAsTaggableOn.force_binary_collation = true
end