require 'minitest/autorun'
require_relative '../pizza_shop'

describe PizzaShop do

    before do
        @pizza_shop = PizzaShop.new 
    end
    
    it 'ensures the veg_menu contains A,B,C pizza' do
        assert_equal(['A','B','C'],@pizza_shop.veg_menu.keys)
    end

    it 'ensures the nonveg_menu contains X,Y,Z pizza' do
        assert_equal(['X','Y','Z'],@pizza_shop.nonveg_menu.keys)
    end

end