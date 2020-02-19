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
      (return true if yield(i) == true)
      (return false if yield(i) == false)
    end
    true
  end

  def my_any?
    count = 0
    state = false
    my_each do |i|
      count += 1 if yield(i) == true
      count += 0 if yield(i) == false
    end
    state = true if count.positive?
    state = false if count.zero?
    state
  end

  def my_none?
    count = 0
    state = false
    my_each do |i|
      count += 1 if yield(i) == true
      count += 0 if yield(i) == false
    end
    state = false if count.positive?
    state = true if count.zero?
    state
  end
end

arr = [1, 2, 3]

puts 'my_each'
arr.my_each do |i|
  print i
end
puts
puts

puts 'my_each_with_index'
arr.my_each_with_index do |v, k|
  p "#{k}: #{v}"
end
puts

puts 'my_select'
p(arr.my_select { |i| i > 4 })
puts

puts 'my_all'
p(arr.my_all? { |i| i > 4 })
puts

puts 'my_any'
p(arr.my_any? { |i| i > 4 })
puts

puts 'my_none'
p(arr.my_none? { |i| i > 4 })
puts
