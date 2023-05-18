# frozen_string_literal: true

FactoryBot.define do
  factory :contract do
    name { Faker::Company.name }
    start_date { 6.months.ago }
    end_date { 6.months.from_now }
    value_cents { Faker::Number.between(from: 0, to: 100_000) }
    external_contract_id { SecureRandom.uuid }
    association :contract_owner
    association :supplier
  end
end
