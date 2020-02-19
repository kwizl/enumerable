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

  def my_select
    array = []
    my_each do |i|
      array.push(i) if yield(i)
    end
    array
  end

  def my_all?
    my_each do |i|
      if yield(i) == true
        return true
      else
        return false
      end
    end
    true
  end
end

arr = [2, 3, 8, 5, 7, 10]

arr.my_each do |i|
  print i
end
puts
puts

arr.my_each_with_index do |v, k|
  p "#{k}: #{v}"
end
puts

p(arr.my_select { |i| i > 4 })
puts

p(arr.my_all? { |i| i > 4 })
puts
