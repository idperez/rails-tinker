class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false, unique: true
      t.string :identifier, null: false, unique: true, index: true

      t.timestamps
    end
  end
end
