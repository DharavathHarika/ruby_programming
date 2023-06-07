# frozen_string_literal: true
require_relative 'person'

class Employee < Person
  attr_accessor :name, :email, :phone, :salary

  def initialize(name, email, phone, salary)
    super(name,email,phone)
    @salary = salary
  end
end
