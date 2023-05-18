# frozen_string_literal: true

class Contract < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  # Validations
  validates :external_contract_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
  validates :value_cents, presence: true, numericality: { greater_than: 0 }

  # Associations
  belongs_to :contract_owner
  belongs_to :supplier, optional: false

  monetize :value_cents
end
