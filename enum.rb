module Enumerable
  def my_each
    if block_given?
      my_each_arr = to_a
      my_each_arr.length.times { |i| yield(my_each_arr[i]) }
      self
    else
      enum_for
    end
  end

  def my_each_with_index
    if block_given?
      my_each_arr = to_a
      my_each_arr.length.times { |i| yield(my_each_arr[i], i) }
      self
    else
      enum_for
    end
  end

  def my_select
    if block_given?
      my_arr = to_a
      result = []
      my_arr.length.times do |i|
        result << my_arr[i] if yield(my_arr[i])
      end
      result
    else
      enum_for
    end
  end

  def my_all?(_arg = nil)
    my_arr = to_a
    result = true
    if block_given?
      my_arr.length.times { |i| result = false if !yield(my_arr[i]) or my_arr[i].nil? }
    else
      my_arr.length.times { |i| result = false if my_arr[i].nil? }
    end
    result
  end

  def my_any?
    result = false
    if block_given?
      length.times do |i|
        result = true if yield(self[i])
      end
    else
      enum_for
    end
    result
  end

  def my_none?
    result = true
    if block_given?
      length.times do |i|
        result = false if yield(self[i])
      end
    else
      enum_for
    end
    result
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      length.times do |i|
        count += 1 if yield(self[i])
      end
      count
    elsif !arg.nil?
      my_each do |item|
        count += 1 if item == arg
      end
      count
    else
      length
    end
  end

  def my_map
    map_array = to_a
    result = []
    map_array.length.times do |i|
      result << yield(map_array[i])
    end
    result
  end

  def my_inject(arg = nil)
    inject_arr = []
    inject_arr.push(arg) unless arg.nil?
    inject_arr += to_a
    answer = 0
    if inject_arr.length == 1
      inject_arr[0]
    else
      inject_arr.length.times do |a|
        if a.zero?
          answer = yield(inject_arr[0], inject_arr[1])
        elsif a > 1
          answer = yield(inject_arr[a], answer)
        end
      end
    end
    answer
  end
end

def multiply_els(arr)
  arr.my_inject { |item1, item2| item1 * item2 }
end

# arr = %w[test value test enum]

# puts '-' * 40
# puts "\n Enum method 1. #my_each \n"
#  arr.my_each do |p|
#    puts p
#  end

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
# puts { %w[ant bear cat].my_all? { |word| word.length >= 3 } } #=> true
# puts { %w[ant bear cat].my_all? { |word| word.length >= 4 } } #=> false
# puts [nil, true, 99].my_all? #=> false
# puts [].my_all? #=> true
# puts '-' * 40

# puts "\n Enum method 5. #my_any \n"
# puts { [1, 2, 3, 5, 6, 8].my_any? { |n| n > 9 } } #=> false
# puts { [1, 2, 3, 5, 6, 8].my_any? { |n| n > 7 } } #=> true
# puts '-' * 40

# puts "\n Enum method 6. #my_none \n"
# puts { [1, 2, 3, 5, 6, 8].my_none? { |n| n > 9 } } #=> true
# puts { [1, 2, 3, 5, 6, 8].my_none? { |n| n > 7 } } #=> false
# puts '-' * 40

# puts "\n Enum method 7. #my_count \n"
# puts { [1, 2, 3, 5, 6, 8].my_count { |n| n > 4 } } #=> 3
# puts { [1, 2, 3, 5, 6, 8].my_count { |n| n > 2 } } #=> 4

# ary = [1, 2, 3, 4, 3, 3, 3]
# puts ary.my_count #=> 7
# puts ary.my_count(3) #=> 4
# puts ary.my_count(&:even?) #=> 2
# puts '-' * 40

# puts "\n Enum method 8. #my_map \n"
# p { (1..4).my_map { |i| i * i } } #=> [1, 4, 9, 16]
# p { (1..4).my_map { 'cat' } } #=> ["cat", "cat", "cat", "cat"]
# p { (1..4).my_map {} }
# puts '-' * 40

# puts "\n Enum method 9. #my_inject \n"
# p 'Original Inject'
# p { [5].inject { |result, element| result * element } } # => 20
# # Same using a block and inject
# p { (5..10).inject { |sum, n| sum + n } } #=> 45
# # Same using a block}
# p { (5..10).inject(1) { |product, n| product * n } } #=> 151200
# # find the longest word
# longest = %w[cat sheep bear].inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest #=> "sheep"

# puts '-' * 40

# p 'My Inject'
# p { [5].my_inject { |result, element| result * element } } # => 20
# # Same using a block and inject
# p { (5..10).my_inject { |sum, n| sum + n } } #=> 45
# # Same using a block
# p { (5..10).my_inject(1) { |product, n| product * n } } #=> 151200
# # find the longest word
# longest = %w[cat sheep bear].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest #=> "sheep"
# new_inject = [[:key, 'CONVERT'], [:value, 'LOWER CASE']].each_with_object({}) do |element, result|
#   result[element.first.to_s] = element.last.downcase
# end
# p new_inject # => {"key"=>"convert", "value"=>"lower case"}
# p { [1.4, 2.1, 3.5].my_inject { |sum, n| sum + n } } #=> 7.0
# puts '-' * 40

# puts "\n Enum method 10. #multiply_els \n"
# p multiply_els([5, 2, 10, 8]) #=> 40
# puts '-' * 40

# puts "\n Enum method 11. #my_map proc \n"
# sq = proc { |x| x * x }
# cat_proc = proc { 'cat' }
# p { (1..4).my_map(&sq) }
# p { (1..4).my_map(&cat_proc) }
# puts '-' * 40

#--------------------------------------------------------------------------------

array = [1, 3, 4, 4, 3, 2, 6, 8, 6, 8, 5, 4, 1, 2, 6, 4, 5, 0, 8, 4, 8, 6, 1,
         4, 3, 7, 1, 1, 3, 4, 3, 2, 8, 0, 0, 6, 6, 8, 8, 3, 0, 6, 0, 5, 8, 2, 2, 4, 7,
         6, 3, 2, 6, 1, 8, 8, 6, 7, 7, 0, 2, 6, 4, 1, 6, 0, 5, 6, 4, 7, 1, 7, 6, 5, 2,
         6, 7, 8, 2, 0, 3, 7, 0, 1, 6, 4, 4, 5, 6, 3, 7, 3, 0, 2, 7, 5, 2, 5, 7, 5]

false_block = proc { |num| num > 9 }
range = Range.new(5, 50)
p range.my_all?(&false_block)
puts 'Original'
p range.all?(&false_block)
