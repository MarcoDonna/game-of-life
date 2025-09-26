class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = current_user.games
  end

  def new
    @game = Game.new(user: current_user)
  end

  def create
    @game = Game.new(create_game_params)
    @game.user = current_user

    if(@game.save)
      board_size = @game.board_width * @game.board_height
      initial_frame = GameFrame.create(game: @game, state: Array.new(board_size) { ["*", "."].sample }.join())

      redirect_to games_url
    else
      render :new
    end
  end

  private

  def create_game_params
    params.expect(game: [:board_width, :board_height])
  end
end
