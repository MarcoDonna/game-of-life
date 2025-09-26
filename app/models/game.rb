class Game < ApplicationRecord
  belongs_to :user
  has_many :game_frames

  validates :user, presence: true
  validates :board_width, presence: true
  validates :board_height, presence: true

  def frames 
    self.game_frames
  end
end
