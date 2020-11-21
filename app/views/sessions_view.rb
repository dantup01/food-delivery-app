class SessionsView
  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def ask_user_for(element)
    puts "#{element}?"
    print "> "
    gets.chomp
  end

  def incorrect_password
    puts "Incorrect password, please try again"
    puts ""
  end
end
