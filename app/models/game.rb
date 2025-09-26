class Game < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :board_width, presence: true
  validates :board_height, presence: true
end
