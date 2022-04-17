class Post < ApplicationRecord

  has_one_attached :video

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre

  validates :title, :description, :video, presence: true

  def self.search(search_word)
    Post.where(['category LIKE ?', "#{search_word}"])
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end

end
