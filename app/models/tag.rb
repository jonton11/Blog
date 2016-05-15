class Tag < ActiveRecord::Base # :nodoc:
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  validates :name, presence: true, uniqueness: :true
end
