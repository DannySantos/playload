# frozen_string_literal: true

require 'features_helper'

describe 'Create user', type: :feature, js: true do
  let(:email)                 { 'ad@min.com' }
  let(:password)              { 'Password123!' }
  let(:password_confirmation) { password }
  let(:user_repo)             { UserRepository.new }

  def fill_in_registration_form
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password_confirmation
    click_button 'Register'
  end

  describe 'success' do
    before do
      visit Web.routes.new_user_path
      fill_in_registration_form
    end

    it 'creates a new user' do
      user = user_repo.find_by(email: email)
      expect(user).not_to be_nil
    end

    it 'displays a success message' do
      expect(page).to have_content('Successfully registered')
    end

    it 'redirects to the correct page' do
      expect(page).to have_current_path(Web.routes.root_path)
    end
  end

  describe 'failure' do
    shared_examples 'failure expectations' do
      before do
        visit Web.routes.new_user_path
        fill_in_registration_form
      end

      it 'displays an error message' do
        expect(page).to have_content(error_message)
      end

      it 'retains user input' do
        expect(page).to have_field('user[email]', with: email)
      end
    end

    context 'when the password does not match the password confirmation' do
      let(:password_confirmation) { password + '?' }
      let(:error_message)         { 'Password and confirmation do not match' }

      before do
        visit Web.routes.new_user_path
        fill_in_registration_form
      end

      include_examples 'failure expectations'
    end

    context 'when the email is already in use' do
      let(:error_message) { 'Email address is already registered' }

      before do
        create(:user, email: email)
        visit Web.routes.new_user_path
        fill_in_registration_form
      end

      include_examples 'failure expectations'
    end

    context 'with an invalid password' do
      let(:password) { 'invalid-password' }

      let(:error_message) do
        'Password must contain at least one: uppercase letter / lowercase letter / number / special character'
      end

      before do
        visit Web.routes.new_user_path
        fill_in_registration_form
      end

      include_examples 'failure expectations'
    end
  end
end
