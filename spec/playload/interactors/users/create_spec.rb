# frozen_string_literal: true

require 'spec_helper'

describe Interactors::Users::Create do
  let(:result)                   { described_class.new(new_params).call(params: params) }
  let(:user_repo)                { instance_double UserRepository }
  let(:user)                     { instance_double User }
  let(:generate_hashed_password) { instance_double Interactors::Helpers::GenerateHashedPassword }

  let(:email)                    { Faker::Internet.email }
  let(:password)                 { 'Password123!' }
  let(:password_confirmation)    { password }

  let(:new_params) do
    {
      user_repo: user_repo,
      generate_hashed_password: generate_hashed_password
    }
  end

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
    allow(user_repo).to receive(:create).and_return(user)
    allow(generate_hashed_password).to receive(:call).and_return({})
    allow(user_repo).to receive(:find_by).and_return(nil)
  end

  describe 'success' do
    before do
      result
    end

    it 'returns a user' do
      expect(result[0]).to eq(user)
    end

    it 'returns a success message' do
      expect(result[1]).to eq('Successfully registered')
    end

    it 'queries the user repository' do
      expect(user_repo).to have_received(:find_by).with(email: email)
    end

    it 'generates a hashed password' do
      expect(generate_hashed_password).to have_received(:call).with(password: password)
    end

    it 'creates the user in the database' do
      expect(user_repo).to have_received(:create).with(params[:user])
    end
  end

  describe 'failure' do
    shared_examples 'failure expectations' do
      it 'returns a failure message' do
        expect(result[1]).to eq(failure_message)
      end

      it 'does not generate a hashed password' do
        expect(generate_hashed_password).not_to have_received(:call)
      end

      it 'does not create the user in the database' do
        expect(user_repo).not_to have_received(:create)
      end
    end

    context 'when the user already exists' do
      let(:failure_message) { 'Email address is already registered' }

      before do
        allow(user_repo).to receive(:find_by).and_return(user)
        result
      end

      include_examples 'failure expectations'

      it 'queries the user repository' do
        expect(user_repo).to have_received(:find_by).with(email: email)
      end
    end

    context 'when the password and confirmation do not match' do
      let(:failure_message)       { 'Password and confirmation do not match' }
      let(:password_confirmation) { 'not-the-same' }

      before do
        result
      end

      include_examples 'failure expectations'

      it 'does not query the user repository' do
        expect(user_repo).not_to have_received(:find_by)
      end
    end
  end
end
