class Post < ApplicationRecord
  mount_uploaders :images, ImageUploader

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy

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
      images: post_params[:images].presence || self.images_cache
    )
  end

  def liked_by?(user)
    liked_users.exists?(user.id)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


  def self.ransackable_associations(auth_object = nil)
    [ "category", "comments", "liked_users", "likes", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "content", "created_at" ]
  end
end
