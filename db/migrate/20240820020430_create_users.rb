class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.integer :age, default: 0
      t.integer :gender, default: 0
      t.text :profile
      t.string :avatar
      t.timestamps

      t.index :name
    end
  end
end
