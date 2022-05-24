require 'rails_helper'

RSpec.describe 'Categories integration', type: :feature do
  
  before :all do 
    User.destroy_all
    @user = create :user, email: 'test@example.com'
  end
  
  describe 'Splash screen page' do 
    before :each do
      visit welcome_path
    end

    it 'should only have log in and sign up buttons' do
      expect(page).to have_link('Log in')
      expect(page).to have_link('Sign up')
      expect(page).to_not have_link('Categories')
    end

    it 'should redirect to log in if pressed' do 
      login = page.find_link('Log in')

      login.click

      expect(page).to have_current_path(new_user_session_path)
    end

    it 'should redirect to sign up if pressed' do 
      sign_up = page.find_link('Sign up')

      sign_up.click

      expect(page).to have_current_path(new_user_registration_path)
    end

    it 'should have the name of the application' do 
      expect(page).to have_content('Spendless')
    end

    it 'should show a link to categories if authenticaded' do
      visit new_user_session_path
      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)
      click_button 'Log in'
      visit welcome_path

      categories = page.find_link('Categories')
      categories.click

      expect(page).to have_current_path(categories_path)
    end
  end
end
