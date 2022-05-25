require 'rails_helper'

RSpec.describe Group, type: :model do
  before :all do
    User.destroy_all
    @user = create :user, :email
  end

  describe 'Validations' do
    subject { create :group, author: @user }
  
    it 'Should have a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  
    it 'Should have a name with more than 2 characters' do
      subject.name = 'CH'
      expect(subject).to_not be_valid
    end
  
    it 'Should have an author' do
      subject.author = nil
      expect(subject).to_not be_valid
    end
  
    it 'Should have an icon' do
      subject.icon = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Methods' do
  
    it 'should return the list of operations ordered by last added' do
      group = create :group, author: @user
      operations = create_list :operation, 20, author: @user
      operations.each do |operation|
        GroupOperation.create(group: group, operation: operation)
      end
      last_added = operations[operations.length - 1]

      ordered_operations = Group.last.ordered_transactions
      ordered_last_added = ordered_operations[0]

      expect(ordered_operations.length).to eq(operations.length)
      expect(ordered_last_added).to eq(last_added)
    end

  end
end
