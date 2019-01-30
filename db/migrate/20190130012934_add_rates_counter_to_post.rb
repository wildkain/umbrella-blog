class AddRatesCounterToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :rates_counter, :integer, default: 0
    add_index :posts, :rating
    add_index :posts, :rates_counter
  end
end
