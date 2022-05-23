require 'rails_helper'

RSpec.describe Operation, type: :model do
  
  before :all do 
    User.destroy_all
    @user = User.create(name: 'My name', email: 'test@example.com', password: '123456', confirmed_at: DateTime.now)
  end

  subject { Operation.new(name: 'My transaction', amount: 50, author: @user)}

  it 'Should have a name' do 
    subject.name = nil
    expect(subject).to_not be_valid 
  end

  it 'Should have a name with more than 2 characters' do
    subject.name = 'CH'
    expect(subject).to_not be_valid
  end

  it 'Should have an amount' do 
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it 'Should have an amount bigger than zero' do 
    subject.amount = 0
    expect(subject).to_not be_valid
  end

  it 'Should have an amount with an integer value' do 
    subject.amount = 'test'
    expect(subject).not_to be_valid
  end

  it 'should have an author' do 
    subject.author = nil
    expect(subject).to_not be_valid
  end
end
