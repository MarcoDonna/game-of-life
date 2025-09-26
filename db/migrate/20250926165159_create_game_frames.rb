class CreateGameFrames < ActiveRecord::Migration[8.0]
  def change
    create_table :game_frames do |t|
      t.references :game, null: false, foreign_key: true
      t.references :prev_frame, foreign_key: { to_table: :game_frames}
      t.references :next_frame, foreign_key: { to_table: :game_frames}
      t.binary :state

      t.timestamps
    end
  end
end
