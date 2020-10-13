module Enumerable
  def my_each
    length.times do |i|
      yield(self[i])
    end
  end

  def my_each_with_index
    length.times do |i|
      yield(self[i], i)
    end
  end

  def my_select
    result = []
    length.times do |i|
      result << self[i] if yield(self[i])
    end
    result
  end

  def my_all?
    result = true
    if block_given?
      length.times do |i|
        result = false if !yield(self[i]) or self[i].nil?
      end
    else
      length.times do |i|
        result = false if self[i].nil?
      end
    end
    result
  end

  def my_any?
    result = false
    if block_given?
      length.times do |i|
        result = true if yield(self[i])
      end
    end
    result
  end

  def my_none?
    result = true
    if block_given?
      length.times do |i|
        result = false if yield(self[i])
      end
    end
    result
  end

  def my_count(*arg)
    count = 0
    if block_given?
      length.times do |i|
        count += 1 if yield(self[i])
      end
      count
    elsif !arg.empty?
      self.my_each do |item|
        if item == 2
          count += 1
        end
      end
      count
    else
      self.length
    end
  end

  def my_map
    map_array = self.to_a
    result = []
    map_array.length.times do |i|
    result << yield(map_array[i])
     end
  result
  end
end

# arr = %w[test value test enum]

# puts '-' * 40
# puts "\n Enum method 1. #my_each \n"
# arr.my_each do |p|
#   puts p
# end

# puts '-' * 40
# puts "\nEnum method 2. #my_each_with_index \n"
# arr.my_each_with_index do |p, q|
#   print [p, q]
#   print "\n"
# end
# puts '-' * 40

# test = [1, 2, 3, 5, 6, 8]

# puts '-' * 40
# puts "\n Enum method 3. #my_select \n"
# my_num = test.my_select(&:even?)
# puts my_num.inspect
# puts '-' * 40

# puts "\n Enum method 4. #my_all \n"
# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts [nil, true, 99].my_all? #=> false
# puts [].my_all? #=> true
# puts '-' * 40

# puts "\n Enum method 5. #my_any \n"
# puts [1, 2, 3, 5, 6, 8].my_any? { |n| n > 9 } #=> false
# puts [1, 2, 3, 5, 6, 8].my_any? { |n| n > 7 } #=> true
# puts '-' * 40

# puts "\n Enum method 6. #my_none \n"
# puts [1, 2, 3, 5, 6, 8].my_none? { |n| n > 9 } #=> true
# puts [1, 2, 3, 5, 6, 8].my_none? { |n| n > 7 } #=> false
# puts '-' * 40

# puts "\n Enum method 7. #my_count \n"
# puts [1, 2, 3, 5, 6, 8].my_count { |n| n > 4 } #=> 3
# puts [1, 2, 3, 5, 6, 8].my_count { |n| n > 2 } #=> 4
# puts '-' * 40

 puts "\n Enum method 8. #my_map \n"
p (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
p (1..4).my_map {} 
 puts '-' * 40
