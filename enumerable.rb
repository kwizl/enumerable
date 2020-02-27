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

  def my_all?(val = nil)
    state = false
    count = 0
    if block_given?
      my_each do |i|
        (state = true if yield(i) == true)
        (state = false if yield(i) == false)
      end
    elsif val.class == Regexp
      my_each do |i|
        if i =~ val
          count += 0
        else
          count += 1
        end
      end
      state = false if count.positive?
      state = true if count.zero?
    elsif val.class == Class
      my_each do |i|
        if i.class.ancestors.include? val
          count += 0
        else
          count += 1
        end
      end
      state = false if count.positive?
      state = true if count.zero?
    elsif !block_given? && val.nil?
      my_each do |i|
        if i == true
          count += 0
        else
          count += 1
          break
        end
      end
      state = false if count.positive?
      state = true if count.zero?
    end
    state
  end

  def my_any?(val = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif val.nil?
      my_each { |i| return true if i }
    elsif val.class == Regexp
      my_each { |i| return true if i =~ val }
    elsif val.class == Class
      my_each { |i| return true if i.class.ancestors.include? val }
    else
      my_each { |i| return true if i == val }
    end
    false
  end

  def my_none?(val = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif val.nil?
      my_each { |i| return false if i }
    elsif val.class == Regexp
      my_each { |i| return false if i =~ val }
    elsif val.class == Class
      my_each { |i| return false if i.class.ancestors.include? val }
    else
      my_each { |i| return false if i == val }
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
