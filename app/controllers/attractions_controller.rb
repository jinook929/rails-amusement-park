class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
    @attraction = Attraction.new
  end

  def show
    @attraction = Attraction.find_by_id(params[:id])
    @ride = @attraction.rides.build
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)

    if !@attraction.save
      @attractions = Attraction.all
      @alert = "could not save... plz fill in all boxes"
      render :index
    end

    redirect_to attraction_path(@attraction)
  end

  def edit
    @attraction = Attraction.find_by(id: params[:id])
  end

  def update
    @attraction = Attraction.find_by(id: params[:id])
    @attraction.update(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :happiness_rating, :nausea_rating, :tickets, :min_height)
  end
end
