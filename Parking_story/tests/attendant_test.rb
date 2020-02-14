# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../parking_space'
require_relative '../attendant'
require_relative '../coordinator'

describe Attendant do
  it 'Ensures that an attendant is directing car to ther respective space' do
    p1 = ParkingSpace.new 10
    p2 = ParkingSpace.new 2

    attendant = Attendant.new(p1, p2)
    honda_city = Object.new
    expected = honda_city.object_id
    actual = attendant.direct(honda_city)
    assert_equal(expected, actual)
  end

  it 'Ensures that an attendant is directing car to ther respective space' do
    p1 = ParkingSpace.new 1
    p2 = ParkingSpace.new 2

    attendant = Attendant.new(p1, p2)
    honda_city = Object.new
    honda_civic = Object.new
    expected = honda_civic.object_id
    attendant.direct(honda_city, ParkingSpace::WITH_FIRST_AVAILABLE)
    actual = attendant.direct(honda_civic, ParkingSpace::WITH_FIRST_AVAILABLE)
    assert_equal(expected, actual)
  end

  it 'Ensures that an attendant is not directing car if there is no space' do
    p1 = ParkingSpace.new 1
    p2 = ParkingSpace.new 1

    attendant = Attendant.new(p1, p2)
    honda_city = Object.new
    honda_civic = Object.new
    honda_accord = Object.new

    attendant.direct(honda_city, ParkingSpace::WITH_FIRST_AVAILABLE)
    attendant.direct(honda_civic, ParkingSpace::WITH_FIRST_AVAILABLE)

    assert_raises(RuntimeError) do
      attendant.direct(honda_accord, ParkingSpace::WITH_FIRST_AVAILABLE)
    end
  end


  it 'attendant directs car to the parking space which has more free slots ' do
    p1 = ParkingSpace.new 1
    p2 = ParkingSpace.new 2

    attendant = Attendant.new(p1, p2)
    honda_city = Object.new
    attendant.direct(honda_city, ParkingSpace::WITH_MORE_SLOTS)
    p2_vehicles = p2.vehicles.values
    assert_includes(p2_vehicles, honda_city)
  end

  it 'attendant directs car to the parking space which has more free slots ' do
    p1 = ParkingSpace.new 10
    p2 = ParkingSpace.new 20

    attendant = Attendant.new(p1, p2)
    honda_city = Object.new
    attendant.direct(honda_city, ParkingSpace::WITH_LIMITED_SLOTS)
    p1_vehicles = p1.vehicles.values
    assert_includes(p1_vehicles, honda_city)
  end

  it 'marks full parking space as full' do
    parking_space = ParkingSpace.new 1
    attendant = Attendant.new parking_space
    honda_city = Object.new
    attendant.direct honda_city
    refute_includes(attendant.available_parkings,parking_space)
  end

  it 'updates full parking space from full to open when it becomes open' do
    parking_space = ParkingSpace.new 1
    attendant = Attendant.new parking_space
    honda_city = Object.new
    attendant.direct honda_city
    parking_space.unpark honda_city.object_id
    assert_includes(attendant.available_parkings,parking_space)
  end

  it 'ensures coordinator is notified whenever all parking spaces are full for an attendant' do
    parking_space_1 = ParkingSpace.new 1
    parking_space_2 = ParkingSpace.new 1
    attendant = Attendant.new parking_space_1,parking_space_2
    coordinator = Minitest::Mock.new
    attendant.add_observer coordinator
    coordinator.expect :update_on_space_full, attendant, [Object]
    coordinator.expect :update_on_space_full, attendant, [Object]
    honda_city = Object.new
    honda_civic = Object.new
    parking_space_1.park honda_city
    parking_space_2.park honda_civic
    
    assert coordinator.verify
  end

  it "attendant sends notification to his coordinator when he has no parkings available" do
    parking_space_1 = ParkingSpace.new 1
    parking_space_2 = ParkingSpace.new 1
    attendant = Attendant.new parking_space_1,parking_space_2
    coordinator = Coordinator.new attendant
    parking_space_1.park Object.new
    parking_space_2.park Object.new
    refute_includes(coordinator.available_attendants, attendant)
  end

  it "attendant sends notification to his coordinator when he has no parkings available" do
    parking_space_1 = ParkingSpace.new 1
    parking_space_2 = ParkingSpace.new 1
    attendant_1 = Attendant.new parking_space_1
    attendant_2 = Attendant.new parking_space_2
    coordinator = Coordinator.new attendant_1, attendant_2
    parking_space_1.park Object.new
    refute_includes(coordinator.available_attendants,attendant_1)
  end

  it "Ensures an unavailable attendant, when gets available is notified to coordinator" do
    parking_space = ParkingSpace.new 1
    attendant = Attendant.new parking_space
    coordinator = Coordinator.new attendant
    honda_city = Object.new
    parking_space.park honda_city
    parking_space.unpark honda_city.object_id
    assert_includes(coordinator.available_attendants,attendant)
  end

end
