require_relative '../models/employee'
require_relative 'base_repository'

class EmployeeRepository < BaseRepository
  def build_element(row)
    row[:id] = row[:id].to_i
    Employee.new(row)
  end

  def all_delivery_guys
    @elements.select { |element| element.delivery_guy? }
  end

  def find_by_username(username)
    @elements.find { |element| element.username == username }
  end
end
