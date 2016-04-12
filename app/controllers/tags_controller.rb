class TagsController < ApplicationController

  def show
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    tagged_wikis = Wiki.tagged_with(@tag.name)
    @wikis = tagged_wikis.select { |w| policy(w).show? }.paginate(page: params[:page], per_page: 5)
  end

  def index
    if params[:tag_search]
      @tags = ActsAsTaggableOn::Tag.where('name LIKE ?', "%#{params[:tag_search]}%").paginate(page: params[:page], per_page: 5)
    else
      @tags = ActsAsTaggableOn::Tag.most_used(100).paginate(page: params[:page], per_page: 10)
    end
  end

end