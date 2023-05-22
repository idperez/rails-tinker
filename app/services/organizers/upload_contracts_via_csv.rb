# frozen_string_literal: true

module Organizers
  class UploadContractsViaCsv
    extend LightService::Organizer

    def self.call(ctx)
      with(ctx).reduce(actions)
    end

    def self.actions
      [
        Actions::ProcessCsv,
        Actions::GenerateContractCollection,
        Actions::CreateOrUpdateContracts,
        Actions::NotifyUploadCompletion
      ]
    end
  end
end
