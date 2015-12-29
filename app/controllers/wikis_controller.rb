class WikisController < ApplicationController
  def index
    if params[:search]
      @wikis = Wiki.search(params[:search])
      @wikis = @wikis.select{ |w| policy(w).show? }.paginate(page: params[:page], per_page: 10)
    else
      @wikis = policy_scope(Wiki).paginate(page: params[:page], per_page: 10)
    end
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

  def create_wiki_from_link
    @link = Link.find(params[:link_id])
    @wiki = current_user.wikis.build(
        title: @link.title,
        body: "[#{@link.title}](#{@link.url})"
      )
    authorize @wiki
    if @wiki.save
      @reference = @wiki.references.build(link: @link)
      @reference.save
      flash[:notice] = "Wiki create from link succesfully."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error saving wiki. Please try again."
      redirect_to links_path
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @collaboration = Collaboration.new
    if params[:search]
      @reference = Reference.new
      @found_links = Link.search(params[:search])
    end
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
    params.require(:wiki).permit(:title, :body, :private, :tag_list)
  end

end
