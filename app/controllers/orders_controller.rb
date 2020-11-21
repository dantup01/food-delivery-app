require_relative '../models/order'
require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/sessions_view'
require_relative '../views/customers_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @sessions_view = SessionsView.new
    @customers_view = CustomersView.new
  end

  def add
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = Order.new(meal: meal, employee: employee, customer: customer)
    @order_repository.create(order)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @orders_view.display(undelivered_orders)
  end

  def list_my_orders(current_user)
    orders = @order_repository.my_undelivered_orders(current_user)
    @orders_view.display(orders)
  end

  def mark_as_delivered(current_user)
    list_my_orders(current_user)
    index = @orders_view.ask_user_for_index
    my_orders = @order_repository.my_undelivered_orders(current_user)
    order_to_be_marked = my_orders[index]
    @order_repository.mark_as_delivered(order_to_be_marked)
  end

  private

  def select_meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @orders_view.ask_user_for_index
    return meals[index]
  end

  def select_customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @orders_view.ask_user_for_index
    return customers[index]
  end

  def select_employee
    employees = @employee_repository.all_delivery_guys
    @sessions_view.display(employees)
    index = @orders_view.ask_user_for_index
    return employees[index]
  end
end
