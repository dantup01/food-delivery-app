class CustomersView
  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} - #{customer.address}"
    end
  end

  def ask_user_for_name
    puts "What is the name of the customer to add?"
    print "> "
    gets.chomp
  end

  def ask_user_for_address
    puts "What's the address of the customer?"
    print "> "
    gets.chomp
  end
end
