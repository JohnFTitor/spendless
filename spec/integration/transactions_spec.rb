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
        GroupOperation.create(group: group, operation: operation)
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
      expect(page).to have_content("Total amount: #{@group.total_amount}")
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
end
