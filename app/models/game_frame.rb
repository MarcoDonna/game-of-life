class GameFrame < ApplicationRecord
  belongs_to :game

  belongs_to  :prev_frame, class_name: "GameFrame", optional: true
  belongs_to  :next_frame, class_name: "GameFrame", optional: true

  validates :game, presence: true
  validates :state, presence: true

  validate :state_format
  validate :state_size

  before_destroy :unlink_frames

  def create_next_frame
    new_frame = GameFrame.create(game: self.game, state: next_step_state, prev_frame: self)
    self.next_frame = new_frame
    self.save

    return new_frame  
  end

  private

  def unlink_frames
    prev_frame&.update!(next_frame: nil) if prev_frame
    next_frame&.update!(prev_frame: nil) if next_frame

    
    puts self.prev_frame
    puts self.next_frame
  end

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
    self.state.chars.map.with_index do |cell, cell_index|
      neighbours = cell_neighbours(cell_index)

      alive_neighbours = neighbours.count("*")
      if(cell == "*")
        if(alive_neighbours < 2 || alive_neighbours > 3)
          next "."
        else
          next "*"
        end
      else
        if(alive_neighbours == 3)
          next "*"
        else
          next "."
        end
      end
    end.join()
  end

  def cell_neighbours(cell_index)
    cell_neighbours_indexes(cell_index).map { |neighbours_index| self.state[neighbours_index] }
  end

  def cell_neighbours_indexes(cell_index)
    board_width = self.game.board_width
    board_height = self.game.board_height

    cell_row = cell_index / board_width
    cell_col = cell_index % board_width

    neighbours = []

    (-1..1).each do |delta_row|
      (-1..1).each do |delta_col|
        next if delta_col == 0 && delta_row == 0

        neighbours_row = cell_row + delta_row
        neighbours_col = cell_col + delta_col

        next if neighbours_row < 0 || neighbours_row >= board_height
        next if neighbours_col < 0 || neighbours_col >= board_width

        neighbours << (neighbours_row * board_width + neighbours_col)
      end
    end

    neighbours
  end
end
