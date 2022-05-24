class AddTotalAmountToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :total_amount, :integer, default: 0
  end
end
