module Contracts
  module Csv
    class Collection
      attr_accessor :valid_contracts, :invalid_contracts, :duplicate_contracts

      CSV_ROWS = [
        'Contract Owner',
        'External Contract ID',
        'Contract Name',
        'Start Date',
        'End Date',
        'Contract Value',
        'Supplier'
      ].freeze

      def initialize
        @valid_contracts = []
        @duplicate_contracts = []
        @invalid_contracts = []
      end

      def add_valid_contract(row)
        valid_row = ValidRow.new(row)

        if valid_row.duplicate_contract
          duplicate_contracts.push(valid_row)
        else
          valid_contracts.push(valid_row)
        end
      end

      def add_invalid_contract(row_number, error_message)
        invalid_contracts.push(InValidRow.new(row_number, error_message))
      end
    end
  end
end

module Contracts
  module Csv
    class ValidRow
      attr_accessor :contract_owner_email,
                    :external_contract_id,
                    :contract_name,
                    :start_date,
                    :end_date,
                    :contract_value,
                    :supplier_identifier,
                    :supplier_name,
                    :duplicate_contract

      def initialize(row)
        @contract_owner_email = row['Contract Owner']
        @external_contract_id = row['External Contract ID']
        @contract_name = row['Contract Name']
        @start_date = DateTime.strptime(row['Start Date'], '%m/%d/%Y')
        @end_date = DateTime.strptime(row['End Date'], '%m/%d/%Y')
        @contract_value = Monetize.parse(row['Contract Value'])
        @supplier_name = row['Supplier']
        @supplier_identifier = Supplier.identifier_from_name(row['Supplier'])
        @duplicate_contract = Contract.find_by(external_contract_id: row['External Contract ID']).present?
      end
    end
  end
end

module Contracts
  module Csv
    class InValidRow
      attr_accessor :row_number, :message

      def initialize(row_number, message)
        @row_number = row_number
        @message = message
      end
    end
  end
end
