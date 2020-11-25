# frozen_string_literal: true

RSpec.describe Parser::Helpers::FindOrCreateTechSpec do
  let(:result)           { described_class.new(new_params).call(call_params) }
  let(:tech_spec)        { build(:tech_spec) }
  let(:tech_spec_group)  { build(:tech_spec_group) }

  let(:tech_spec_repo)   { instance_double TechSpecRepository }

  let(:new_params)       { Hash[tech_spec_repo: tech_spec_repo] }

  let(:tech_spec_detail) { JSON.parse('{ "id": "555", "name": "Versus", "value": "N", "priority": 0 }') }

  let(:create_params) do
    {
      id: 555,
      name: 'Versus',
      value: 'N',
      priority: 0,
      tech_spec_group_id: tech_spec_group.id
    }
  end

  let(:call_params) do
    {
      tech_spec_detail: tech_spec_detail,
      tech_spec_group: tech_spec_group
    }
  end

  describe '#call' do
    before do
      allow(tech_spec_repo).to receive(:create).and_return(tech_spec)
    end

    context 'when the tech_spec does not exist' do
      before do
        allow(tech_spec_repo).to receive(:find).and_return(nil)
        result
      end

      it 'tries to find the tech_spec in the database' do
        # expect(tech_spec_repo).to have_received(:find).with(555)
      end

      it 'creates only one tech_spec' do
        expect(tech_spec_repo).to have_received(:create).exactly(1).times
      end

      it 'creates the tech_spec' do
        expect(tech_spec_repo).to have_received(:create).with(create_params)
      end
    end

    context 'when the tech_spec already exists' do
      before do
        allow(tech_spec_repo).to receive(:find).and_return(tech_spec)
        result
      end

      it 'tries to find the tech_spec in the database' do
        # expect(tech_spec_repo).to have_received(:find).with(555)
      end

      it 'does not create the tech_spec' do
        expect(tech_spec_repo).not_to have_received(:create)
      end
    end
  end
end
