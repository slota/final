class LinksController < ApplicationController
  def index
    @user = current_user
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

  private

  def link_params
    params.require(:link).permit(:url, :title)
  end
end
