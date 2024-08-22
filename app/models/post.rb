class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65_535 }
  validates :category_name, presence: true

  attr_accessor :category_name

  def save_with_category(category_name)
    return unless category_name.present?

    category = Category.find_or_create_by(name: category_name)
    self.category = category
    save
  end

  def update_with_category(post_params)
    self.category_name = post_params[:category_name]

    if category_name.present?
      category = Category.find_or_create_by(name: category_name)
      self.category = category
    end

    update(post_params.except(:category_name))
  end
end
