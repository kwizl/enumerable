# frozen_string_literal: true

# Custom Enumerable methods
module Enumerable
  def my_each
    count = 0
    while count < self.length
      yield(self[count])
      count += 1
    end
    self
  end
end

arr = [2, 3, 4, 5]

arr.my_each do |i|
  print i
end
puts
