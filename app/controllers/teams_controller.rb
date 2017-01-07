class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :backfill]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.where(active: true)
    
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  def showInActive
    @teams = Team.where(active: false) + Team.where(active: nil)
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #used to populate a team back up to 10 gladiators
  def backfill
    @team.backfill

    respond_to do |format|
      format.html { redirect_to @team, notice: 'Team populated.' }
      format.json { render json: @team.errors, status: :unprocessable_entity }
    end
  end

  #fills all active teams up to full
  def backfillAll
     _teams = Team.where(active: true)
    _teams.each{|x| x.backfill}
    
      respond_to do |format|
        format.html { redirect_to teams_url, notice: 'Teams topped off.' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :accountbalance, :reputation, :id)
    end
end
