class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :operations, foreign_key: 'author_id', dependent: :destroy 
  has_many :groups, foreign_key: 'author_id', dependent: :destroy 

  validates :name, presence: true, length: { minimum: 2 }
  validates :password, presence: true
end
