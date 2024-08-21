class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65_535 }

  attr_accessor :category_name

  def save_with_category(category_name)
    return unless category_name.present?

    category = Category.find_or_create_by(name: category_name)
    self.category = category
    save
  end
end
