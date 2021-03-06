require 'rails_helper'

RSpec.describe 'Transactions integration', type: :feature do
  before :all do
    User.destroy_all
    @user = create :user, email: 'test@example.com'
  end

  describe 'Transactions Page' do
    before :all do
      Group.destroy_all
      group = create :group, author: @user
      @operations = create_list :operation, 20, author: @user
      @operations.each do |operation|
        GroupOperation.create(group:, operation:)
      end
      @group = Group.last
    end

    before :each do
      visit new_user_session_path
      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)
      click_button 'Log in'
      visit category_transactions_path(category_id: @group.id)
    end

    it 'should redirect to home page if home link is pressed' do
      home = page.find('a', id: 'Home')

      home.click

      expect(page).to have_current_path('/')
    end

    it 'should show the total amount of the transactions for that category' do
      expect(page).to have_content("Total amount: $#{@group.total_amount}")
    end

    it 'should have all the operations for the specified category' do
      transactions = page.find_all('.transaction')

      expect(transactions.length).to eq(20)
    end

    it 'should have a button to create a new transaction' do
      expect(page).to have_content('Add a new transaction')
    end

    it 'should redirect to new transaction if button is pressed' do
      click_link 'Add a new transaction'

      expect(page).to have_current_path(new_category_transaction_path(category_id: @group.id))
    end

    it 'should have the name and amount of each operation' do
      @operations.each do |operation|
        expect(page).to have_content(operation.name)
        expect(page).to have_content(operation.amount)
      end
    end
  end

  describe 'Add new transaction page' do
    before :all do
      Group.destroy_all
      @group = create :group, author: @user
    end

    before :each do
      visit new_user_session_path
      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)
      click_button 'Log in'
      visit new_category_transaction_path(category_id: @group.id)
    end

    it 'should have name, amount and categories fields' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Amount')
      expect(page).to have_field('Categories')
    end

    it 'should show an error message if no Name is supplied' do
      fill_in('Amount', with: 50)

      click_button 'Save'

      expect(page).to have_content('Error: Please make sure to fill all fields with the proper input')
    end

    it 'should show an error message if no Amount is supplied' do
      fill_in('Name', with: 'Test transaction')

      click_button 'Save'

      expect(page).to have_content('Error: Please make sure to fill all fields with the proper input')
    end

    it 'should show an error message if name is too short' do
      fill_in('Name', with: 'No')
      fill_in('Amount', with: 50)

      click_button 'Save'

      expect(page).to have_content('Error: Please make sure to fill all fields with the proper input')
    end

    it 'should show an error message if amount is less or equal to zero' do
      fill_in('Name', with: 'Test transaction')
      fill_in('Amount', with: 0)

      click_button 'Save'

      expect(page).to have_content('Error: Please make sure to fill all fields with the proper input')
    end

    it 'should redirect to the first category page on success' do
      fill_in('Name', with: 'Name test')
      fill_in('Amount', with: 50)

      click_button 'Save'

      expect(page).to have_content('Transaction created successfully')
      expect(page).to have_current_path(category_transactions_path(category_id: @group.id))
    end

    it 'should contain the new transaction when returned to category page' do
      fill_in('Name', with: 'Name test')
      fill_in('Amount', with: 50)

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
