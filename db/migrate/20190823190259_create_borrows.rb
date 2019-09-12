class CreateBorrows < ActiveRecord::Migration[5.2]
  def up
    create_table :borrows do |t|
    	t.integer :user_id
    	t.integer :category_id
    	t.integer :book_id
    	t.integer :status
      t.datetime :due_date
    	t.datetime :return_date
      t.integer :due_amount
      t.timestamps
    end
    add_index :borrows, :user_id, name: "by_learner" 
    add_index :borrows, :category_id, name: "by_category"
    add_index :borrows, :book_id, name: "by_book"
    add_index :borrows, :status, name: "by_status"
    add_index :borrows, [:category_id, :created_at, :status], name: "by_borrowed_book"
  end

  def down
  	remove_index :borrows, :user_id
  	remove_index :borrows, :category_id
  	remove_index :borrows, :book_id
  	remove_index :borrows, :status
    remove_index :borrows, [:category_id, :created_at, :status]

  	drop_table :borrows
  end
end
