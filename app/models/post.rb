class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  has_many :comments, dependent: :destroy

  def self.search(search)
    if search
      self.where(["title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%"])
    else
      self.all
    end
  end

end
