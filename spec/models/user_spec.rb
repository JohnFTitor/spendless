require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject { build :user, :email }
  
    it 'should have name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  
    it 'should have a name longer than two characters' do
      subject.name = 'N'
      expect(subject).to_not be_valid
    end
  
    it 'should have an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  
    it 'should have a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Methods' do
    before :all do 
      User.destroy_all
      @user = create :user, :email
      create_list :group, 20, author: @user
    end

    it 'should return the list of categories for the user' do
      groups = @user.ordered_groups

      expect(groups.length).to eq(20)
    end
  end
end
