module FiscalYear
  class Config
    attr_accessor :start_month

    def initialize
      @start_month = 4
    end
  end
end
