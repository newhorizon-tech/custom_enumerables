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
        if yield(self[i]) 
          result << self[i]
        end 
    end
    result
  end

  def my_all?
    result = true
    if block_given?
      length.times do |i|
          if !yield(self[i]) or self[i] ==  nil
            result = false
          end 
      end
    else
      length.times do |i|
        if self[i] ==  nil
          result = false
        end 
      end
    end
    result
  end
end

arr = %w[test value test enum]

puts '-' * 40
puts "\n1. #my_each \n"
arr.my_each do |p|
  puts p
end
puts '-' * 40

puts "\n2. #my_each_with_index \n"

arr.my_each_with_index do |p, q|
  print [p, q]
  print "\n"
end
puts '-' * 40

test = [1,3,4,5,6,8]


puts '-' * 40
puts "\n3. #my_select \n"

my_num = test.my_select {|n| n%2 == 0}

puts my_num.inspect 

puts '-' * 40


puts "\n4. #my_all \n"

puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
puts [nil, true, 99].my_all?                              #=> false
puts [].my_all?                                           #=> true

puts '-' * 40





