require 'minitest/autorun'
require_relative '../parking_space'
require_relative '../attendant'
require_relative '../coordinator'
describe Coordinator do
    before do
        @parking_space_1 = ParkingSpace.new 1
        @parking_space_2 = ParkingSpace.new 2
        @honda_city = Object.new
        @attendant_1 = Attendant.new @parking_space_1
    end
    it 'ensures coordinator direct cars to his first attendants' do
        attendant_2 = Attendant.new @parking_space_2

        coordinator = Coordinator.new @attendant_1,attendant_2
        car_token = coordinator.direct @honda_city

        assert_equal(@honda_city.object_id, car_token)
    end
    
    it 'ensures coordinator directs car to his sub_coordinator' do
        sub_coordinator = Coordinator.new @attendant_1
        
        coordinator = Coordinator.new sub_coordinator
        car_token = coordinator.direct(@honda_city)

        assert_equal(@honda_city.object_id, car_token)
    end

    it 'ensures coordinator directs car to his subcoordinators' do 
        attendant_2 = Attendant.new @parking_space_2
        sub_coordinator_1 = Coordinator.new @attendant_1
        sub_coordinator_2 = Coordinator.new attendant_2
        coordinator = Coordinator.new sub_coordinator_1,sub_coordinator_2
        car_token = coordinator.direct(@honda_city)

        assert_equal(@honda_city.object_id, car_token)
    end

    it 'ensures coordinator directs car to his available subcoordinators' do        
        attendant_2 = Attendant.new @parking_space_2
        sub_coordinator_1 = Coordinator.new @attendant_1
        sub_coordinator_2 = Coordinator.new attendant_2
        @parking_space_1.park Object.new

        coordinator = Coordinator.new sub_coordinator_1,sub_coordinator_2
        car_token = coordinator.direct(@honda_city)

        assert_equal(@honda_city.object_id, car_token)
    end

    it 'ensures coordinator directs car to his subcoordinators and attendants' do       
        attendant_2 = Attendant.new @parking_space_2
        sub_coordinator_1 = Coordinator.new @attendant_1
        @parking_space_1.park Object.new
        @parking_space_2.park Object.new

        coordinator = Coordinator.new sub_coordinator_1,attendant_2
        car_token = coordinator.direct @honda_city

        assert_equal(@honda_city.object_id, car_token)
    end

    it 'ensures coordinator directs car to his coordinator who has subcoordinator' do
        attendant_2 = Attendant.new @parking_space_2
        sub_sub_coordinator = Coordinator.new @attendant_1,attendant_2
        sub_coordinator = Coordinator.new sub_sub_coordinator
        
        coordinator = Coordinator.new sub_coordinator
        car_token = coordinator.direct @honda_city
        
        assert_equal(@honda_city.object_id, car_token)
    end

    it 'raises exception PARKING FULL' do
        attendant_2 = Attendant.new @parking_space_2
        sub_coordinator_1 = Coordinator.new @attendant_1         
        @parking_space_1.park Object.new
        @parking_space_2.park Object.new
        @parking_space_2.park Object.new

        coordinator = Coordinator.new sub_coordinator_1,attendant_2
    
        assert_raises(RuntimeError) do
            coordinator.direct @honda_city
        end
    end

    it "subcoordinator notifies coordinator when his parking is full" do
        attendant_2 = Attendant.new @parking_space_2
        sub_coordinator_1 = Coordinator.new @attendant_1         
        coordinator = Coordinator.new sub_coordinator_1,attendant_2
        @parking_space_1.park Object.new
        refute_includes(coordinator.available_attendants,sub_coordinator_1)
    end

    it "subcoordinator notifies coordinator when his parking is again available" do 
        attendant_2 = Attendant.new @parking_space_2
        sub_coordinator_1 = Coordinator.new @attendant_1         
        coordinator = Coordinator.new sub_coordinator_1,attendant_2
        @parking_space_1.park @honda_city
        @parking_space_1.unpark @honda_city.object_id
        assert_includes(coordinator.available_attendants,sub_coordinator_1)
    end

    it 'subcoordinator notifies coordinator only if all his attendants are unavailable' do
        a2 = Attendant.new(ParkingSpace.new 4)
        sub_coordinator = Coordinator.new(@attendant_1 ,a2)
        coordinator = Coordinator.new(sub_coordinator)
        @parking_space_1.park @honda_city
        assert_includes(coordinator.available_attendants,sub_coordinator)
    end

    it 'raises error when trying to park if already full' do
        coordinator = Coordinator.new @attendant_1
        1.times { coordinator.direct(Object.new) }
        assert_raises(RuntimeError) do
          coordinator.direct(@honda_city)
        end
      end
end