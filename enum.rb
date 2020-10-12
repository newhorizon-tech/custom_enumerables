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
