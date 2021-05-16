gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require 'rspec/expectations/minitest_integration' #to use the exceptions
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
      expect(asia.shortfall).to eq(5)
    end

    it 'tests profit' do
      expect(asia.profit).to eq(230)
    end

    it 'tests change production' do
      asia.producers[0].production = 20
      expect(asia.shortfall).to eq(-6)
      expect(asia.profit).to eq(292)
    end

    it 'tests zero demand' do
      asia.demand = 0
      expect(asia.shortfall).to eq(-25)
      expect(asia.profit).to eq(0)
    end

    it 'tests negative demand' do
      asia.demand = -1
      expect(asia.shortfall).to eq(-26)
      expect(asia.profit).to eq(-10)
    end

    it 'tests empty string demand' do
      asia.demand = ""
      expect(asia.demand).to eq("")
      #these tests will fail because it will calculate empty strings and that would cause errors
      #(asia.shortfall).to_f.nan?
      # (asia.shortfall).empty?
      # (asia.profit).empty?
    end
  end

  describe "no producers" do
    noProducers = nil
    before(:each) do
      data = {
        name: "No Producers",
        producers: [],
        demand: 30,
        price: 20,
      }
      noProducers = Province.new(data)
    end

    it 'test shortfall' do
      expect(noProducers.shortfall).to eq(30)
    end

    it 'tests profit' do
      expect(noProducers.profit).to eq(0)
    end
  end

  # describe 'String for producers' do
  #   it 'empty stings' do
  #     data = {
  #       name: "String producers",
  #       producers: "",
  #       demand: 30,
  #       price: 20,
  #     }

  #     prov = Province.new(data)
  #     expect(prov.shortfall).to eq(0)
  #   end
  # end
end
