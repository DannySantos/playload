RSpec.describe Web::Controllers::Sessions::Create, type: :action do
  let(:action)                { described_class.new }
  let(:response)              { action.call(params.dup) }
  let(:user)                  { build(:user, password: password) } 
  let(:email)                 { user.email } 
  let(:password)              { 'Password123!' } 
  let(:warden)                { instance_double Warden::Proxy }
  
  let(:params) do
    {
      session: {
        email: email,
        password: password,
      }
    }
  end
  
  before do
    allow(action).to receive(:warden).and_return(warden)
    allow(warden).to receive(:authenticate!).and_return(user)
    allow(warden).to receive(:user)
    response
  end
  
  context 'with valid params' do
    it 'calls the `authenticate!` method on warden' do
      expect(warden).to have_received(:authenticate!).with(:password)
    end

    it 'returns the correct response code' do
      expect(response[0]).to eq 302
    end
  end

  context 'with invalid params' do
    shared_examples 'invalid params examples' do
      it 'does not call the `authenticate!` method on warden' do
        expect(warden).not_to have_received(:authenticate!)
      end

      it 'returns the correct response code' do
        expect(response[0]).to eq 302
      end
    end

    context 'with an invalid email address' do
      let(:email) { 'not_an_email' }

      include_examples 'invalid params examples'

      it 'returns an error message' do
        expect(action.params.error_messages).to include('Email is invalid')
      end
    end

    context 'with an unsafe email address' do
      let(:email) { '= SQL Injection' }

      include_examples 'invalid params examples'

      it 'returns an error message' do
        expect(action.params.error_messages).to include('Email can not start with the following: [ + | = | - | @ ]')
      end
    end
  end
end
