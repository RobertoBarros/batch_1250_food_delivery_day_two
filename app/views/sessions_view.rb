class SessionsView
  def ask_for(something)
    puts "Please enter your #{something}:"
    print '> '
    gets.chomp
  end

  def welcome(employee)
    puts "Welcome #{employee.username}!"
  end

  def wrong_credentials
    puts "Wrong credentials... Try again!"
  end
end
