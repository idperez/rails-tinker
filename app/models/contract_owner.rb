# frozen_string_literal: true

class ContractOwner < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: { mode: :strict }

  # Associations
  has_many :contracts, dependent: :nullify
end
