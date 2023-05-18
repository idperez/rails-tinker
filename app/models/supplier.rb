# frozen_string_literal: true

class Supplier < ApplicationRecord
  acts_as_paranoid

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :identifier, presence: true, uniqueness: true

  # Associations
  has_many :contracts, dependent: :nullify

  before_validation :set_identifier

  def identifier_from_name(name)
    return if name.blank?

    name.downcase.gsub(/[[:space:]]/, '')
  end

  private

  def set_identifier
    self.identifier = identifier_from_name(name)
  end
end
