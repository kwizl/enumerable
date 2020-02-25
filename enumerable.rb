module Enumerable
  def my_each
    if self.class == Range
      l = to_a
      count = 0
      while count < l.length
        yield(l[count])
        count += 1
      end
      l
    else
      count = 0
      while count < length
        yield(self[count])
        count += 1
      end
      self
    end
  end

  def my_each_with_index
    count = 0
    while count < length
      yield(self[count], count)
      count += 1
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

  def my_inject(value = nil)
    each do |i|
      if value.nil?
        value = i
      elsif value.class == Range
        count = 0
        while count < length
          value += self[count]
          count += 1
        end
      else
        value = yield(value, i)
      end
    end
    value
  end

  def multiply_els(arr)
    arr.my_inject(0) { |i, j| i * j }
  end
end

arr = [5, 2, 3, 4]

puts 'my_each'
arr.my_each do |i|
  print i
end
puts
(0..2).my_each do |i|
  print i
end
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
p(arr.my_inject { |j, i| j + i })
p([5, 7, 8, 3].my_inject(1) { |j, i| j + i })
p((0..4).my_inject(1) { |j, i| j + i })
longest = %w[cat sheep bear].inject do |memo, word|
  memo.length > word.length ? memo : word
end
puts longest
p((1..5).my_inject(2, &:*))
