class GameFramesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_frame

  def new
    board_size = @frame.game.board_height * @frame.game.board_width
    @new_frame = GameFrame.create(game: @frame.game, state: Array.new(board_size) { ["*", "."].sample }.join(), prev_frame: @frame)
    @frame.next_frame = @new_frame
    @frame.save

    # run background job to prepare next N frames

    redirect_to show_game_frame_url(@new_frame)
  end

  def show
    @prev_frame = @frame.prev_frame
  end

  private

  def find_frame
    @frame = GameFrame.find(params[:id])

    redirect_to games_url unless @frame.game.user = current_user
  end
end
