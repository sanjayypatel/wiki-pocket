class WikisController < ApplicationController
  def index
    @wikis = Wiki.all.by_recently_updated
    @sample_body = true
  end

  def show
    @wiki = Wiki.find(params[:id])
    @sample_body = false
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki saved succesfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki updated succesfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:alert] = "Wiki, #{@wiki.title}, deleted succesfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error deleting wiki. Please try again."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
