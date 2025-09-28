class CreateGameUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :game_users do |t|
      t.timestamps
    end
  end
end
