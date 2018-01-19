class AddDefaultToColumn < ActiveRecord::Migration[5.1]
  def change
    change_column_default :restaurants, :favorites_count, 0
    add_column :restaurants, :likes_count, :integer, default: 0
  end
end
