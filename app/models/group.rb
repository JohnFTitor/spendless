class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_operations, dependent: :destroy
  has_many :operations, through: :group_operations

  validates :name, presence: true, length: { minimum: 3 }
  validates :icon, presence: true

  def ordered_transactions
    operations.order(created_at: :desc)
  end
end
