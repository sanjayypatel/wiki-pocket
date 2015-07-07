class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @collaboration = Collaboration.new
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki saved succesfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @collaboration = Collaboration.new
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki updated succesfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:alert] = "Wiki, \"#{@wiki.title}\" deleted succesfully."
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
