class CustomerRepository

  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    load_csv if File.exist?(@csv_file)
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def create(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  def all
    @customers
  end

  def find(id)
    @customers.select { |customer| customer.id == id }.first
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      id = row[:id].to_i
      name = row[:name]
      address = row[:address]

      @customers << Customer.new(id:, name:, address:)
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << %i[id name address]

      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
