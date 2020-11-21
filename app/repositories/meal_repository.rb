require_relative '../models/meal'
require_relative 'base_repository'

class MealRepository < BaseRepository
  def create(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  def build_element(row)
    row[:id] = row[:id].to_i
    row[:price] = row[:price].to_i
    Meal.new(row)
  end
end
