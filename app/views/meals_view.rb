class MealsView
  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} - £#{meal.price}"
    end
  end

  def ask_user_for_name
    puts "What meal do you want to add?"
    print "> "
    gets.chomp
  end

  def ask_user_for_price
    puts "What's the price of the meal?"
    print "> "
    gets.chomp.to_i
  end
end
