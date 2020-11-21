class OrdersView
  def ask_user_for_index
    puts "What index?"
    print "> "
    gets.chomp.to_i - 1
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.employee.username} must deliver #{order.meal.name} to #{order.customer.name}"
    end
  end
end
