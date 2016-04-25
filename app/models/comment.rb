class Comment < ActiveRecord::Base # :nodoc:
  validates :body, presence: true

  belongs_to :post
  belongs_to :user
end
