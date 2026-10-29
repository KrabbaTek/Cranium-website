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
    @package = Package.new
  end

  def create
    @package = Package.new(
      package_params.merge(user_id: current_user.id, downloads_count: 0)
    )

    if @package.save
      flash[:success] = "Created and published your new package #{params[:name]}!"
      redirect_to root_path
    else
      # flash[:error] = "Something went wrong when trying to create your package."
      flash[:error] = @package.errors.full_messages.to_sentence
      redirect_to new_package_path
    end
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

  private

  def package_params
    params.require(:package).permit(:name, :description, :github_url, :tarball)
  end
end
