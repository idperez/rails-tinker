module Actions
  class CreateOrUpdateContracts
    extend ::LightService::Action

    expects :contract_collection

    executed do |context|
      context.contract_collection.valid_contracts.each do |contract|
        contract_owner = ContractOwner.find_by(email: contract.contract_owner_email)
        supplier = Supplier.find_by(identifier: contract.supplier_identifier)

        supplier = Supplier.create!(name: contract.supplier_name) if supplier.blank?

        if contract.duplicate_contract
          duplicate_contract = Contract.find_by(external_contract_id: contract.external_contract_id)

          duplicate_contract.update(
            name: contract.contract_name,
            start_date: contract.start_date,
            end_date: contract.end_date,
            contract_owner: contract_owner,
            value: contract.contract_value,
            supplier: supplier
          )

          duplicate_contract.broadcast_replace_to "contracts"
        else
          new_contract = Contract.new(
            external_contract_id: contract.external_contract_id,
            name: contract.contract_name,
            start_date: contract.start_date,
            end_date: contract.end_date,
            contract_owner: contract_owner,
            value: contract.contract_value,
            supplier: supplier
          )

          new_contract.save!

          new_contract.broadcast_append_to "contracts"
        end
      end
    end
  end
end
