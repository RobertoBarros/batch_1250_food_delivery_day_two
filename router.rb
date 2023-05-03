class Router

  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
  end

  def run

    @employee = @sessions_controller.login

    loop do
      if @employee.manager?
        print_actions_manager
        action = gets.chomp.to_i
        dispatch_action_manager(action)
      else
        print_actions_rider
        action = gets.chomp.to_i
        dispatch_action_rider(action)
      end
    end
  end

  private

  def print_actions_manager
    puts '-' * 50
    puts "1. List meals"
    puts "2. Create meal"
    puts '-' * 50
    puts "3. List customers"
    puts "4. Create customer"
    puts '-' * 50
    puts "5. Create order"
    puts "6. List undelivered orders"
    puts '-' * 50
    puts "Enter your option:"
  end

  def dispatch_action_manager(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    end
  end

  def print_actions_rider
    puts '-' * 50
    puts "1. List my undelivered orders"
    puts "2. Mark order as delivered"

    puts '-' * 50
    puts "Enter your option:"
  end

  def dispatch_action_rider(action)
    case action
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    end
  end

end
