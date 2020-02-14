class ParkingStaff
    include Observer
    attr_reader :observers
    def initialize
        @observers = []
    end

    def direct 
        raise "Illegal access to 'direct' method."
    end
    def update_on_space_full 
        raise "Illegal access to 'update_on_space_full' method."
    end
    def update_on_space_open 
        raise "Illegal access to 'update_on_space_open' method."
    end

end