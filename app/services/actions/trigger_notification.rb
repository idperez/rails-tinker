module Actions
  class TriggerNotification
    extend ::LightService::Action

    expects :contract_collection

    executed do |context|
      Turbo::StreamsChannel.broadcast_append_to(
        "notifications-content",
        action: :append,
        target: "notifications-content",
        partial: "contracts/upload_completion_notification",
        locals: { contract_collection: context.contract_collection }
      )
    end
  end
end
