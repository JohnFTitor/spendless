require 'rails_helper'

RSpec.describe Group, type: :model do
  
  before :all do 
    User.destroy_all
    @user = create :user, :email
  end

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
