require_relative '../enum.rb'

RSpec.describe Enumerable do
    let(:arr)  {[1,2,3,4,5,6,7,8,9]}
    let(:range){(1..10)}
    let(:hashh){["cat", "dog", "wombat"]}
    let(:truthy) {[]}
    describe "#my_each" do
        context "a block is given" do
            it "should return the element of an array" do
                expect(arr.my_each {|num| num}).to eql(arr.each {|num| num})
                expect(range.my_each {|num| num}).to eql(range.each {|num| num})
            end
        end

        context "a block is not given" do
            it "should return the Enumerator" do
                expect(arr.my_each.is_a?(Enumerable)).to eql(arr.each.is_a?(Enumerable))
            end
        end
    end
    describe '#my_each_with_index' do
        context "a block is given" do
            it "should return the element and the index of an array" do
                expect(hashh.my_each_with_index{|name, index| "#{name}, #{index}"}).to eql(hashh.each_with_index{|name, index| "#{name}, #{index}"})
            end
        end
    end
    describe "#my_select" do
        context "a block is given" do
            it "should return the element that satisfy the condition" do
                expect(arr.my_select {|num| num.even?}).to eql(arr.select {|num| num.even?})
            end 
        end
        context "a block is not given" do
            it "should return the enumerable" do
                expect(arr.my_select.is_a?(Enumerable)).to eql(arr.select.is_a?(Enumerable))
            end
        end
    end

    describe "#my_all?" do
        context "a block is given" do
            it "should return true if all of of the elements are true" do
                expect(hashh.my_all? {|word| word.length >= 3}).to eql(hashh.all? {|word| word.length >= 3})
            end
        end

        context "an argument is given without block" do 
            it "should return true if all the elements include the argument" do
                expect(hashh.my_all?(/t/)).to eql(hashh.all?(/t/))
            end
        end

        context "No argument is given" do
            it "should return true if all the elements are truthy" do
                expect(truthy.my_all?).to eql(truthy.all?)
            end
        end
    end
end
