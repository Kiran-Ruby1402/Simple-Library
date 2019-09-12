class BorrowsController < ApplicationController
	before_action :authenticate_user!

	before_action :check_borrowed_book, only: [:create]

	def index
		@borrowed_books = current_user.borrowed_books
	end

	def new
		book_id = params[:id]
		unless book_id.blank?
			@borrow = Borrow.new
			@book = Book.get_by_id(book_id)
			@category = @book.category
			@issued_date = Date.today
			@due_date = @issued_date + 10
		else
			p "Error message"
			redirect_to home_path
		end
		
	end

	def create
		p "Current User", current_user
		book_id = params[:id]
		@borrow = Borrow.new
		@borrow.user_id = current_user.id
		@borrow.book_id = book_id

		if @borrow.save 
			p "Success message"
		else 
			p "Failure message"
		end
		redirect_to home_path
	end

	def show
		id = params[:id]
		unless id.blank?
			@borrow = Borrow.get_borrowed_book(id)
		end
	end

	def update
		borrow_id = params[:id]
		unless borrow_id.blank?
			@borrow = Borrow.get_borrowed_book(borrow_id)
			@borrow.due_amount = calculate_due_amount_for(Date.today, @borrow.due_date.to_date)
			@borrow.status = :returned

			if @borrow.save 
				 p "Succes Message"
			else
				p "Error Message"
			end
		else
			p "Error Message"
		end
		redirect_to home_path
	end

	def delete
		borrow_id = params[:id]
	end


	private 
	def check_borrowed_book
		p "Inside Action"
		book_id = params[:id]
		unless book_id.blank?
			book = Book.find(book_id)
			category_id = book.category_id

			unless category_id.blank?
				borrowed_book = Borrow.check_borrowed_books(category_id, :issued)
				p "borrowed_book", borrowed_book
				if borrowed_book.present?
					p "Error message", "Can't borrow more than one book from same category"
					redirect_to categories_path
				else
					true
				end
			end
		end
	end

	def calculate_due_amount_for(today_date, due_date)
		due_amount = 0
		due_days = today_date - due_date
		if due_days > 0
			due_amount = due_days * 10
		end
		return due_amount
	end
end
