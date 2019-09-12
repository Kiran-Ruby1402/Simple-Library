class CreateCategories < ActiveRecord::Migration[5.2]
  def up
    create_table :categories do |t|
    	t.string :label

      t.timestamps
    end
  end

  def down
  	drop_table :categories
  end

end
