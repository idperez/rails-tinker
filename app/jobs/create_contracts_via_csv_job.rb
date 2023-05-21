class CreateContractsViaCsvJob
  include Sidekiq::Job

  sidekiq_options queue: 'process_csv'

  def perform(blob_id)
    service_result = Organizers::CreateContractsViaCsv.call({
       blob_id: blob_id
    })

    if service_result.failure?
      failure_message = "Upload failed: #{service_result.message}"

      Turbo::StreamsChannel.broadcast_append_to(
        "notifications-content",
        action: :append,
        target: "notifications-content",
        partial: "contracts/notification",
        locals: { message: failure_message, id: "upload-failure" }
      )
    end
  end
end
