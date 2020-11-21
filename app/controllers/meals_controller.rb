require_relative '../models/meal'
require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    meals = @meal_repository.all
    @meals_view.display(meals)
  end

  def add
    name = @meals_view.ask_user_for_name
    price = @meals_view.ask_user_for_price
    meal = Meal.new(name: name, price: price)
    @meal_repository.create(meal)
  end
end
