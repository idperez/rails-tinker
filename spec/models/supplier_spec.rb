# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Supplier, type: :model do
  subject { FactoryBot.build(:supplier) }

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'validates uniqueness of `name`' do
      FactoryBot.create(:supplier)
      should validate_uniqueness_of(:name)
    end

    it 'validates uniqueness of `identifier`' do
      FactoryBot.create(:supplier)
      should validate_uniqueness_of(:identifier).case_insensitive
    end

    context 'when names are similar' do
      let!(:supplier) { FactoryBot.create(:supplier, name: 'Access IT') }

      it 'throws invalid record exception' do
        expect { FactoryBot.create(:supplier, name: 'AccessIT') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'associations' do
    it { should have_many(:contracts) }
  end

  describe '#set_identifier' do
    subject(:supplier) do
      FactoryBot.create(
        :supplier,
        name: 'a supplier'
      )
    end

    it 'sets identifier' do
      expect(supplier.identifier).to eql('asupplier')
    end
  end

  describe 'soft deletion' do
    let(:supplier) { FactoryBot.create(:supplier) }

    it 'soft deletes the contract' do
      supplier.destroy
      expect(Supplier.find_by(id: supplier.id)).to be_nil
      expect(Supplier.with_deleted.find(supplier.id)).to eq(supplier)
    end

    it 'restores a soft deleted contract' do
      supplier.destroy
      Supplier.with_deleted.find(supplier.id).recover
      expect(Supplier.find_by(id: supplier.id)).to eq(supplier)
    end
  end
end
