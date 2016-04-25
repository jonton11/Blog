class AddCategoryReferencesToPosts < ActiveRecord::Migration # :nodoc:
  def change
    add_reference :posts, :category, index: true, foreign_key: true
  end
end
