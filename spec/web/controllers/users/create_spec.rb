RSpec.describe Web::Controllers::Users::Create, type: :action do
  let(:action)                { described_class.new(new_params) }
  let(:response)              { action.call(params.dup) }
  let(:interactor)            { Interactors::Users::Create.new }
  let(:user)                  { build(:user) }
  let(:email)                 { Faker::Internet.email }
  let(:password)              { 'Password123!' }
  let(:password_confirmation) { password }

  let(:new_params)            { Hash[interactor: interactor] }
  let(:service_params)        { Hash[params: params] }

  let(:params) do
    {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }
  end

  before do
    allow(interactor).to receive(:call).and_return([user, 'Success message'])
    response
  end

  context 'with valid params' do
    it 'calls the interactor with correct params' do
      expect(interactor).to have_received(:call).with(service_params)
    end

    it 'returns the correct response code' do
      expect(response[0]).to eq 302
    end
  end

  context 'with invalid params' do
    shared_examples 'invalid params examples' do
      it 'does not call the interactor' do
        expect(interactor).not_to have_received(:call)
      end
  
      it 'returns the correct response code' do
        expect(response[0]).to eq 200
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
