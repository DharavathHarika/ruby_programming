require 'yaml'
require_relative 'customer'
require_relative 'employee'
require_relative 'person'
require_relative 'purchase'


class Companydb
  attr_accessor :name, :employees, :customers

  def initialize(name)
    @name = name
    @employees = []
    @customers = []
  end

  def add_employee(employee)
    @employees << employee
  end


  def add_customer(customer)
    @customers << customer
  end

  def display_employees
    # if @employees.empty?
    #   puts 'No employees found.'
    # else
      @employees.each { |employee| print("#{employee.name}\t<#{employee.email}>\tPhone: #{employee.phone}\tSalary: $#{employee.salary}\n")}

    # end
  end

  def display_customers
    # if @sales.empty?
    #   puts 'No sales found.'
    # else
    #   puts 'Sales:'
    #   @sales.each { |sale| puts sale }
    # end

    if @customers.empty?
      puts 'Error: No Customers.'
    else
      # puts 'Customers:'
      @customers.each_with_index {  |element, index|
        puts " #{index+1}.) #{element.name}" }
    end
  end

  def save_data
    data = YAML.dump(self)
    File.write("#{name}.dat", data)
    puts "Data saved to #{name}.dat."
  end

  # def self.readData(data)
  #   no_of_employees = data[0]
  #   j=0
  #   index=0
  #   (1..no_of_employees).each { |i|
  #     name = data[ j * 4]
  #     email = data[j * 4 + 1]
  #     phone = data[ j * 4 + 2]
  #     salary = data[j * 4 + 3]
  #     j += 1
  #     index = i+j*4+3
  #     self.add_employee(Employee.new(name, email, phone, salary))
  #   }
  #   index+=1
  #   no_of_customers= data[index]
  #   indexCustomers=0
  #   (1..no_of_customers).each do |i|
  #     name = data[index+indexCustomers*3]
  #     email = data[index+indexCustomers*3+1]
  #     phone = data[index+indexCustomers*3+2]
  #     purchases=[]
  #     no_of_purchases= data[index+indexCustomers*3+3]
  #     nowIndex = index+indexCustomers*3+3
  #     saleIndex=0
  #     (1..no_of_purchases).each do | j|
  #       item = data[nowIndex+saleIndex*3]
  #       quantity = data[nowIndex+saleIndex*3+1]
  #       cost = data[nowIndex+saleIndex*3+2]
  #       purchases.add(Purchase.new(item,quantity,cost))
  #     end
  #     customer =Customer.new(name,email,phone)
  #     customer.purchases = purchases
  #     self.add_customer(customer)
  #   end
  # end

  def self.load_data(company_name)
    file_path = "#{company_name}.dat"
    if File.exist?(file_path)
      data = File.readlines(file_path)
      # data = YAML.load(data)
      company= readData(data,company_name)
      # Companydb.new(company_name)
      company
    else
      Companydb.new(company_name)
    end
  end
end

def prompt(message)
  print message
  gets.chomp
end


def readData(data,company_name)

  company  = Companydb.new(company_name)
  no_of_employees = data[0].to_i
  j=0
  index=0
    (1..no_of_employees).each do |i|
      name = data[ j + 1].strip
      email = data[j  + 2].strip
      phone = data[ j  + 3].strip
      salary = data[j  + 4].to_f
      j =j+4
      index=j+1
      company.add_employee(Employee.new(name, email, phone, salary))
    end
  no_of_customers= data[index].to_i
  (1..no_of_customers).each do |i|
    name = data[index+1].strip
    email = data[index+2].strip
    phone = data[index+3].strip
    purchases=[]
    no_of_purchases= data[index+4].to_i
    nowIndex = index+4
    (1..no_of_purchases).each do | j|
      item = data[nowIndex+1].strip
      quantity = data[nowIndex+2].to_i
      cost = data[nowIndex+3].to_i
      nowIndex=nowIndex+3
      purchases << Purchase.new(item,quantity,cost)
    end
    customer =Customer.new(name,email,phone)
    customer.purchases = purchases
    company.add_customer(customer)
    index=nowIndex
  end
  company
end

company_name = prompt('Enter the name of the company: ')
company = Companydb.load_data(company_name)





loop do
  puts "\nMAIN MENU:"
  puts '1.) Employees'
  puts '2.) Sales'
  puts '3.) Quit'

  choice = prompt('Choice? ').to_i


  case choice
    when 1
      loop do
          # puts "\n\tEmployees Menu:"
          # puts '(A)dd Employee or  (M)ain Menu?'

          company.display_employees
          puts ""
          employees_choice = prompt('(A)dd Employee or  (M)ain Menu?')

          case employees_choice
          when 'M'
            break
          when 'A'

            employee_name = prompt('Name: ')
            employee_email = prompt('Email: ')
            phone = prompt('Phone: ')
            salary  = prompt('Salary: ').to_f
            company.add_employee(Employee.new(employee_name,employee_email, phone,salary))

            # puts "Employee '#{employee_name}' added."
          else
            puts 'Invalid choice.'
          end
    end
  when 2
    loop do
    # puts '(A)dd Customer,Enter a (S)ale,(V)iew Customer, or (M)ain Menu?'

    sales_customers_choice = prompt('(A)dd Customer,Enter a (S)ale,(V)iew Customer, or (M)ain Menu?')

    case sales_customers_choice
    when 'A'
      customer_name =prompt("Name: ")
      email =prompt("Email: ")
      phone = prompt("Phone: ")
      company.add_customer(Customer.new(customer_name,email,phone))
      # puts "Customer is #{customer_name} is added"
    when 'S'
      company.display_customers
      unless company.customers.empty?
        choice_of_customer = prompt('Choice? ').to_i
        customer_name = company.customers[choice_of_customer - 1]

        item = prompt('Item: ')
        quantity = prompt('Quantity: ')
        cost = prompt('Cost: ').to_f
        customer_name.add_purchase(item, quantity, cost)
      end
      # puts "Sale '#{item}' added."
    when 'V'
      company.display_customers
      unless company.customers.empty?
        choice_of_customer = prompt('Choice? ').to_i
        customer_name = company.customers[choice_of_customer-1]
        customer_name.display
        # # printString = customer_name.name+"<"+customer_name.email+"> Phone:"+  customer_name.phone
        # print printString
        puts"\nOrder History"
        puts"Item \t\t Price  Quantity  Total"
        customer_name.display_purchase
      end


    else
      break
    end
    end

  when 3
    company.save_data
    break
  else
    puts 'Invalid choice.'
  end
end
