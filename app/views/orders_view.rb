class OrdersView
  def ask_for(thing)
    puts "What is the #{thing} index?"
    gets.chomp.to_i - 1
  end

  def list_employees(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - Meal: #{order.meal.name} To: #{order.customer.name} By #{order.employee.username}"
    end
  end
end
