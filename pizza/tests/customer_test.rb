require 'minitest/autorun'
require_relative '../pizza_shop'
require_relative '../customer'

describe Customer do
    before do 
        @pizza_shop = PizzaShop.new
        @customer = Customer.new @pizza_shop
    end
    it "ensures exception is raised if the ordered menu is incorrect" do
        assert_raises(RuntimeError) { @customer.place_order(['P'],100)}
    end
    it "ensures exception is raised if amount paid is incorrect" do
        assert_raises(RuntimeError) { @customer.place_order(['A'],100)}
    end

end