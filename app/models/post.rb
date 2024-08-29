class Post < ApplicationRecord
  mount_uploaders :images, ImageUploader

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65_535 }

  attr_accessor :category_name


  def save_with_category(category_name)
    if category_name.present?
      category = Category.find_or_create_by(name: category_name)
      self.category = category
    end
    save
  end

  def update_with_category(post_params)
    # 空白でない場合にのみカテゴリ情報を更新
    if post_params[:category_name].present?
      category = Category.find_or_create_by(name: post_params[:category_name])
      # 関連付け機能により以下の記述は「postのcategory_idカラムにcategory.idをセットする」という意味になる
      self.category = category
    end

    # 空白なら既存の値を保持する
    update(
      title: post_params[:title].presence || self.title,
      content: post_params[:content].presence || self.content,
      images: post_params[:images].presence || self.images
    )
  end

  def liked_by?(user)
    liked_users.exists?(user.id)
  end
end
