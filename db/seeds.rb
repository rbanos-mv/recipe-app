# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
def description
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porttitor, neque non vehicula laoreet, \
leo nulla pellentesque odio, in malesuada lectus nisi sed elit. Sed id justo ut justo aliquam."[0..rand(100...300)]
end

def some_time
  options = ['20 min', '30 Min', '1 Hour', '1.5 Hours']
  options[rand(0..3)]
end

def setpwd(user)
  user.password = 'valido'
  user.password_confirmation = 'valido'
  user.confirm
  user
end

users = [
  setpwd(User.new(name: 'Rafael', email: 'rafael@mail.com')),
  setpwd(User.new(name: 'Roberto', email: 'roberto@mail.com'))
]

def create_foods(user)
  user_food_ids = []
  (0..9).each do |i|
    id = ((2 - (user.id % 2)) * 10) + i
    food = Food.create(user:, name: "Food #{id}", measurement_unit: 'grams', price: rand(1...10),
                       quantity: rand(5..10))
    user_food_ids << food.id unless i < 3
  end
  user_food_ids
end

def create_recipes(user, food_ids)
  # id = user.id * 10
  (0..5).each do |i|
    id = ((2 - (user.id % 2)) * 10) + i
    recipe = Recipe.create(user:, name: "Recipe #{id}", preparation_time: some_time,
                           cooking_time: some_time, description:, public: rand(0..1))
    add_ingredients(recipe, food_ids)
  end
end

def add_ingredients(recipe, food_ids)
  used = []
  (0..5).each do
    food_id = 0
    loop do
      index = rand(0..food_ids.length)
      next if used.include?(index)

      food_id = food_ids[index]
      used << index
      break
    end
    RecipeFood.create(quantity: rand(5...10), recipe:, food_id:)
    print '#'
  end
end

users.each do |user|
  user_food_ids = create_foods(user)
  create_recipes(user, user_food_ids)
end
