require 'rails_helper'

RSpec.describe Book, type: :model do
 context "Book Creation" do
    it "with missing category attribute" do
    	book = Book.new
    	book.title = "Basic English"
    	book.quantity = 0
    	book.save
      	expect(book).to_not be_valid
    end
    it "with quantity attribute less han 0" do
    	book = Book.new
    	book.title = "Basic English"
    	book.quantity = -1
    	book.category = Category.create(label: "English")
    	book.save
      	expect(book).to_not be_valid
    end

    it "with valid attribute values" do
    	book = Book.new
    	book.title = "Basic English"
    	book.quantity = 0
    	book.category = Category.create(label: "English")
    	book.save
      	expect(book).to be_valid
    end
  end
end
