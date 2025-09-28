class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games
  has_many :shared_games
  has_many :games_shared_with, through: :shared_games, source: :game

  def visible_games
    active_shared_games = shared_games.where(active: true)

    Game.where(id: active_shared_games.select(:id)).or(Game.where(id: games.select(:id))).order(created_at: :desc)
  end
end
