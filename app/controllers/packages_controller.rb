class PackagesController < ApplicationController
  before_action :require_login, only: %i[ new create show ]
  def search
    @packages = Package.where("name LIKE ?", "%#{params[:name].downcase}%")
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
    @packages = Package.where user_id: current_user.id
  end

  # TODO: separate these methods into a different module/controller

  def random
    @package = Package.all.sample

    response = {
      name: @package.name,
      description: @package.description,
      github_url: @package.github_url
    }

    render json: response
  end

  def clone_library
    # we can do this because names are unique!
    @package = Package.find_by name: params[:name]

    render json: { github_url: @package.github_url }
  end

  private

  def package_params
    params.require(:package).permit(:name, :description, :github_url, :tarball)
  end
end
