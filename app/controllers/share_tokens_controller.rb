class ShareTokensController < ApplicationController
  def new
    @token = ShareToken.new(game: Game.find(params[:game_id]))
    
    redirect_to game_url(params[:game_id]) unless @token.save
  end

  def accept
    @token = ShareToken.find_by(share_token: params[:token])

    if(@token && @token.valid? && @token.expired != true)
        @token.update(expired: true)
        SharedGame.create(user: current_user, game: @token.game, active: true)

        redirect_to game_url(@token.game)
    else
        redirect_to games_url
    end
  end
end
