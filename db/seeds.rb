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

setpwd(User.new(id: 1, name: 'Rafael', email: 'rafael@mail.com'))
setpwd(User.new(id: 2, name: 'Roberto', email: 'roberto@mail.com'))

recipe_id = 0
food_base = 1
2.times do |user_id|
  user = User.find(user_id + 1)
  print user_id
  food_max = rand(5...10)
  food_max.times do |food|
    food_id = food + 1
    Food.create(user:, name: "Food #{food_id}", measurement_unit: 'grams', price: rand(1...10),
                quantity: 1 * rand(5..10))
  end

  recipe_max = rand(2...5)
  recipe_max.times do
    recipe_id += 1
    Recipe.create(id: recipe_id, user:, name: "Recipe #{recipe_id}", preparation_time: some_time,
                  cooking_time: some_time, description:, public: rand(0..1))

    used = []
    ingredient_max = rand(3...6)
    ingredient_max.times do
      food_id = 0
      loop do
        food_id = food_base + rand(0..food_max)
        unless used.include?(food_id)
          used << food_id
          break
        end
      end
      RecipeFood.create(quantity: rand(5...10), recipe_id:, food_id:)
      print '.'
    end
  end
  food_base + food_max
end
