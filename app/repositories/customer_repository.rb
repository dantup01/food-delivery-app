require_relative '../models/customer'
require_relative 'base_repository'

class CustomerRepository < BaseRepository
  def create(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  def build_element(row)
    row[:id] = row[:id].to_i
    Customer.new(row)
  end
end
