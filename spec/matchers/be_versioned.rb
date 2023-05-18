# frozen_string_literal: true

RSpec::Matchers.define :be_versioned do
  match do |actual|
    actual.class.include?(PaperTrail::Model::InstanceMethods)
  end
end
