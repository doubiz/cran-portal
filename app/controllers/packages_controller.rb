class PackagesController < ApplicationController

  def index
    if params[:q].present?
      @packages = Package.where("name like ?","%#{params[:q]}%").order("date DESC").paginate(:page => params[:page], :per_page => 100)
    else
      @packages = Package.order("date DESC").paginate(:page => params[:page], :per_page => 100)
    end
  end

  def show
    @package = Package.find params[:id]
  end
end