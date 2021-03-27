class RidesController < ApplicationController
  def index
    if params[:attraction_id]
      binding.pry
      Attraction.find_by(id: params[:attraction_id])
    else
      @attractions = self.attractions
    end
  end

  def show
    if params[:attraction_id]
      @attraction = Attraction.find_by(id: params[:attraction_id])
      @ride = Ride.find_by(id: params[:id])
    end
  end

  def create
    @ride = Ride.new(user_id: current_user.id, attraction_id: params[:attraction_id])
    if @ride.save
      @message = @ride.take_ride
      if @message.nil?
        redirect_to current_user, alert: "Thanks for riding the #{@ride.attraction.name}!!!"
      else
        redirect_to user_path(current_user), alert: @message
      end
    else
      redirect_to attraction_path(params[:attraction_id]), alert: "Some issues in going on this ride..."
    end
  end
end
