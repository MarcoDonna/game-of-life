class GameFrame < ApplicationRecord
  belongs_to :game

  belongs_to  :prev_frame, class_name: "GameFrame", optional: true
  belongs_to  :next_frame, class_name: "GameFrame", optional: true

  validates :game, presence: true
  validates :state, presence: true

  validate :state_format
  validate :state_size

  def create_next_frame
    new_frame = GameFrame.create(game: self.game, state: next_step_state, prev_frame: self)
    self.next_frame = new_frame
    self.save

    return new_frame  
  end

  private

  def state_format
    return if state.blank?

    errors.add(:state, "can only contain * or . ") if state.count("^*\.") == state.size
  end

  def state_size
    return if state.blank?

    expected_state_size = game.board_height * game.board_width
    errors.add(:state, "board size mismatch") unless state.size == expected_state_size
  end

  def next_step_state
    Array.new(self.game.board_size) { ["*", "."].sample }.join()
  end
end
