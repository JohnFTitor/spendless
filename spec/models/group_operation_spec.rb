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

  it 'should increment total amount of group if created' do 
    user = create :user, :email
    group = create :group, author: user
    operation1 = create :operation, author: user
    operation2 = create :operation, author: user
    total = operation1.amount + operation2.amount

    GroupOperation.create( group: group, operation: operation1)
    GroupOperation.create( group: group, operation: operation2)

    expect(group.total_amount).to eq(total)
  end

  it 'should decrement total amount of group if deleted' do 
    Group.destroy_all
    user = create :user, :email
    group = create :group, author: user
    operation1 = create :operation, author: user
    operation2 = create :operation, author: user
    total = operation1.amount

    GroupOperation.create( group: group, operation: operation1)
    destroyable = GroupOperation.create( group: group, operation: operation2)

    GroupOperation.destroy(destroyable.id)

    group = Group.first

    expect(group.total_amount).to eq(total)
  end
end
