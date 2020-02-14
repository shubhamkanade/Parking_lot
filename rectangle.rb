class Rectangle

    def self.create_square side
        Rectangle.new side, side
    end

    def initialize length, breadth
        @length = length
        @breadth = breadth
    end

    def area
        @length * @breadth
    end

    def perimeter
        2 * (@length + @breadth)
    end
    
end
