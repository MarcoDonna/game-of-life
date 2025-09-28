class Game < ApplicationRecord
  belongs_to :user
  has_many :game_frames
  has_many :shared_games
  has_many :users_with_shared_access,  through: :shared_games, source: :user

  validates :user, presence: true
  validates :board_width, presence: true
  validates :board_height, presence: true

  def board_size
    self.board_width * self.board_height
  end

  def frames 
    self.game_frames
  end
end
