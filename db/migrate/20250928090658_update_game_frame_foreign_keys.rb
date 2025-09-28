class UpdateGameFrameForeignKeys < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :game_frames, to_table: :game_frames, column: :prev_frame_id
    remove_foreign_key :game_frames, to_table: :game_frames, column: :next_frame_id

    add_foreign_key :game_frames, :game_frames,
                    column: :prev_frame_id,
                    on_delete: :nullify

    add_foreign_key :game_frames, :game_frames,
                    column: :next_frame_id,
                    on_delete: :nullify
  end
end
