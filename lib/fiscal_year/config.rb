# frozen_string_literal: true

module FiscalYear
  class Config
    attr_accessor :start_month

    def initialize
      @start_month = 4

      self
    end
  end
end
