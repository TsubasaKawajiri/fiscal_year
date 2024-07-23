# frozen_string_literal: true

module FiscalYear
  class YearToDate
    class << self
      # @param date [Date] the date
      # @return [Range<Date>] the range of the year to date.
      # @example
      #  FiscalYear::YearToDate.range_by(Date.parse("2021-08-01"))
      #  => Thu, 01 Apr 2021..Tue, 31 Aug 2021
      #
      #  FiscalYear::YearToDate.range_by(Date.parse("2021-01-01"))
      #  =>  Wed, 01 Apr 2020..Sun, 31 Jan 2021
      def range_by(date)
        year = date.year
        month = date.month

        if FiscalYear.cross_year_month?(month)
          Date.parse("#{year - 1}/#{FiscalYear.config.start_month}/01")..date.end_of_month.to_date
        else
          Date.parse("#{year}/#{FiscalYear.config.start_month}/01")..date.end_of_month.to_date
        end
      end

      # @param date [Date] the date
      # @return [Array<Array<Integer>, Array<Integer>>] the passed year and month pairs.
      # @example
      #  FiscalYear::YearToDate.year_month_pairs(Date.parse("2021-08-01"))
      #  => [[2021, 4], [2021, 5], [2021, 6], [2021, 7], [2021, 8]]
      #
      #  FiscalYear::YearToDate.year_month_pairs(Date.parse("2021-01-01"))
      #  => [
      #       [2020, 4], [2020, 5], [2020, 6], [2020, 7], [2020, 8], [2020, 9],
      #       [2020, 10], [2020, 11], [2020, 12], [2021, 1]
      #     ]
      def year_month_pairs(date)
        month = date.month
        month_index = FiscalYear.months.index(month)
        months = FiscalYear.months[(0..month_index)]
        raise StandardError if months.nil?

        [date.year].product(months).map do |e|
          [FiscalYear.decrease_year_by_month(e.first, e.second), e.second]
        end
      end

      # @param date [Date] the date
      # @return [Range<Date>] the range of the half year to date.
      # @example
      #  FiscalYear::YearToDate.half_range_by(Date.parse("2021-08-01"))
      #  => Thu, 01 Apr 2021..Tue, 31 Aug 2021
      #
      #  FiscalYear::YearToDate.half_range_by(Date.parse("2021-01-01"))
      #  =>  Thu, 01 Oct 2020..Sun, 31 Jan 2021
      def half_range_by(date)
        year = date.year
        month = date.month

        beginning_year =
          if Half.first?(month)
            FiscalYear.cross_year_month?(month) ? year - 1 : year
          else
            Half.cross_year_in_half?(Half.second) ? FiscalYear.decrease_year_by_month(year, month) : year
          end

        half_method = Half.first?(month) ? :first : :second

        Date.parse("#{beginning_year}/#{Half.public_send(half_method).first}/01")..date.end_of_month.to_date
      end

      # @param date [Date] the date
      # @return [Range<Date>] the range of the quarter to date.
      # @example
      #  FiscalYear::YearToDate.quarter_range_by(Date.parse("2021-08-01"))
      #  => Thu, 01 Jul 2021..Tue, 31 Aug 2021
      #
      #  FiscalYear::YearToDate.quarter_range_by(Date.parse("2021-01-01"))
      #  =>  Fri, 01 Jan 2021..Sun, 31 Jan 2021
      def quarter_range_by(date)
        year = date.year
        month = date.month

        quarter_method = %i[first? second? third? fourth?]
                         .filter { |method_name| FiscalYear::Quarter.public_send(method_name, month) }
                         .first.to_s.gsub("?", "").to_sym

        quarter = Quarter.public_send(quarter_method)

        beginning_year =
          Quarter.cross_year_in_quarter?(quarter) ? FiscalYear.decrease_year_by_month(year, month) : year

        Date.parse("#{beginning_year}/#{quarter.first}/01")..date.end_of_month.to_date
      end
    end
  end
end
