class OrderRepository

  def initialize(csv_file, meal_repository, customer_repository, employee_repository)

    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository

    @csv_file = csv_file
    @orders = []
    load_csv if File.exist?(@csv_file)
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def all
    @orders
  end

  def find(id)
    @orders.select { |order| order.id == id }.first
  end

  def undelivered_orders
    @orders.reject(&:delivered?)
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      id = row[:id].to_i
      meal_id = row[:meal_id].to_i
      meal = @meal_repository.find(meal_id)
      customer_id = row[:customer_id].to_i
      customer = @customer_repository.find(customer_id)
      employee_id = row[:employee_id].to_i
      employee = @employee_repository.find(employee_id)

      @orders << Order.new(id: id, meal: meal, customer: customer, employee: employee, delivered: row[:delivered] == 'true')
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << %i[id meal_id customer_id employee_id delivered]

      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end
