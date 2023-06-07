# frozen_string_literal: true
require_relative 'person'
# customer.rb
class Customer < Person
  attr_accessor :name, :email, :phone, :purchases

  def initialize(name, email, phone)
    super(name,email,phone)
    @purchases = []
  end

  def add_purchase(item, quantity, cost)
    @purchases << Purchase.new(item, quantity, cost)
  end

  def display
    puts @name+ " <"+@email+"> Phone:>"+@phone
  end

  def display_purchase
    size =@purchases.size
    (0..size-1).each do | j|
    sale = @purchases[j]
    puts "#{sale.item} \t\t #{sale.cost}\t#{sale.quantity}\t#{sale.cost*sale.quantity.to_f}"
  end
  end

end
