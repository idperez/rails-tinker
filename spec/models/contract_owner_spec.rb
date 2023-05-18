# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContractOwner, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it 'validates email format' do
      owner = FactoryBot.build(:contract_owner)
      owner.email = 'owner@example.com'
      expect(owner).to be_valid

      owner.email = 'owner'
      expect(owner).to be_invalid

      owner.email = 'owner@example'
      expect(owner).to be_invalid
    end
  end

  describe 'soft deletion' do
    let(:contract_owner) { FactoryBot.create(:contract_owner) }

    it 'soft deletes the contract_owner' do
      contract_owner.destroy
      expect(ContractOwner.find_by(id: contract_owner.id)).to be_nil
      expect(ContractOwner.with_deleted.find(contract_owner.id)).to eq(contract_owner)
    end

    it 'restores a soft deleted contract_owner' do
      contract_owner.destroy
      ContractOwner.with_deleted.find(contract_owner.id).recover
      expect(ContractOwner.find_by(id: contract_owner.id)).to eq(contract_owner)
    end
  end
end
