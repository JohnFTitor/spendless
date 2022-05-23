require 'rails_helper'

RSpec.describe Group, type: :model do
  
  before :all do 
    User.destroy_all
    @user = User.create(name: 'My name', email: 'test@example.com', password: '123456', confirmed_at: DateTime.now)
  end

  subject { Group.new(name: 'Group Name', icon: 'Icon url', author: @user) }

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
