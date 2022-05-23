class Operation < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_operations
  has_many :groups, through: :group_operations

  validates :name, length: { minimum: 3 }
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 } 

end
