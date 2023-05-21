# frozen_string_literal: true

class ContractsController < ApplicationController
  def index
    @contracts = Contract
  end

  def import
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def process_csv
    Turbo::StreamsChannel.broadcast_append_to(
      "notifications-content",
      action: :append,
      target: "notifications-content",
      partial: "contracts/notification",
      locals: { message: "Upload in progress", id: "upload-started" }
    )

    csv_upload = params[:csv]

    blob = ActiveStorage::Blob.create_and_upload!(
      io: csv_upload.open,
      filename: csv_upload.original_filename,
      content_type: csv_upload.content_type
    )

    CreateContractsViaCsvJob.perform_async(blob.id)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
