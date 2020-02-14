# frozen_string_literal: true

require_relative 'unit'

class Measurement
  attr_accessor :quantity
  attr_reader :unit
  
  def initialize(quantity, unit)
    @unit = unit
    @quantity = quantity
  end

  def self.sum(measurements, expected_unit = nil )
    result_unit = expected_unit.nil? ? measurements[0].unit : expected_unit
    value = measurements.reduce(0) { |sum, measurement| sum + measurement.send('base_unit_value') }
    result_value = result_unit.from_base(value)
    Measurement.new(result_value, result_unit)
  end

  def ==(other)
    unless self.unit.same_type? other.unit
       raise "Incompatible Units!"
    end
    self.send('base_unit_value') == other.send('base_unit_value')
  end

  def -(other)
    self.send('base_unit_value') - other.send('base_unit_value')
  end

  def greater?(other)
    self.send('base_unit_value') > other.send('base_unit_value')
  end

  private
  def base_unit_value
    unit.to_base(quantity)
  end

 
end
