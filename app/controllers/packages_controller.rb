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
    # TODO: this
  end

  def index
    # TODO: eventually, when the packages range into the thousands, we'll want to only pull out a couple.
    # This will work for a good amount of time, however.
    @packages = Package.all
  end

  def show
    @packages = Package.find_by user_id: current_user.id
    @packages ||= []
  end
end
