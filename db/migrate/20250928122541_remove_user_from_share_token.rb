class RemoveUserFromShareToken < ActiveRecord::Migration[8.0]
  def change
    remove_reference :share_tokens, :user, null: false, foreign_key: true
  end
end
