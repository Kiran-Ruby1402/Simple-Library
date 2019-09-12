class Category < ApplicationRecord
	has_many :books
	validates_uniqueness_of :label
end
