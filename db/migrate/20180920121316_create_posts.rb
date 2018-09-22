class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null:false
      t.text :body, null: false
      t.string :ip, null:false
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end

    add_index :posts, :ip
  end
end
