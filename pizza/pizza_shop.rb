# require_relative 'observers'
# require_relative 'cashier'
class PizzaShop
    attr_reader :veg_menu, :nonveg_menu
    def initialize
        @veg_menu = { 'A' => 100,'B' => 130,'C' => 150 }
        @nonveg_menu = { 'X' => 200,'Y' => 230,'Z' => 250 }
    end
end

