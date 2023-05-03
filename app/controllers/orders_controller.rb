require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
  end

  def add
    # 1. Ask user for meal index
    meals = @meal_repository.all
    @meals_view.list(meals)
    meal_index = @view.ask_for('meal')
    meal = meals[meal_index]

    # 2. Ask user for customer index
    customers = @customer_repository.all
    @customers_view.list(customers)
    customer_index = @view.ask_for('customer')
    customer = customers[customer_index]

    # 3. Ask user for employee index
    employees = @employee_repository.all_riders
    @view.list_employees(employees)
    employee_index = @view.ask_for('employee')
    employee = employees[employee_index]

    # 4. Create new order
    order = Order.new(meal: meal, customer: customer, employee: employee)

    # 5. Add to repo
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # 1. Get undelivered orders from repo
    orders = @order_repository.undelivered_orders

    # 2. Display them to user
    @view.display(orders)
  end

  def list_my_orders(employee)
    # 1. Get undelivered orders from repo
    orders = @order_repository.undelivered_orders.select { |order| order.employee == employee }

    # 2. Display them to user
    @view.display(orders)
  end

  def mark_as_delivered(employee)
    # 1. Get undelivered orders from repo
    orders = @order_repository.undelivered_orders.select { |order| order.employee == employee }

    # 2. Display them to user
    @view.display(orders)

    # 3. Ask user for order index
    order_index = @view.ask_for('order')

    # 4. Mark as delivered
    order = orders[order_index]
    order.deliver!

    # 5. Save to repo
    @order_repository.save_csv
  end
end
