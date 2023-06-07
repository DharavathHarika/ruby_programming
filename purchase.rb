# frozen_string_literal: true
# purchase.rb
class Purchase
  attr_accessor :item, :quantity, :cost

  def initialize(item, quantity, cost)
    @item = item
    @quantity = quantity
    @cost = cost
  end
end