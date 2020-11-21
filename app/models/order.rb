class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee, :delivered

  def initialize(attributes = {})
    @id = attributes[:id]
    @delivered = attributes[:delivered] || false
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @employee = attributes[:employee]
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

  def self.headers
    %w[id delivered meal_id customer_id employee_id]
  end

  def row_for_csv
    [id, delivered, meal.id, customer.id, employee.id]
  end
end
