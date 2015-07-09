class LinksController < ApplicationController

  def new
    @link = Link.new
    authorize @link
  end

  def create
    @link = current_user.links.build(link_params)
    authorize @link
    if @link.save
      flash[:notice] = "Link saved succesfully."
      redirect_to @link
    else
      flash[:error] = "There was an error saving link. Please try again."
      render :new
    end
  end

  def show
    @link = Link.find(params[:id])
    authorize @link
    linked_wikis = @link.wikis
    @wikis = linked_wikis.select { |w| policy(w).show? }.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @link = Link.find(params[:id])
    authorize @link
  end

  def update
    @link = Link.find(params[:id])
    authorize @link
    if @link.update_attributes(link_params)
      flash[:notice] = "Link edit succesfully."
      redirect_to @link
    else
      flash[:error] = "There was an error editing link. Please try again."
      render :edit
    end
  end

  def destroy
    @link = Link.find(params[:id])
    authorize @link
    if @link.destroy
      flash[:alert] = "Link, \"#{@link.title}\" deleted succesfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting link. Please try again."
      render :show
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :tag_list)
  end

end