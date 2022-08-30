# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user0 = User.create(name: 'Rafael')
user1 = User.create(name: 'Roberto')

def setpwd(user)
  user.password = 'valido'
  user.password_confirmation = 'valido'
  user.confirm
  user
end

user0 = setpwd(User.new(name: 'Rafael', email: 'rafael@mail.com'))
setpwd(User.new(name: 'Roberto', email: 'roberto@mail.com'))


food0 = Food.create(user: user0, name: 'Apple', measurement_unit: 'grams', price: 5, quantity: 50)
food1 = Food.create(user: user0, name: 'Pineapple', measurement_unit: 'grams', price: 1, quantity: 20)
food2 = Food.create(user: user0, name: 'Chicken breast', measurement_unit: 'unit', price: 2, quantity: 15)

recipe0 = Recipe.create(user: user0, name: 'Recipe 2', preparation_time: 1, cooking_time: 1,
                        description: 'Steps go here', public: true)

RecipeFood.create(quantity: 20, recipe: recipe0, food: food0)
RecipeFood.create(quantity: 10, recipe: recipe0, food: food1)
RecipeFood.create(quantity: 2, recipe: recipe0, food: food2)

recipe1 = Recipe.create(name: 'Pizza', preparation_time: 1, cooking_time: 1.5, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porttitor, neque non vehicula laoreet, leo nulla pellentesque odio, in malesuada lectus nisi sed elit. Sed id justo ut justo aliquam.", user: user0, public: false)
Recipe.create(name: 'Cesar Salad', preparation_time: 0.5, cooking_time: 0.2, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porttitor, neque non vehicula laoreet, leo nulla pellentesque odio, in malesuada lectus nisi sed elit. Sed id justo ut justo aliquam.", user: user1, public: false)
Recipe.create(name: 'Tomato Soup', preparation_time: 1, cooking_time: 1.5, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porttitor, neque non vehicula laoreet, leo nulla pellentesque odio, in malesuada lectus nisi sed elit. Sed id justo ut justo aliquam.", user: user0)
Recipe.create(name: 'Roast beef', preparation_time: 1, cooking_time: 1.5, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porttitor, neque non vehicula laoreet, leo nulla pellentesque odio, in malesuada lectus nisi sed elit. Sed id justo ut justo aliquam.", user: user1)

