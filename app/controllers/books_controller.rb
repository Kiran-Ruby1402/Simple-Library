class BooksController < ApplicationController
	before_action :authenticate_user!

	def index
		category_id = params[:id]
		unless category_id.blank?
			@books = Book.get_by_category(category_id)
		else
			@books = Book.all
		end
	end

	def name_filter
		book_name = params[:book_name]
		unless book_name.blank?
			@books = Book.serach_by_name(book_name)
		end
		redirect_to '/books'
	end
end
