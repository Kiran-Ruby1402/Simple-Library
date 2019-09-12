require 'rails_helper'

RSpec.describe Borrow, type: :model do
  context "Borrow Creation" do
    it "with valid attibute values" do
    	book = Book.new
    	book.title = "Basic English"
    	book.quantity = 0
    	book.category = Category.create(label: "English")
    	book.save

    	borrow = Borrow.new
    	borrow.user = User.create(email: "example@yopmail.com", password: "password")
    	borrow.book = book
    	borrow.category_id = book.category.id
    	borrow.save
      	expect(borrow).to be_valid
    end
    it "with missing user attibute" do
    	book = Book.new
    	book.title = "Basic English"
    	book.quantity = 0
    	book.category = Category.create(label: "English")
    	book.save

    	borrow = Borrow.new
    	borrow.book = book
    	borrow.category_id = book.category.id
    	borrow.save
      	expect(borrow).to_not be_valid
    end

    it "with missing user attibute" do
    	book = Book.new
    	book.title = "Basic English"
    	book.quantity = 0
    	book.category = Category.create(label: "English")
    	book.save

    	borrow = Borrow.new
    	borrow.user = AdminUser.create(email: "example@yopmail.com", password: "password")
    	borrow.book = book
    	borrow.category_id = 1
    	borrow.save
      	expect(borrow).to be_valid
    end
  end
end
