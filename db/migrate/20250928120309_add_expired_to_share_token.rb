class AddExpiredToShareToken < ActiveRecord::Migration[8.0]
  def change
    add_column :share_tokens, :expired, :boolean
  end
end
