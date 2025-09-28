class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    @frame = @game.frames.last
  end

  def new
    @game = Game.new(user: current_user)
  end

  def create
    game_params = create_game_params

    @game = Game.new()
    @game.user = current_user

    if(game_params[:file].present?)
      assign_attributes_from_file(@game)
    else
      @game.assign_attributes(game_params)
      board_size = @game.board_height * @game.board_width
      @initial_state = Array.new(board_size) { ["*", "."].sample }.join
    end
      
    if(@game.save)
      GameFrame.create(game: @game, state: @initial_state)
      redirect_to @game
    else
      render :new
    end
  end

  private

  def create_game_params
    params.expect(game: [:board_width, :board_height, :file])
  end

  def assign_attributes_from_file(game)
    file = create_game_params[:file].read
    game_data = file.each_line.map(&:strip)

    board_dimensions = game_data[1].split(" ")
      
    @game.board_height = board_dimensions[0].to_i
    @game.board_width = board_dimensions[1].to_i

    @initial_state = game_data[2..].join()
  end
end
