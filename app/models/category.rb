class Category < ActiveRecord::Base # :nodoc:
  validates :title, presence: true
  has_many :posts
end
