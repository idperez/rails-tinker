module Organizers
  class CreateContractsViaCsv
    extend LightService::Organizer

    def self.call(ctx)
      with(ctx).reduce(actions)
    end

    def self.actions
      [
        Actions::ProcessCsv,
        Actions::GenerateContractCollection,
        Actions::CreateContracts,
        Actions::TriggerNotification
      ]
    end
  end
end
