# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateTechSpecGroup do
  let(:result)          { described_class.new(new_params).call(call_params) }
  let(:tech_spec_group) { build(:tech_spec_group) }

  let(:tech_spec_group_repo) { instance_double TechSpecGroupRepository }

  let(:new_params)  { Hash[tech_spec_group_repo: tech_spec_group_repo] }
  let(:call_params) { Hash[tech_spec_group_detail: tech_spec_group_detail] }

  let(:tech_spec_group_detail) do
    JSON.parse('
      {
        "id": "24",
        "name": "Single Player",
        "priority": 0,
        "tech_specs": [
          {
            "id": "589",
            "name": "Single Player",
            "value": "Y",
            "priority": 1
          }
        ]
      }
    ')
  end

  let(:create_params) do
    {
      id: 24,
      name: 'Single Player',
      priority: 0
    }
  end

  describe '#call' do
    before do
      allow(tech_spec_group_repo).to receive(:find).and_return(nil)
      allow(tech_spec_group_repo).to receive(:create).and_return(tech_spec_group)
      result
    end

    context 'when the tech_spec_group does not yet exist' do
      it 'tries to find the tech_spec_group in the database' do
        expect(tech_spec_group_repo).to have_received(:find).with(24)
      end

      it 'creates only one tech_spec_group' do
        expect(tech_spec_group_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the tech_spec_group' do
        expect(tech_spec_group_repo).to have_received(:create).with(create_params)
      end
    end
  end
end
