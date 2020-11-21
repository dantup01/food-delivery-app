# TODO: implement the router of your app.
class Router
  def initialize(controllers = {})
    @meals_controller = controllers[:meals_controller]
    @customers_controller = controllers[:customers_controller]
    @sessions_controller = controllers[:sessions_controller]
    @orders_controller = controllers[:orders_controller]
    @running = true
  end

  def intro
    puts "Welcome to the Food Delivery App!"
    puts "---------------------------------"
  end

  def run
    intro
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
          route_manager
        else
          route_delivery
        end
      end
    end
  end

  def route_manager
    display_manager_actions
    action = gets.chomp.to_i
    print `clear`
    route_manager_action(action)
  end

  def route_delivery
    display_delivery_guy_actions
    action = gets.chomp.to_i
    print `clear`
    route_delivery_guy_action(action)
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 9 then logout!
    when 0 then stop!
    else
      puts "Please press 1, 2, 3, 4 or 5"
    end
  end

  def route_delivery_guy_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 9 then logout!
    when 0 then stop!
    else
      puts "Please press 9 or 0"
    end
  end

  def logout!
    puts "You have logged out"
    puts ""
    @current_user = nil
    run
  end

  def stop!
    logout!
    @running = false
  end

  def display_manager_actions
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a new customer"
    puts "5 - List all undelivered orders"
    puts "6 - Add a new order"
    puts "------------------------------"
    puts "9 - Logout"
    puts "0 - Stop and exit the program"
  end

  def display_delivery_guy_actions
    puts ""
    puts "What do you want to do next?"
    puts "1 - List my undelivered orders"
    puts "2 - Mark order as delivered"
    puts "------------------------------"
    puts "9 - Logout"
    puts "0 - Stop and exit the program"
  end
end
