# frozen_string_literal: true

RSpec.describe FiscalYear do
  before(:each) { FiscalYear.class_variable_set :@@config, FiscalYear::Config.new }

  it "has a version number" do
    expect(FiscalYear::VERSION).not_to be nil
  end

  describe "config" do
    it "can access?" do
      expect(FiscalYear.config.class).to eq FiscalYear::Config
    end

    it "can change value?" do
      FiscalYear.configure do |config|
        config.start_month = 6
      end

      expect(FiscalYear.config.start_month).to eq 6
    end
  end

  describe "#cross_year_month?" do
    describe "start at Apr" do
      it "Mar is cross" do
        expect(FiscalYear.cross_year_month?(3)).to be true
      end

      it "May is not cross" do
        expect(FiscalYear.cross_year_month?(5)).to be false
      end
    end

    describe "start at June" do
      it "May is cross" do
        FiscalYear.configure do |config|
          config.start_month = 6
        end

        expect(FiscalYear.cross_year_month?(5)).to be true
      end

      it "July is not cross" do
        FiscalYear.configure do |config|
          config.start_month = 6
        end

        expect(FiscalYear.cross_year_month?(7)).to be false
      end
    end
  end

  describe "#cross_year?" do
    it "start at Apr" do
      expect(FiscalYear.cross_year?).to be true
    end

    it "Start at Jan" do
      FiscalYear.configure do |config|
        config.start_month = 1
      end

      expect(FiscalYear.cross_year?).to be false
    end
  end
end
