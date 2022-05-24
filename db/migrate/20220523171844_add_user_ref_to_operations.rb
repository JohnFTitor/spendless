class AddUserRefToOperations < ActiveRecord::Migration[7.0]
  def change
    add_column :operations, :author_id, :bigint
    add_index :operations, :author_id
    add_foreign_key :operations, :users, column: :author_id
  end
end
