class AddDeletedAtToSuppliers < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :deleted_at, :datetime
  end
end
