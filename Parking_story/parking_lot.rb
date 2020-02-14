class ParkingLot
    include Observer
    PERCENT_80 = 80
    PERCENT_100 = 100
    attr_reader :observers, :available_parking_spaces
    def initialize *parking_spaces
        @observers = []
        @occupancy = {}
        @parking_spaces = parking_spaces
        @parking_spaces.each do |parking_space|
            parking_space.add_observer self
            @occupancy.merge! parking_space => 0
        end
        !@notified_on_80_percent #= false
        @total_percent_occupancy = 0
        @available_parking_spaces = parking_spaces
    end

    def update_on_space_full parking_space
        @available_parking_spaces.delete parking_space
        notify_on_space_full self if @available_parking_spaces.empty?
    end

    def update_on_space_open parking_space
        @available_parking_spaces << parking_space
        notify_on_space_open self
    end

    def update_occupancy parking_space
        calculate_occupancy parking_space
        if @total_percent_occupancy < PERCENT_80
            @notified_on_80_percent = false
        end
        check_occupancy
    end

    def check_occupancy
        if @total_percent_occupancy >= PERCENT_80 &&  !@notified_on_80_percent
            notify_on_80_percent_occupancy self
            @notified_on_80_percent = true
        end
        notify_on_space_full self if @total_percent_occupancy == PERCENT_100 
    end

    def calculate_occupancy parking_space
        occupied_slots = parking_space.occupied
        total_slots = parking_space.slots
        occupied_percentage = occupied_slots * 100 / total_slots
        @occupancy[parking_space] = occupied_percentage
        @total_percent_occupancy = @occupancy.values.inject { |a, b| a + b } / @occupancy.size
    end

end