class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name, null: false, unique: true
      t.string :description, null: false

      t.timestamps null: false
    end
    add_index :parts, :name
  end
end
