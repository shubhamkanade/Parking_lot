# frozen_string_literal: true

class Unit

  attr_reader :type
  private

  def initialize(name, conversion_factor, type)
    @name = name
    @conversion_factor = conversion_factor
    @type = type
  end

  public

  def same_type?(other)
    type == other.type
  end

  def self.millimeter
    Unit.new 'millimeter', 1, 'length'
  end

  def self.inch
    Unit.new 'inch', 1 * 25.4, 'length'
  end

  def self.feet
    Unit.new 'feet', 1 * 304.8, 'length'
  end

  def self.meter
    Unit.new 'meter', 1 * 1000, 'length'
  end

  def self.kilogram
    Unit.new 'kilogram', 1 * 1000, 'mass'
  end
  
  def self.gram
    Unit.new 'gram', 1, 'mass'
  end

  def to_base(value)
    value * @conversion_factor
  end

  def from_base(value)
    value / @conversion_factor
  end
end
