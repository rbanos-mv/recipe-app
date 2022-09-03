module HomeHelper
  def calculate_needs
    list = current_user.recipes.includes(%i[recipe_foods])
    needs = Hash.new { |k, v| k[v] = 0 }
    list.each do |recipe|
      ingredients = recipe.recipe_foods.pluck(:food_id, :quantity).group_by(&:shift).transform_values(&:flatten)
      ingredients.each { |k, v| needs[k] += v[0] }
    end
    needs
  end

  def calculate_shopping
    needs = calculate_needs
    list = current_user.foods.pluck(:id, :name, :price, :quantity,
                                    :measurement_unit).group_by(&:shift).transform_values(&:flatten)

    items = []
    total = 0
    needs.each do |id, v|
      name, unitp, qty, measurement_unit = list[id]
      quantity = v - qty
      next unless quantity.positive?

      price = quantity * unitp
      total += price
      items << Food.new(name:, quantity:, price:, measurement_unit:)
    end
    [items, total]
  end
end
