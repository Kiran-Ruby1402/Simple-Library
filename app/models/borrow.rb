class Borrow < ApplicationRecord
	enum status: [:issued, :returned]
	belongs_to :user
	belongs_to :book
	
	before_create :check_for_quantity, :validate_due_date, :check_for_exist
	after_create :update_borrowed_book_status, :update_book_quantity
	scope :check_borrowed_books, ->(id, status){where("category_id = ? AND status = ?", id, status)}
	scope :get_borrowed_book, -> (id) { find(id) }

	private
	def update_borrowed_book_status
		self.due_date = self.created_at.to_date + 10.days
		self.status = :issued
		self.save
	end

	def update_book_quantity
		book = Book.find(self.book_id)
		self.category_id = book.category_id	
		book.quantity -= 1
		self.save
		book.save
	end

	def check_for_exist
		unless self.book_id.blank?
			book = Book.find(self.book_id)
			category_id = book.category_id
			unless category_id.blank?
				borrowed_book = Borrow.check_borrowed_books(category_id, :issued)
				return false if borrowed_book.present?
			end
		end
		return true
	end

	def check_for_quantity
		book = Book.find(self.book_id)
		if book.quantity > 0
			return true 
		else
			return false 
		end
	end

	def validate_due_date
		if self.due_date.present?
			return false if self.due_date.to_date - Date.today != 10
		else
			return true
		end
	end

end
