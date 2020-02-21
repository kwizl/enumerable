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

  def my_count
    count = 0
    if block_given?
      my_each do |i|
        count += 1 if yield(i) == true
      end
    else
      my_each { count += 1 }
    end
    count
  end

  def my_map(proc_map = nil)
    array = []
    if proc_map.nil?
      my_each { |i| array.push(yield(i)) }
    else
      my_each do |i|
        array.push(proc_map.call(i))
      end
    end
    array
  end

  def my_inject(addition_value = nil)
    my_each do
      for i in 0...length
        addition_value = yield(self[i - 1], self[i])
      end
    end
    addition_value
  end

  def multiply_els(arr)
    arr.my_inject(0) { |i, j| i * j }
  end
end

<<<<<<< HEAD
arr = [2, 2, 2, 3, 4]
=======
arr = [5, 2, 3, 4]
>>>>>>> feature/my_map

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

puts 'my_count'
p(arr.my_count)
puts

puts 'my_count with block'
p(arr.my_count { |i| i > 1 })
puts

puts 'my_map'
p(arr.my_map { |i| i * 4 })
puts

puts 'my_map proc'
proc_map = proc { |i| i * 3 }
p(arr.my_map(proc_map))
puts

puts 'my_inject array'
p(arr.my_inject(0) { |i, j| i * j })
puts

puts 'multiply_els array'
p(multiply_els[arr])
puts
