class CreateBooks < ActiveRecord::Migration[5.2]
  def up
    create_table :books do |t|
    	t.string :title
    	t.text :description
    	t.integer :quantity
    	t.integer :category_id

      t.timestamps
    end

    add_index :books, :title, name: "by_title"
  end

  def down 
  	remove_index :books, :title
  	drop_table :books
  end

end
