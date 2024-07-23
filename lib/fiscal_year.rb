# frozen_string_literal: true

require_relative "fiscal_year/version"

require "fiscal_year/half"
require "fiscal_year/quarter"
require "fiscal_year/year_to_date"
require "fiscal_year/config"

require "active_support"
require "active_support/core_ext"

module FiscalYear
  # @type ivar @config: FiscalYear::Config
  @config ||= FiscalYear::Config.new
  class << self
    # @return [FiscalYear::Config]
    attr_reader :config

    # configure start month of fiscal year.
    #
    # @yieldparam config [FiscalYear::Config]
    # @example
    #  FiscalYear.configure do |config|
    #    config.set_start_month 6
    #  end
    def configure
      yield(@config) if block_given?
    end

    # If the fiscal year start from 4, the month 1, 2, 3 are crossed year.
    #
    # @param month [Integer] the month to check, 1-12.
    # @return [Boolean] true if the month is crossed year on calendar year.
    # Determines if the month passed is beyond the year, By relative to the beginning month of the fiscal year.
    def cross_year_month?(month)
      cross_year_months.include?(month)
    end

    # @return [Boolean] true if the fiscal year is crossed year.
    def cross_year?
      months.rindex(1) != 0
    end

    # @return [Array<Integer>] the months of the fiscal year.
    def months
      (1..12).to_a.tap { |arr| arr.concat(arr.shift(@config.start_month - 1)) }
    end

    # @return [Array<Integer>] the months of the crossed year.
    def cross_year_months
      return [] if @config.start_month == 1

      rindex = months.rindex(1).to_i

      m = months.slice(rindex, months.length)
      raise StandardError if m.nil?

      m
    end

    # @return [Array(Array<Integer>, Array<Integer>)] the first half and the second half of the fiscal year.
    def halfs
      # @type self: singleton(FiscalYear)
      months.in_groups(2)
    end

    # @return [Array(Array<Integer>, Array<Integer>, Array<Integer>, Array<Integer>)] the quarters of the fiscal year.
    def quarters
      # @type self: singleton(FiscalYear)
      months.in_groups(4)
    end

    # increate the calendar year by month, if the month is crossed year.
    #
    # for example, in case of the fiscal year start from 4, you want to obtain calendar year of the month 1, 2, 3.
    #
    # @param year [Integer] the calendar year
    # @param month [Integer] the month
    # @return [Integer] year
    def increase_year_by_month(year, month)
      if FiscalYear.cross_year_month?(month)
        year + 1
      else
        year
      end
    end

    # decrease the calendar year by month, if the month is crossed year.
    #
    # for example, in case of the fiscal year start from 4, you want to obtain fiscal year from the month 1, 2, 3.
    #
    # @param year [Integer] the calendar year
    # @param month [Integer] the month
    # @return [Integer] year
    def decrease_year_by_month(year, month)
      if FiscalYear.cross_year_month?(month)
        year - 1
      else
        year
      end
    end

    # @param date [Date] the date
    # @return [Range<Date>] the range of the fiscal year between beginning and end by the date.
    def range_by(date)
      year = date.year
      month = date.month
      normalized_year = decrease_year_by_month(year, month)

      FiscalYear::Half.first_range_by(normalized_year).first..FiscalYear::Half.second_range_by(normalized_year).last
    end

    # start by 0.
    #
    # @see passed_month_count_by_month
    # @param date [Date] the date
    # @return [Integer] the passed month count from the beginning of the fiscal year.
    def passed_month_count_by(date)
      passed_month_count_by_month(date.month)
    end

    # start by 0.
    #
    # @param month [Integer] the month
    # @return [Integer] the passed month count from the beginning of the fiscal year.
    def passed_month_count_by_month(month)
      months.find_index(month) || raise(StandardError)
    end
  end
end
