module Actions
  class ProcessCsv
    extend ::LightService::Action

    expects :blob_id
    promises :csv

    executed do |context|
      csv_file = ActiveStorage::Blob.find(context.blob_id)

      csv = CSV.parse(csv_file.download, headers: true)

      if (Contracts::Csv::Collection::CSV_ROWS - csv.headers).present?
        context.fail_and_return!("CSV headers are invalid, must contain #{Contracts::Csv::Collection::CSV_ROWS}")
      end

      context.csv = csv
    end
  end
end
