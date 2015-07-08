class LinksController < ApplicationController

  def show
    @link = Link.find(params[:id])
    linked_wikis = @link.wikis
    @wikis = linked_wikis.select { |w| policy(w).show? }.paginate(page: params[:page], per_page: 10)
  end

end