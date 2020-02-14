# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'measurement'
require_relative 'unit'

describe Measurement do
  system 'clear'

  _inch = Unit.inch
  _meter = Unit.meter
  _feet = Unit.feet
  _millimeter = Unit.millimeter
  _kilogram = Unit.kilogram
  _gram = Unit.gram

  it 'measures the sale when a garment being sold measures 100 inches' do
    garment = Measurement.new 100, _inch
    total_sales = garment.quantity
    expect(total_sales).must_equal 100
  end

  it 'measures the sale when a garment being sold measures 700 inches' do
    garment = Measurement.new 700, _inch
    total_sales = garment.quantity
    expect(total_sales).must_equal 700
  end

  it 'ensures the sale of 2 meters of garment when sold in inches' do
    actual = Measurement.new 79, _inch
    expected = Measurement.new 2, _meter

    assert_in_delta(expected, actual, 7)
  end

  it 'ensures the sale of 3 meters of garment when sold in inches' do
    actual = Measurement.new 118, _inch
    expected = Measurement.new 3, _meter

    assert_in_delta(expected, actual, 5)
  end

  it 'ensures the sale of 26 millimeters of garment when sold in inches' do
    actual = Measurement.new 1, _inch
    expected = Measurement.new 26, _millimeter

    assert_in_delta(expected, actual, 1)
  end

  it 'ensures the sale of 51 millimeters of garment when sold in inches' do
    actual = Measurement.new 2, _inch
    expected = Measurement.new 51, _millimeter

    assert_in_delta(expected, actual, 1)
  end

  it 'measures the sale of 20 feets of garment when sold in inches' do
    actual = Measurement.new 240, _inch
    expected = Measurement.new 20, _feet

    expect(actual).must_equal expected
  end

  it 'measures the sale of 40 feets of garment when sold in inches' do
    actual = Measurement.new 480, _inch
    expected = Measurement.new 40, _feet

    expect(actual).must_equal expected
  end

  it 'measures the sale when a garment being sold measures 100 feets' do
    actual = Measurement.new 100, _feet
    expected = Measurement.new 100, _feet

    expect(actual).must_equal expected
  end

  it 'measures the sale when a garment being selled measures 200 feets' do
    actual = Measurement.new 200, _feet
    expected = Measurement.new 2400, _inch

    expect(actual).must_equal expected
  end

  it 'ensures the sale of 4800 inches of garment when sold in feet' do
    actual = Measurement.new 400, _feet
    expected = Measurement.new 4800, _inch

    expect(actual).must_equal expected
  end

  it 'ensures the sale of 304 millimeter of garment when sold in feet' do
    actual = Measurement.new 1, _feet
    expected = Measurement.new 304, _millimeter

    assert_in_delta(expected, actual, 5)
  end

  it 'ensures the sale of 609 millimeter of garment when sold in feet' do
    actual = Measurement.new 2, _feet
    expected = Measurement.new 609, _millimeter
    assert_in_delta(expected, actual, 5)
  end

  it 'ensures the sale of 1 meters of garment when sold in feet' do
    actual = Measurement.new 3.28, _feet
    expected = Measurement.new 1, _meter

    assert_in_delta(expected, actual, 5)
  end

  it 'ensures the sale of 2 meters of garment when sold in feet' do
    actual = Measurement.new 6.56, _feet
    expected = Measurement.new 2, _meter

    assert_in_delta(expected, actual, 1)
  end

  it 'measures the sale when a garment was sold in meters' do
    actual = Measurement.new 240, _meter
    expected = Measurement.new 240, _meter

    expect(actual).must_equal expected
  end

  it 'ensures the sale of garment in meters' do
    actual = Measurement.new 180, _meter
    expected = Measurement.new 180, _meter

    expect(actual).must_equal expected
  end

  it 'ensures the sale of garment in 3.28 feet when sold in meters' do
    actual = Measurement.new 1, _meter
    expected = Measurement.new 3.28, _feet

    assert_in_delta(expected, actual, 1)
  end

  it 'ensures the sale of garment in 6.56 feet when sold in meters' do
    actual = Measurement.new 2, _meter
    expected = Measurement.new 6.56, _feet

    assert_in_delta(expected, actual, 1)
  end

  it 'ensures the sale of garment in 39.3inch when sold in meters' do
    actual = Measurement.new 1, _meter
    expected = Measurement.new 39.3, _inch

    assert_in_delta(expected, actual, 5)
  end

  it 'ensures the sale of garment in 79inch when sold in meters' do
    actual = Measurement.new 2, _meter
    expected = Measurement.new 79, _inch

    assert_in_delta(expected, actual, 7)
  end

  it 'ensures the sale of  1000 millimeter of garment when sold in meters' do
    actual = Measurement.new 1, _meter
    expected = Measurement.new 1000, _millimeter

    expect(actual).must_equal expected
  end

  it 'ensures the sale of  2000 millimeter of garment when sold in meters' do
    actual = Measurement.new 2, _meter
    expected = Measurement.new 2000, _millimeter

    expect(actual).must_equal expected
  end

  it 'ensures the sale of  1 feet of garment when sold in millimeter' do
    actual = Measurement.new 304, _millimeter
    expected = Measurement.new 1, _feet

    assert_in_delta(expected, actual, 1)
  end
  it 'ensures the sale of 2 feet of garment when sold in millimeter' do
    actual = Measurement.new 609, _millimeter
    expected = Measurement.new 2, _feet

    assert_in_delta(expected, actual, 1)
  end

  it 'ensures the sale of  1 inch of garment when sold in millimeter' do
    actual = Measurement.new 26,  _millimeter
    expected = Measurement.new 1, _inch

    assert_in_delta(expected, actual, 5)
  end

  it 'ensures the sale of  2 inch of garment when sold in millimeter' do
    actual = Measurement.new 50,  _millimeter
    expected = Measurement.new 2, _inch
    assert_in_delta(expected, actual, 5)
  end
  it 'ensures the sale of 180 millimeters of garment when sold in millimeter' do
    actual = Measurement.new 180, _millimeter
    expected = Measurement.new 180, _millimeter

    expect(actual).must_equal expected
  end

  it 'ensures the sale of 1000 millimeter of garment when sold in millimeter' do
    actual = Measurement.new 1000, _millimeter
    expected = Measurement.new 1000, _millimeter

    expect(actual).must_equal expected
  end

  it 'ensures the sale of 1 meters of garment when sold in millimeter' do
    actual = Measurement.new 1000, _millimeter
    expected = Measurement.new 1, _meter

    expect(actual).must_equal expected
  end

  it 'ensures the sale of 2 meters of garment when sold in millimeter' do
    actual = Measurement.new 2000, _millimeter
    expected = Measurement.new 2, _meter

    expect(actual).must_equal expected
  end

  it 'ensures sum of 1000inches & 2000inches equals 3000inches' do
    garment1 = Measurement.new 1000, _inch
    garment2 = Measurement.new 2000, _inch
    data = [garment1, garment2]
    expected_total = Measurement.new 3000, _inch

    total_sales = Measurement.sum(data)

    expect(total_sales).must_equal expected_total
  end

  it 'ensures sum of 120inches & 80inches equals 200inches' do
    garment1 = Measurement.new 120, _inch
    garment2 = Measurement.new 80, _inch
    data = [garment1, garment2]
    expected_total = Measurement.new 200, _inch

    total_sales = Measurement.sum(data)

    expect(total_sales).must_equal expected_total
  end

  it 'ensures sum of 110feet & 80feet equals 190feet' do
    garment1 = Measurement.new 110, _feet
    garment2 = Measurement.new 80, _feet
    data = [garment1, garment2]
    expected_total = Measurement.new 190, _feet

    total_sales = Measurement.sum(data)

    expect(total_sales).must_equal expected_total
  end

  it 'ensures sum of 300feet & 90feet equals 390feet' do
    garment1 = Measurement.new 300, _feet
    garment2 = Measurement.new 90, _feet
    data = [garment1, garment2]
    expected_total = Measurement.new 390, _feet

    total_sales = Measurement.sum(data)

    expect(total_sales).must_equal expected_total
  end

  it 'ensures sum of 12inch & 2feet equals 3feet' do
    garment1 = Measurement.new 12, _inch
    garment2 = Measurement.new 2, _feet
    data = [garment1, garment2]
    expected_total = Measurement.new 3, _feet

    total_sales = Measurement.sum(data, _feet)

    expect(total_sales).must_equal expected_total
  end

  it 'ensures 300inches is not greater than 90feet' do
    _300inches = Measurement.new 300, _inch
    _90feet = Measurement.new 90, _feet
    actual = _300inches.greater?(_90feet)
    refute_nil(actual)
    refute(actual)
  end

  it 'compares 24inches & 1feet in inches to give the greater quantity ' do
    _24inches = Measurement.new 24, _inch
    _1feet = Measurement.new 1, _feet
    actual = _24inches.greater?(_1feet)
    refute_nil(actual)
    assert(actual)
  end

  it 'ensures sale of 3kg sugar' do
    actual = Measurement.new 3, _kilogram
    expected = Measurement.new 3, _kilogram
    expect(actual).must_equal expected
  end

  it 'ensures sum of sale of 3kg sugar and 4kg sugar equals 7kg' do
    _3kg = Measurement.new 3, _kilogram
    _4kg = Measurement.new 4, _kilogram
    measurements = [_3kg,_4kg]

    actual = Measurement.sum measurements
    expected = Measurement.new 7, _kilogram
    expect(actual).must_equal expected
  end

  it 'ensures 300kg is greater than 90kg' do
    _300kg = Measurement.new 300, _kilogram
    _90kg = Measurement.new 90, _kilogram
    actual = _300kg.greater?_90kg
    assert(actual)
  end

  it 'ensures sale of 500g sugar' do
    actual = Measurement.new 500, _gram
    expected = Measurement.new 500, _gram
    expect(actual).must_equal expected
  end

  it 'ensures 1kg equals 1000g' do
    _1kg = Measurement.new 1, _kilogram
    _1000g = Measurement.new 1000, _gram
    expect(_1kg).must_equal _1000g
  end

  it 'ensures incompatible units raise exception while comparing with eachother' do
    _1g = Measurement.new 1, _gram
    _1m = Measurement.new 1, _meter
    assert_raises(RuntimeError) {   
    expect(_1g).must_equal _1m
    }
  end


end

