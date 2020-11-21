require 'csv'

class BaseRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @elements = []
    @next_id = 1
    load_csv if File.exist?(csv_file)
  end

  def all
    @elements
  end

  def find(element_id)
    @elements.find { |element| element.id == element_id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      @elements << build_element(row)
    end
    @next_id = @elements.empty? ? 1 : @elements.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << @elements.first.class.headers
      @elements.each do |element|
        csv << element.row_for_csv
      end
    end
  end
end
