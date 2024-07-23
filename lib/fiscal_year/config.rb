# frozen_string_literal: true

require "fiscal_year/invalid_start_month_error"

module FiscalYear
  class Config
    attr_reader :start_month

    VALID_START_MONTHS = {
      jan: 1,
      feb: 2,
      mar: 3,
      apr: 4,
      may: 5,
      jun: 6,
      jul: 7,
      aug: 8,
      sep: 9,
      oct: 10,
      nov: 11,
      dec: 12
    }.freeze

    def initialize
      @start_month = 4
    end

    def set_start_month(month)
      valid_start_month?(month)

      @start_month = fetch_start_month(month)

      true
    end

    private

    def valid_start_month?(month)
      if month.is_a? Integer
        VALID_START_MONTHS.values.include?(month)
      else
        VALID_START_MONTHS.keys.include?(month)
      end || raise(InvalidStartMonthError)
    end

    def fetch_start_month(month)
      if month.is_a? Integer
        VALID_START_MONTHS.rassoc(month)&.last
      else
        VALID_START_MONTHS.assoc(month)&.last
      end || raise(StandardError)
    end
  end
end
