class Category < ActiveRecord::Base # :nodoc:
  validates :title, presence: true
end
