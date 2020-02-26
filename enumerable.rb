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
    elsif self.class == Hash
      count = 0
      while count < length
        yield(self[count])
        count += 1
      end
      self
    elsif !block_given?
      self
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
    if block_given?
      count = 0
      while count < length
        yield(self[count], count)
        count += 1
      end
      self
    else
      self
    end
    self
  end

  def my_select
    if block_given?
      array = []
      my_each do |i|
        array.push(i) if yield(i)
      end
      array
    else
      self
    end
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

  def my_none?(val = nil)
    if block_given?
      my_each { |element| return false if yield(element) }
    elsif val.nil?
      my_each { |element| return false if element }
    elsif val.class == Class
      my_each { |element| return false if element.class.ancestors.include? val }
    elsif val.class == Regexp
      my_each { |element| return false if element =~ val }
    else
      my_each { |element| return false if element == val }
    end
    true
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
    if block_given?
      if proc_map.nil?
        my_each { |i| array.push(yield(i)) }
      elsif block_given?
        my_each do |i|
          array.push(proc_map.call(i))
        end
        array
      end
    else
      self
    end
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
