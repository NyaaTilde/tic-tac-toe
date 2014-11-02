class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.status = 1

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.status == 1
      if not Game.playable(@game[params[:play]])
        redirect_to @game, notice: "You can not play there!"
      else
        @game.play(params[:play])
        @game.status = 2 unless @game.endgame.nil?
        @game.save!

        if @game.endgame.nil?
          redirect_to @game
        else
          winner = "X won!" if @game.endgame == 1
          winner = "Y won!" if @game.endgame == 2
          winner = "Draw!" if @game.endgame == 3

          redirect_to @game, notice: "Game has reached an end! #{winner}"
        end
      end
    else
      redirect_to @game, notice: 'You can not play a game that has reached an end!'
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:proponent, :opponent)
    end
end
