class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :buildSchedule, :run]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def buildSchedule
    #take all the gladiators and randomly assign them into fights
    #don't make gladiators from the same team fight each other
    #use a reserve team to solve for imblances (not implemented)

    _fightflag = false
    _fighters = Gladiator.where(death: nil).shuffle
    _i = 0
    #using 100 as a cheap limit on finding a fighter could break for large fights
    while _i < 100 and _fighters.count > 0 do
      if not(_fightflag)
        _fight = @event.fights.create(sequence: _i)
        _fighter1 = _fighters.shift
        _fight.gladiators << _fighter1
        _fightflag = true
      end  
      _j = 0
      while _j < 100 and _j < _fighters.count and _fightflag do
        _fighter2 = _fighters.shift
        if _fighter1.team_id != _fighter2.team_id
          _fight.gladiators << _fighter2
          _fightflag = false  
        else
          _fighters << _fighter2
        end
        _j +=1
      end
      _i+=1
    end
    redirect_to @event, notice: 'Schedule Built.' 
  end

  def run()
    logger.info @event.name + ' has begun!'
    @event.fights.each { |x| x.run }
    @event.runDate = Time.new
    @event.save

    redirect_to @event, notice: 'Fights Run.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :scheduledDate, :runDate)
    end
end
