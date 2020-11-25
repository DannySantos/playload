# frozen_string_literal: true

RSpec.describe Parser::Helpers::CreateTechSpecs do
  let(:result)       { described_class.new(new_params).call(call_params) }
  let(:data)         { File.read('spec/support/sample_data.json') }
  let(:game_details) { JSON.parse(data)['GameInfo'][0] }

  let(:release)         { build(:release) }
  let(:tech_spec_group) { build(:tech_spec_group) }
  let(:tech_spec)       { build(:tech_spec) }

  let(:find_or_create_tech_spec_group)   { instance_double Parser::Helpers::FindOrCreateTechSpecGroup }
  let(:find_or_create_tech_spec)         { instance_double Parser::Helpers::FindOrCreateTechSpec }
  let(:find_or_create_release_tech_spec) { instance_double Parser::Helpers::FindOrCreateReleaseTechSpec }

  let(:call_params) { Hash[game_details: game_details, release: release] }

  let(:find_or_create_tech_spec_params) do
    lambda do |tech_spec_detail|
      {
        tech_spec_detail: tech_spec_detail,
        tech_spec_group: tech_spec_group
      }
    end
  end

  let(:new_params) do
    {
      find_or_create_tech_spec_group: find_or_create_tech_spec_group,
      find_or_create_tech_spec: find_or_create_tech_spec,
      find_or_create_release_tech_spec: find_or_create_release_tech_spec
    }
  end

  describe '#call' do
    before do
      allow(find_or_create_tech_spec_group).to receive(:call).and_return(tech_spec_group)
      allow(find_or_create_tech_spec).to receive(:call).and_return(tech_spec)
      allow(find_or_create_release_tech_spec).to receive(:call)
      result
    end

    it 'finds or creates all of the tech_spec groups' do
      expect(find_or_create_tech_spec_group).to have_received(:call).exactly(3).times
    end

    it 'finds or creates the tech_spec groups' do
      game_details['technical_specifications'].each do |tech_spec_group_detail|
        expect(find_or_create_tech_spec_group).to have_received(:call)
          .with(tech_spec_group_detail: tech_spec_group_detail)
      end
    end

    it 'finds or creates all of the tech_specs' do
      expect(find_or_create_tech_spec).to have_received(:call).exactly(3).times
    end

    it 'finds or creates the tech_specs' do
      game_details['technical_specifications'].each do |tech_spec_group_detail|
        tech_spec_group_detail['tech_specs'].each do |tech_spec|
          expect(find_or_create_tech_spec).to have_received(:call).with(find_or_create_tech_spec_params[tech_spec])
        end
      end
    end

    it 'finds or creates all of the release_tech_specs' do
      expect(find_or_create_release_tech_spec).to have_received(:call).exactly(3).times
    end
  end
end
