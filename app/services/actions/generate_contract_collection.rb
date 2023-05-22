module Actions
  class GenerateContractCollection
    extend ::LightService::Action

    expects :csv
    promises :contract_collection

    executed do |context|
      contract_collection = Contracts::Csv::Collection.new

      context.csv.by_row.each.with_index do |row, row_number|
        error_message = ""
        missing_fields = []
        input_errors = []

        missing_fields.push("Supplier") if row["Supplier"].blank?
        missing_fields.push("Contract Value") if row["Contract Value"].blank?
        missing_fields.push("Start Date") if row["Start Date"].blank?
        missing_fields.push("End Date") if row["End Date"].blank?
        missing_fields.push("Contract Name") if row["Contract Name"].blank?
        missing_fields.push("External Contract ID") if row["External Contract ID"].blank?

        input_errors.push("Contract Value must be greater than 0") if Monetize.parse(row["Contract Value"]).cents.abs.zero?
        input_errors.push("Start Date must be a date format") if (DateTime.strptime(row["Start Date"], '%m/%d/%Y') rescue nil).blank?
        input_errors.push("End Date must be a date format") if (DateTime.strptime(row["End Date"], '%m/%d/%Y') rescue nil).blank?

        if input_errors.blank? && DateTime.strptime(row["Start Date"], '%m/%d/%Y') >= DateTime.strptime(row["End Date"], '%m/%d/%Y')
          input_errors.push("Start Date must be before End Date")
        end

        if missing_fields.present?
          error_message.concat("Missing Fields: #{missing_fields.join(", ")}\n")
        end

        if input_errors.present?
          error_message.concat("Input Errors: #{input_errors.join(", ")}\n")
        end

        if error_message.present?
          contract_collection.add_invalid_contract(row_number + 1, error_message)
        else
          contract_collection.add_valid_contract(row)
        end
      end

      context.contract_collection = contract_collection
    end
  end
end
