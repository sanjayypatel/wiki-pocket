class TagsController < ApplicationController

  def show
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    tagged_wikis = Wiki.tagged_with(@tag.name)
    @wikis = tagged_wikis.select { |w| policy(w).show? }.paginate(page: params[:page], per_page: 10)
  end

  def index
    @tags = ActsAsTaggableOn::Tag.most_used(100).paginate(page: params[:page], per_page: 10)
    
  end

end