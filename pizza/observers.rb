module Observers

    def add_observers observer
        @observers << observer
    end

    def notify_order pizza, money
        @observers.each {|observer| verify_order }

end