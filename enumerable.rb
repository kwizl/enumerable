module Enumerable

  def my_each
    for i in 0..self.length-1
        yield(self[i])
    end
    self
  end

end

arr = [2, 3, 4, 5]

arr.my_each do |i|
  print i 
end
puts
