class AddDeletedAtToContracts < ActiveRecord::Migration[7.0]
  def change
    add_column :contracts, :deleted_at, :datetime
  end
end
