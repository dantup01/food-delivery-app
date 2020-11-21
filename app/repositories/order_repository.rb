require_relative 'base_repository'
require_relative '../models/order'

class OrderRepository < BaseRepository
  attr_accessor :id
  attr_reader :csv_file, :meal_repository, :customer_repository, :employee_repository

  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    super(csv_file)
  end

  def create(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  def build_element(row)
    row[:id] = row[:id].to_i
    row[:delivered] = row[:delivered] == "true"
    row[:meal] = meal_repository.find(row[:meal_id].to_i)
    row[:customer] = customer_repository.find(row[:customer_id].to_i)
    row[:employee] = employee_repository.find(row[:employee_id].to_i)
    Order.new(row)
  end

  def undelivered_orders
    @elements.reject { |element| element.delivered? }
  end

  def my_undelivered_orders(current_user)
    @elements.select { |element| element.employee == current_user && !element.delivered? }
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  def save_csv
    super
  end
end
