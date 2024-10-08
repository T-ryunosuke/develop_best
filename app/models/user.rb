class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader


  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followee_id", dependent: :destroy
  has_many :followees, through: :relationships, source: :followee
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :authentications, dependent: :destroy

  validates :name, presence: true, length: { maximum: 25 }
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  enum gender: { no_answer: 0, male: 1, female: 2 }
  enum age: { secret: 0, teens: 1, twenties: 2, thirties: 3, forties: 4, fifties: 5, over_sixties: 6 }

  accepts_nested_attributes_for :authentications

  def mine?(object)
    id == object.user_id
  end

  # フォローしたとき
  def follow(user_id)
    relationships.create(followee_id: user_id)
  end
  # フォローを外すとき
  def unfollow(user_id)
    relationships.find_by(followee_id: user_id).destroy
  end

  def followee?(user)
    followees.include?(user)
  end

  def self.ransackable_attributes(auth_object = nil)
  [ "name" ]
  end

  def self.ransackable_associations(auth_object = nil)
  [ "comments", "followees", "followers", "liked_posts", "likes", "posts", "relationships", "reverse_of_relationships" ]
  end
end
