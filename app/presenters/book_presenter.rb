class BookPresenter < BasePresenter
  presents :book

  def display_name    
    book.title
  end

  def category
  	book.category.label
  end

  def description
  	book.description
  end

  def quantity
  	book.quantity
  end

  def is_book_available
  	if book.quantity > 0
  		return true 
  	else
  		return false
  	end
  end

end