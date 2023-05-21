module Actions
  class CreateContracts
    extend ::LightService::Action

    expects :contract_collection

    executed do |context|
      context.contract_collection.valid_contracts.each do |contract|
        contract_owner = ContractOwner.find_by(email: contract.contract_owner_email)
        supplier = Supplier.find_by(identifier: contract.supplier_identifier)

        supplier = Supplier.create!(name: contract.supplier_name) if supplier.blank?

        contract = Contract.new(
          external_contract_id: contract.external_contract_id,
          name: contract.contract_name,
          start_date: contract.start_date,
          end_date: contract.end_date,
          contract_owner: contract_owner,
          value: contract.contract_value,
          supplier: supplier
        )

        contract.save!

        contract.broadcast_append_to "contracts"
      end
    end
  end
end
