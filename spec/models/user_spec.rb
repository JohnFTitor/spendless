require 'rails_helper'

RSpec.describe User, type: :model do
  
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
