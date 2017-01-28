class FightStylesController < ApplicationController
  before_action :set_fight_style, only: [:show, :edit, :update, :destroy]

  # GET /fight_styles
  # GET /fight_styles.json
  def index
    @fight_styles = FightStyle.all
  end

  # GET /fight_styles/1
  # GET /fight_styles/1.json
  def show
  end

  # GET /fight_styles/new
  def new
    @fight_style = FightStyle.new
  end

  # GET /fight_styles/1/edit
  def edit
  end

  # POST /fight_styles
  # POST /fight_styles.json
  def create
    @fight_style = FightStyle.new(fight_style_params)

    respond_to do |format|
      if @fight_style.save
        format.html { redirect_to @fight_style, notice: 'Fight style was successfully created.' }
        format.json { render :show, status: :created, location: @fight_style }
      else
        format.html { render :new }
        format.json { render json: @fight_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fight_styles/1
  # PATCH/PUT /fight_styles/1.json
  def update
    respond_to do |format|
      if @fight_style.update(fight_style_params)
        format.html { redirect_to @fight_style, notice: 'Fight style was successfully updated.' }
        format.json { render :show, status: :ok, location: @fight_style }
      else
        format.html { render :edit }
        format.json { render json: @fight_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fight_styles/1
  # DELETE /fight_styles/1.json
  def destroy
    @fight_style.destroy
    respond_to do |format|
      format.html { redirect_to fight_styles_url, notice: 'Fight style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fight_style
      @fight_style = FightStyle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fight_style_params
      params.require(:fight_style).permit(:name, :active)
    end
end
