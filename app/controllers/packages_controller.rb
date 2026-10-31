class PackagesController < ApplicationController
  before_action :require_login, only: %i[ new create show ]
  def search
    @packages = Package.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%")
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
      flash[:error] = "Something went wrong when trying to create your package."
      redirect_to new_package_path
    end
  end

  def index
    # return 20 random packages
    @packages = Package.order("RANDOM()").limit(20)
  end

  def show
    @packages = Package.where user_id: current_user.id
  end

  private

  def package_params
    params.require(:package).permit(:name, :description, :github_url, :tarball)
  end
end
