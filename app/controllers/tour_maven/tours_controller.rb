module TourMaven
  class ToursController < ApplicationController
    def index
      @tours = Tour.order(:label).all
    end

    def new
      @tour = Tour.new
    end

    def create
      @tour = Tour.new(tour_params)
      @tour.save!

      redirect_to tours_path
    end

    def edit
      @tour = Tour.find(params[:id])
    end

    def update
      @tour = Tour.find(params[:id])
      @tour.update(tour_params)

      redirect_to tours_path
    end

    private

    def tour_params
      params.require(:tour).permit(:label, :configuration, :page_filter, :content_selector)
    end
  end
end