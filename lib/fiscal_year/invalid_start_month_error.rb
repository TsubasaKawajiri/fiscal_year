# frozen_string_literal: true

module FiscalYear
  class InvalidStartMonthError < StandardError
    def message
      "Invalid start month. please set 1-12 or :jan, :feb, :mar, :apr, :may, :jun, :jul, :aug, :sep, :oct, :nov, :dec."
    end
  end
end
