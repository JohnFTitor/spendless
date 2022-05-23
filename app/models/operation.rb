class Operation < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :name, length: { minimum: 3 }
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 } 

end
