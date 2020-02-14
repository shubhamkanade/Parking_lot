class Customer
    def initialize pizza_shop
        @pizza_shop = pizza_shop
        @pizza_shop.add_observer self
    end
    
    def place_order pizza, money
        notify_order(pizza,money)
    end
end