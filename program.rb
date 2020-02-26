require './enumerable.rb'

arr = [2, 4, 5, 9, 6]
ar = {1 => 1, 2 => 2, 3 => 3}

puts 'my_each'
arr.my_each do |i|
  print i
end
puts
ar.each do |i|
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

puts
p [1,2,3,4].my_each
puts
puts
p [1,2,3,4].my_each_with_index
puts
puts
p arr.count(2)
puts
puts
p arr.my_select
puts
puts
p arr.my_map

puts
puts
p [1, 3, 5].my_none?(Float)
p [1, 3, 5].none?(Float)
p [true, false, true].none?
p [true, false, true].my_none?

puts
p %w{ant bear cat}.my_none?(/b/)
p %w{ant bear cat}.none?(/b/)

puts
puts '-----------------------'
p %w[ant bear cat].my_any?(/b/)
p %w[ant bear cat].any?(/b/)
p [nil, true, 99].my_any?(Integer)
p [nil, true, 99].any?(Integer)
p [nil, true, 99].my_any?
p [nil, true, 99].any? 

puts '----------------------'
p %w[ant beat cat].all?(/t/)
p %w[ant beat cat].my_all?(/t/)
p [1, 'a', 3.14].all?(Numeric)
p [1, 'a', 3.14].my_all?(Numeric)
p [true, true].my_all?
p [true, true].all?