class LinksController < ApplicationController
  def index
    @user = current_user
    @links = Link.all
  end

  def edit
    @link = Link.find_by(id: params[:id])
    if params[:format].class == String
      if params[:format] == "mark as read"
        @link.update(read: true)
      else
        @link.update(read: false)
      end
      redirect_to links_path
    end
  end

  def create
    link = Link.new(link_params)
    if link.save
      flash[:notice] = "Successfully saved link."
    else
      flash[:notice] = "URL is not valid."
    end
    redirect_to links_path
  end

  def update
    link = Link.find_by(id: params[:id])
    if link.update(link_params)
      flash[:notice] = "Successfully saved link."
      redirect_to links_path
    else
      flash[:notice] = "Save unsuccessful."
      redirect_to edit_link_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title)
  end
end
