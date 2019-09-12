class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :borrows
  has_many :books, through: :borrows

  def borrowed_books
  	return self.borrows.order('created_at DESC')
  end
end
