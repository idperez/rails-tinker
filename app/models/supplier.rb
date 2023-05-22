class Supplier < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :identifier, presence: true, uniqueness: true

  # Associations
  has_many :contracts, dependent: :nullify

  before_validation :set_identifier

  def self.identifier_from_name(name)
    return if name.blank?

    name.downcase.gsub(/[[:space:]]/, '')
  end

  def average_contract_value
    sum = contracts.pluck(:value_cents).reduce(0, :+)
    average_value = sum / contracts.count

    Money.from_cents(average_value)
  end

  private

  def set_identifier
    self.identifier = Supplier.identifier_from_name(name)
  end
end
