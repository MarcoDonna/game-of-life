class GameFrame < ApplicationRecord
  belongs_to :game

  has_one :prev_frame, class_name: "GameFrame"
  has_one :next_frame, class_name: "GameFrame"
end
