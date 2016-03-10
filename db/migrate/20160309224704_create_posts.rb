class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :caption
      t.string :image_uid
      t.string :image_name

      t.timestamps null: false
    end
  end
end
