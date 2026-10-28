class PackagesController < ApplicationController
  def search
    @packages = Package.find_by name: params[:name].downcase
    @packages ||= []
  end

  # show the details for a given task
  def details
    @package = Package.find(params[:id])
  end

  def new

  end

  def create

  end
end
