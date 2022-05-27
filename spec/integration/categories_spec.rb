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

  describe 'Categories page' do
    before :all do
      Group.destroy_all
      groups = create_list :group, 20, author: @user
      operations = create_list :operation, 20, author: @user
      groups.each_with_index do |group, index|
        GroupOperation.create(group:, operation: operations[index])
      end
    end

    before :each do
      visit new_user_session_path
      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)
      click_button 'Log in'
      visit categories_path
    end

    it 'should have an icon for each group' do
      container = page.find('.groups')
      images = container.find_all('img')

      expect(images.length).to eq(20)
    end

    it 'should have the name of each category' do
      groups = Group.all

      groups.each do |group|
        expect(page).to have_content(group.name)
      end
    end

    it 'should have the total ammount of each category' do
      groups = Group.all

      groups.each do |group|
        expect(page).to have_content("$#{group.total_amount}")
      end
    end

    it 'should link to the transaction page of the category' do
      group_record = Group.first
      group = page.find('a', id: "Group-#{group_record.id}")

      group.click

      expect(page).to have_current_path(category_transactions_path(category_id: group_record.id))
    end

    it 'should have a new category button' do
      add_new_category = page.find_link('Add New Category')

      add_new_category.click

      expect(page).to have_current_path(new_category_path)
    end
  end

  describe 'Add new category page' do
    before :all do
      Group.destroy_all
    end

    before :each do
      visit new_user_session_path
      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)
      click_button 'Log in'
      visit new_category_path
    end

    it 'should have name and icon fields' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Icon')
    end

    it 'should show an error message if no Icon is supplied' do
      fill_in('Name', with: 'Test Category')

      click_button 'Save'

      expect(page).to have_content('Error: Please make sure to fill all fields with the proper input')
    end

    it 'should show an error message if no name is supplied' do
      fill_in('Icon', with: 'Test Category')

      click_button 'Save'

      expect(page).to have_content('Error: Please make sure to fill all fields with the proper input')
    end

    it 'should show an error message if name is too short' do
      fill_in('Name', with: 'No')
      fill_in('Icon', with: 'Test Category')

      click_button 'Save'

      expect(page).to have_content('Error: Please make sure to fill all fields with the proper input')
    end

    it 'should redirect to home page on success' do
      fill_in('Name', with: 'Name test')
      fill_in('Icon', with: 'Test Category')

      click_button 'Save'

      expect(page).to have_content('Category created successfully')
      expect(page).to have_current_path('/')
    end

    it 'should contain the new category when returned to home page' do
      fill_in('Name', with: 'Name test')
      fill_in('Icon', with: 'Test Category')

      click_button 'Save'

      expect(page).to have_content('Name test')
    end

    it 'should redirect to home page if home link is pressed' do
      home = page.find('a', id: 'Home')

      home.click

      expect(page).to have_current_path('/')
    end
  end
end
