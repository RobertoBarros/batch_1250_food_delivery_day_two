require 'digest'
require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def login
    # 1. Ask user for username
    username = @view.ask_for('username')
    # 2. Ask user for password
    password = Digest::MD5.hexdigest @view.ask_for('password')
    # 3. Find the employee with the username
    employee = @employee_repository.find_by_username(username)
    # 4. Check if the password is correct
    if employee && employee.password == password
      # 5. If correct, return the employee
      @view.welcome(employee)
      return employee
    else
      # 6. If not correct, ask again
      @view.wrong_credentials
      login
    end
  end
end
