class AddDeletedAtToContractOwners < ActiveRecord::Migration[7.0]
  def change
    add_column :contract_owners, :deleted_at, :datetime
  end
end
