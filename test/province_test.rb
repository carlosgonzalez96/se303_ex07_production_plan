gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/province'
require_relative '../lib/data'

class ProvinceTest < Minitest::Test

  def test_province_shortfall
    asia = Province.new(sample_province_data)
    assert_equal(5, asia.shortfall)
  end

  describe "Province method tests" do
    asia = nil
    before(:each) do
      asia = Province.new(sample_province_data)
    end

    it 'tests province shortfall' do
      (asia.shortfall).must_equal 5
    end

    it 'tests profit' do
      (asia.profit).must_equal 230
    end

    it 'tests change production' do
      asia.producers[0].production = 20
      (asia.shortfall).must_equal -6
      (asia.profit).must_equal 292
    end
  end
end
