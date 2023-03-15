# frozen_string_literal: true

require_relative "fiscal_year/version"

require "fiscal_year/half"
require "fiscal_year/quarter"
require "fiscal_year/year_to_date"
require "fiscal_year/config"

require "active_support"
require "active_support/core_ext"

module FiscalYear
  @@config ||= FiscalYear::Config.new
  class << self
    def config
      @@config
    end

    def configure
      yield(@@config) if block_given?
    end

    def cross_year_month?(month)
      cross_year_months.include?(month)
    end

    def cross_year?
      months.rindex(1) != 0
    end

    def months
      (1..12).to_a.tap { |arr| arr.concat(arr.shift(@@config.start_month - 1)) }
    end

    def cross_year_months
      months.slice(months.rindex(1), months.length)
    end

    def halfs
      months.in_groups(2)
    end

    def quarters
      months.in_groups(4)
    end
  end
end
