# frozen_string_literal: true

# Custom Enumerable methods
module Enumerable
  def my_each
    if self.class == Range
      l = self.to_a
      for i in 0...l.length
        yield(l[i])
      end
      l
    else
      count = 0
      while count < self.length
        yield(self[count])
        count += 1
      end
      self
    end
  end
end

arr = [2, 3, 4, 5]

arr.my_each do |i|
  print i
end
puts
(0..2).my_each do |i|
  print i
end
puts
