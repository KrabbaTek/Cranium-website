# frozen_string_literal: true

module Api
  class PackagesController < ApplicationController
    rate_limit to: 10, within: 1.minute
    before_action :find_package, except: %i[ omakase random]

    def install
      if @package.nil?
        return render json: { error: "Package not found" }, status: :not_found
      end

      @package.increment! :downloads_count

      tarball = url_for @package.tarball

      render json: { tarball: tarball }
    end

    def omakase
      # weird edge case that will never exist in the real world
      if Package.all.empty?
        return render json: { error: "No packages found" }, status: :not_found
      end

      # TODO: change this to the full implementation
      @package = Package.order(downloads_count: :desc).first

      response = {
        name: @package.name,
        description: @package.description,
        github_url: @package.github_url
      }

      render json: response
    end

    def clone_library
      render json: { github_url: @package.github_url }
    end

    def random
      if Package.all.empty?
        return render json: { error: "No packages found" }, status: :not_found
      end

      @package = Package.all.sample

      response = {
        name: @package.name,
        description: @package.description,
        github_url: @package.github_url
      }

      render json: response
    end

    private

    def find_package
      # we can do this because names are unique!
      @package = Package.find_by name: params[:name]
    end
  end
end
