# frozen_string_literal: true

RSpec.describe Web.routes do
  describe 'DELETE session' do
    let(:generated_path) { described_class.path(:logout) }
    let(:env) { Rack::MockRequest.env_for('/sessions', method: 'DELETE') }
    let(:route) { described_class.recognize(env) }

    it 'has a generated path' do
      expect(generated_path).to eq('/sessions')
    end

    it 'is a recognisable route' do
      expect(route).to be_routable
      expect(route.path).to eq('/sessions')
      expect(route.verb).to eq('DELETE')
    end
  end
end
