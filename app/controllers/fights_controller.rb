class FightsController < ApplicationController
  before_action :set_fight, only: [:show, :run]

  def show
  end

  def run
    $loglevel = 3
    if @fight.complete then
      redirect_to event_fight_path(@event,@fight), notice: 'Fight alredy ran.'      
    else
      @fight.run
      redirect_to event_fight_path(@event,@fight), notice: 'Fight Complete!'
    end
  end


  private
  #used by controller to set class vars
  def set_fight
  	@fight = Fight.find(params[:id])
  	@fighters = @fight.gladiators
  	@event = @fight.event
  end

end
