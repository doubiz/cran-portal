class ContributorsController < ApplicationController

  def show
    @contributor = Contributor.find params[:id]
    @authored_packages = @contributor.authored_packages
    @maintaining_packages = @contributor.maintaining_packages
  end
end