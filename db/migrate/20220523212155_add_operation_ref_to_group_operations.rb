class AddOperationRefToGroupOperations < ActiveRecord::Migration[7.0]
  def change
    add_reference :group_operations, :operation, null: false, foreign_key: true
  end
end
