class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    # user_idとpost_idの組み合わせが一意になるように設定(複合キー)
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
