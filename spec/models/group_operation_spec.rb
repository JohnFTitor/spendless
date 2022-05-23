require 'rails_helper'

RSpec.describe GroupOperation, type: :model do
  
  before :all do 
    User.destroy_all
    user = create :user, :email
    @group = create :group, author: user
    @operation = create :operation, author: user 
  end

  subject { GroupOperation.new( group: @group, operation: @operation ) }

  it 'Should have a group' do 
    subject.group = nil
    expect(subject).to_not be_valid 
  end

  it 'Should have an operation' do 
    subject.operation = nil
    expect(subject).to_not be_valid
  end
end
