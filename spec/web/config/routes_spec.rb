# frozen_string_literal: true

RSpec.describe Web.routes do
  describe 'DELETE session' do
    it 'has a generated path' do
      generated_path = described_class.path(:logout)

      expect(generated_path).to eq('/sessions')
    end

    it 'is a recognisable route' do
      env = Rack::MockRequest.env_for('/sessions', method: 'DELETE')
      route = described_class.recognize(env)

      expect(route).to be_routable
      expect(route.path).to eq('/sessions')
      expect(route.verb).to eq('DELETE')
    end
  end
end
