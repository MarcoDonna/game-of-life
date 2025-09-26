class GameFramesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_frame

  def show
    @prev_frame = @frame.prev_frame
  end

  private

  def find_frame
    @frame = GameFrame.find(params[:id])

    redirect_to games_url unless @frame.game.user = current_user
  end
end
