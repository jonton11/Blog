class Post < ActiveRecord::Base # :nodoc:
  validates :title, presence: true,
                    uniqueness: true,
                    length: { minimum: 7 }

  validates :body, presence: true

  has_many :comments, dependent: :destroy

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
end
