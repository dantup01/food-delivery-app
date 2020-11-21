class Customer
  attr_accessor :id
  attr_reader :name, :address

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @address = attributes[:address]
  end

  def self.headers
    %w[id name address]
  end

  def row_for_csv
    [id, name, address]
  end
end
