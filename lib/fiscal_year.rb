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
    attr_reader :config

    def configure
      yield(@config) if block_given?
    end

    def cross_year_month?(month)
      cross_year_months.include?(month)
    end

    def cross_year?
      months.rindex(1) != 0
    end

    def months
      (1..12).to_a.tap { |arr| arr.concat(arr.shift(@config.start_month - 1)) }
    end

    def cross_year_months
      return [] if @config.start_month == 1

      rindex = months.rindex(1).to_i

      m = months.slice(rindex, months.length)
      raise StandardError if m.nil?

      m
    end

    def halfs
      # @type self: singleton(FiscalYear)
      months.in_groups(2)
    end

    def quarters
      # @type self: singleton(FiscalYear)
      months.in_groups(4)
    end
  end
end
