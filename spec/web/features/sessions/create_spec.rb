# frozen_string_literal: true

require 'features_helper'

describe 'User login', type: :feature, js: true do
  let(:email)              { 'ad@min.com' }
  let(:password)           { 'Password123!' }
  let(:submitted_password) { password }

  def fill_in_login_form
    fill_in 'session[email]', with: email
    fill_in 'session[password]', with: submitted_password
    click_button 'Log in'
  end

  before do
    create(:user, email: email, password: password)
    visit Web.routes.new_session_path
  end

  describe 'success' do
    before do
      fill_in_login_form
    end

    it 'displays a success message' do
      expect(page).to have_content('Successfully logged in')
    end

    it 'redirects to the correct page' do
      expect(page).to have_current_path(Web.routes.root_path)
    end
  end

  describe 'failure' do
    context 'with the wrong password' do
      let(:submitted_password) { 'Wrong-password123!' }

      before do
        fill_in_login_form
      end

      it 'displays an error message' do
        expect(page).to have_content('Login details were incorrect')
      end

      it 'retains user input' do
        expect(page).to have_field('session[email]', with: email)
      end
    end
  end
end
