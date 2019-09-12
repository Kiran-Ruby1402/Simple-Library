class BorrowPresenter < BasePresenter
  presents :borrow

  def display_name    
    borrow.book.title
  end

  def book_category
  	borrow.book.category.label
  end

  def book_description
  	borrow.book.description
  end

  def issued_date
  	if borrow.created_at.blank?
      Date.today
    else
       borrow.created_at.to_date
    end
  end

  def due_date
    if borrow.due_date.blank?
      Date.today + 10.days
    else
       borrow.due_date.to_date 
    end
  end

  def return_date
  	Date.today
  end

  def status
  	borrow.status
  end

  def due_amount
  	due_amount = 0
  	due_days = Date.today - borrow.due_date.to_date
		if due_days > 0
			due_amount = due_days * 10
		end
	return due_amount
  end

  def is_issued
  	if borrow.status == "issued"
  		return true 
  	else
  		return false 
  	end
  end

  def is_book_available
  	if borrow.book.quantity > 0
  		return true 
  	else
  		return false
  	end
  end

end