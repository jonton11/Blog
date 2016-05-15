class Tagging < ActiveRecord::Base # :nodoc:
  belongs_to :tag
  belongs_to :post

  validates :tag_id, uniqueness: { scope: :post_id }
end
