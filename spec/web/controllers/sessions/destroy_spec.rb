RSpec.describe Web::Controllers::Sessions::Destroy, type: :action do
  let(:action)   { described_class.new }
  let(:response) { action.call(params) }
  let(:params)   { Hash[] }
  let(:warden)   { instance_double Warden::Proxy }

  before do
    allow(action).to receive(:warden).and_return(warden)
    allow(warden).to receive(:logout)
    allow(warden).to receive(:user)
    response
  end
  
  it 'calls the `logout` method on warden' do
    expect(warden).to have_received(:logout)
  end

  it 'returns the correct response code' do
    expect(response[0]).to eq 302
  end
end
