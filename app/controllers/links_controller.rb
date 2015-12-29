class LinksController < ApplicationController

  def index
    if params[:pocket_search]
      @links = []
      @retrieved_links = PocketApi.retrieve({:search => params[:pocket_search], :sort => 'title'})
      @retrieved_links.each do |link_hash, retrieved_link|
        new_link = Link.new(
          user: current_user,
          title: retrieved_link["given_title"],
          url: retrieved_link["given_url"]
        )
        if new_link.title.nil? || new_link.title == ""
          new_link.title = retrieved_link["resolved_title"]
        end
        if new_link.url.nil? || new_link.url == ""
          new_link.url = retrieved_link["resolved_url"]
        end
        @links << new_link
      end
    elsif params[:search]
      @links = Link.search(params[:search])
    else
      @links = Link.all
    end
  end

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

  def create_link_with_wiki
    @link = current_user.links.build(link_params)
    authorize @link
    if @link.save
      @wiki = current_user.wikis.build(
        title: @link.title,
        body: "[#{@link.title}](#{@link.url})"
      )
      @wiki.save
      @reference = @wiki.references.build(link: @link)
      @reference.save
      flash[:notice] = "Wiki created and link saved succesfully."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error saving link. Please try again."
      render :index
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

  def connect_to_pocket
    PocketApi::Connection.client_key = ENV["POCKET_CONSUMER_KEY"]
    redirect_to PocketApi::Connection.generate_authorize_url(ENV["AUTHORIZATION_CALLBACK_URL"])
  end

  def authorize_callback
    @token = PocketApi::Connection.generate_access_token
    session[:access_token_hash] = {current_user.id => @token}
    PocketApi.configure(client_key: ENV["POCKET_CONSUMER_KEY"], access_token: session[:access_token_hash][current_user.id])
    redirect_to links_path
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :tag_list)
  end

end