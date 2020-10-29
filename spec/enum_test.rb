require_relative '../enum.rb'

RSpec.describe Enumerable do
    let(:arr)  {[1,2,3,4]}
    let(:range){(1..10)}
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
end