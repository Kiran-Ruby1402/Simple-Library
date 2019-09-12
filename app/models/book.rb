class Book < ApplicationRecord
	belongs_to :category	
	has_many :borrows																																																																																																																																																											
	has_many :users, through: :borrows

	validates_presence_of :title
	validates_uniqueness_of :title
	validates :quantity, numericality: { only_integer: true , greater_than_or_equal_to: 0}

	scope :serach_by_name, -> (title) {where('title LIKE ?', "%#{title}%")}
	scope :get_by_category, -> (id) {where(category_id: id)}
	scope :get_by_id, -> (id) {find(id)}
end
