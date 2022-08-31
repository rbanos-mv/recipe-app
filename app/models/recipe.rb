class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'recipe_id', dependent: :destroy
  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
end
