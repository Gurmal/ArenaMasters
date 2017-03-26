class GladiatorsController < ApplicationController
  before_action :set_team
  before_action :set_gladiator, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /gladiators
  # GET /gladiators.json
  def index
    @gladiators = @team.gladiators.all
  end

  # GET /gladiators/1
  # GET /gladiators/1.json
  def show
    @myfights = @gladiator.fights
  end

  # GET /gladiators/new
  def new
    @gladiator = @team.gladiators.build
  end

  # GET /gladiators/1/edit
  def edit
  end

  # POST /gladiators
  # POST /gladiators.json
  def create
    @gladiator = @team.gladiators.build(gladiator_params)

    respond_to do |format|
      if @gladiator.save
        format.html { redirect_to team_gladiators_path(@team), notice: 'Gladiator was successfully created.' }
        format.json { render :show, status: :created, location: @gladiator }
      else
        format.html { render :new }
        format.json { render json: @gladiator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gladiators/1
  # PATCH/PUT /gladiators/1.json
  def update
    respond_to do |format|
      if @gladiator.update(gladiator_params)
        format.html { redirect_to team_gladiators_path(@team), notice: 'Gladiator was successfully updated.' }
        format.json { render :show, status: :ok, location: @gladiator }
      else
        format.html { render :edit }
        format.json { render json: @gladiator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gladiators/1
  # DELETE /gladiators/1.json
  def destroy
    @gladiator.destroy
    respond_to do |format|
      format.html { redirect_to team_gladiators_url, notice: 'Gladiator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gladiator
      @gladiator = @team.gladiators.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gladiator_params
      params.require(:gladiator).permit(:team_id, :name, :fightStyle, :str, :dex, :spd, :con, :chr, :intl, :birth, :firstfight, :death, :wounds, :reputation, :hp, :hitmod, :strmod, :initiative)
    end

    def set_team
      @team = Team.find(params[:team_id])
    end
end
