class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.references :post, foreign_key: true
      t.integer :rate, null: false, default: 0
      t.timestamps
    end
  end
end
