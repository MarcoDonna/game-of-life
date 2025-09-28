class CreateShareTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :share_tokens do |t|
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :share_token

      t.timestamps
    end
    add_index :share_tokens, :share_token, unique: true
  end
end
