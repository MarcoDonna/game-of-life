class GameFramesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_frame

  def new
    @new_frame = @frame.create_next_frame

    respond_to do |format|
      format.html { redirect_to show_game_frame_url(@new_frame) }
    end    
  end

  def show
    @prev_frame = @frame.prev_frame

    respond_to do |format|
      format.html
    end
  end

  private

  def find_frame
    @frame = GameFrame.find(params[:id])

    redirect_to games_url unless @frame.game.user == current_user
  end
end
