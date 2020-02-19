# frozen_string_literal: true

# Custom Enumerable Methods
module Enumerable
  def my_each
    for i in 0..length - 1
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    for i in 0..length - 1
      yield(self[i], i)
    end
    self
  end
end

arr = [2, 3, 4, 5]

arr.my_each do |i|
  p i
end
puts

arr.my_each_with_index do |v, k|
  p "#{k}: #{v}"
end
puts
