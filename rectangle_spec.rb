require "minitest/autorun"
require_relative "rectangle"


describe Rectangle do
    it "calculates area of 4X5 rectangle" do
        rectangle = Rectangle.new 4,5
        area = rectangle.area
        expect(area).must_equal 20
    end
    it "calculates area of 5x6 rectangle" do
        rectangle = Rectangle.new 5,6
        area = rectangle.area
        expect(area).must_equal 30
    end
    it "calculates perimeter of 4X5 rectangle" do
        rectangle = Rectangle.new 4,5
        perimeter = rectangle.perimeter 
        expect(perimeter).must_equal 18
    end
    it "calculates perimeter of 5X6 rectangle" do
        rectangle = Rectangle.new 5,6
        perimeter = rectangle.perimeter 
        expect(perimeter).must_equal 22
    end
    it "calculates area of square with side 4" do
        square = Rectangle.create_square 4
        area = square.area
        expect(area).must_equal 16
    end
 end

