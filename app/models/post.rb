class Post < ActiveRecord::Base # :nodoc:
  validates :title, presence: true,
                    uniqueness: true,
                    length: { minimum: 7 }

  validates :body, length: { minimum: 5 }, presence: true

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  belongs_to :user
  belongs_to :category

  def self.search(search)
    if search
      where(['title ILIKE ? OR body ILIKE ?', "%#{search}%", "%#{search}%"])
    else
      all
    end
  end

  def body_snippet
    if body.length > 100
      body[0..99] + '...'
    else
      body
    end
  end

  def fav_for(user)
    favorites.find_by_user_id user if user
  end
end
