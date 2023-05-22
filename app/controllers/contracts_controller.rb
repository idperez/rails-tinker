# frozen_string_literal: true

class ContractsController < ApplicationController
  def index
    @contracts = Contract
  end

  def supplier
    if params[:id].present?
      @supplier = Supplier.includes(contracts: :contract_owner).find_by(id: params[:id])

      if @supplier.nil?
        redirect_to contracts_path, alert: "Supplier not found with id #{params[:id]}"
      end
    else
      redirect_to contracts_path, alert: "Must have a valid Supplier"
    end
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
      locals: { message: "Your CSV upload is in progress", id: "upload-started" }
    )

    csv_upload = params[:csv]

    blob = ActiveStorage::Blob.create_and_upload!(
      io: csv_upload.open,
      filename: csv_upload.original_filename,
      content_type: csv_upload.content_type
    )

    UploadContractsViaCsvJob.perform_async(blob.id)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
