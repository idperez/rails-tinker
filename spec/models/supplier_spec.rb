require "rails_helper"

RSpec.describe Supplier, type: :model do
  subject { FactoryBot.build(:supplier) }

  describe "validations" do
    it { should validate_presence_of(:name) }

    it "validates uniqueness of `name`" do
      FactoryBot.create(:supplier)
      should validate_uniqueness_of(:name)
    end

    it "validates uniqueness of `identifier`" do
      FactoryBot.create(:supplier)
      should validate_uniqueness_of(:identifier).case_insensitive
    end

    context "when names are similar" do
      let!(:supplier) { FactoryBot.create(:supplier, name: "Access IT") }

      it 'throws invalid record exception' do
        expect { FactoryBot.create(:supplier, name: "AccessIT") }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "associations" do
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
end
