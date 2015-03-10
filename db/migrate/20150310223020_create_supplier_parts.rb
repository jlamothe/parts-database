class CreateSupplierParts < ActiveRecord::Migration
  def change
    create_table :supplier_parts do |t|
      t.belongs_to :part, null: false, index: true
      t.belongs_to :supplier, null: false, index: true
      t.string :part_number, index: true

      t.timestamps null: false
    end
  end
end
