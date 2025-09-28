class CreateSharedGames < ActiveRecord::Migration[8.0]
  def change
    create_table :shared_games do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
