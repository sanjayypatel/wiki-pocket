class ReferencesController < ApplicationController

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @reference = @wiki.references.build(reference_params)
    if @reference.save
      flash[:notice] = "Link added succesfully."
    else
      flash[:error] = "There was an error adding link."
    end
    redirect_to edit_wiki_path(@wiki)
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @reference = Reference.find(params[:id])
    if @reference.destroy
       flash[:notice] = "Link removed from wiki."
    else
      flash[:error] = "There was an error removing link."
    end
    redirect_to edit_wiki_path(@wiki)
  end

  private

  def reference_params
    params.require(:reference).permit(:link_id)
  end

end