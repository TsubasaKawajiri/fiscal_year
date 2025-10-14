# frozen_string_literal: true

module FiscalYear
  class Half
    class << self
      NORMALIZED_TWO_DIGIT_YEAR = 1999
      private_constant :NORMALIZED_TWO_DIGIT_YEAR

      # @return [Array<Integer>] the first half of the fiscal year.
      def first
        FiscalYear.halfs.first || raise(StandardError)
      end

      # @return [Array<Integer>] the second half of the fiscal year.
      def second
        FiscalYear.halfs.second || raise(StandardError)
      end

      # @param month [Integer] the month
      # @return [Boolean] true if the month is in the first half of the fiscal year.
      def first?(month)
        FiscalYear.halfs.first.include?(month)
      end

      # @param month [Integer] the month
      # @return [Boolean] true if the month is in the second half of the fiscal year.
      def second?(month)
        !first?(month)
      end

      # @param month [Integer] the month
      # @return [Array<Integer>] the half months by the month.
      def months(month)
        first?(month) ? first : second
      end

      # @param year [Integer] the calendar year
      # @return [Range<Date>] the range of the first half of the fiscal year.
      def first_range_by(year)
        year = normalize_year(year)
        range_for(first, year)
      end

      # @param year [Integer] the calendar year
      # @return [Range<Date>] the range of the second half of the fiscal year.
      def second_range_by(year)
        year = normalize_year(year)
        range_for(second, year, offset_start_year: true)
      end

      # @param date [Date] the date
      # @return [Range<Date>] the range of the half of the fiscal year by the date.
      def range_by(date)
        month = date.month
        year = date.year
        # if passed crossed year value, normalize to not crossed year value
        year = FiscalYear.decrease_year_by_month(year, month)

        first?(month) ? first_range_by(year) : second_range_by(year)
      end

      # @param half [Array<Integer>] the half of the fiscal year
      # @return [Boolean] true if the any month of half are crossed calendar year.
      def cross_year_in_half?(half)
        FiscalYear.cross_year? && half.any? { |month| month == 12 }
      end

      # start by 0.
      #
      # @see passed_month_count_by_month
      # @param date [Date] the date
      # @return [Integer] the passed month count from the beginning of the half.
      def passed_month_count_by(date)
        passed_month_count_by_month(date.month)
      end

      # start by 0.
      #
      # @see passed_month_count_by_month
      # @param date [Date] the date
      # @return [Integer] the passed month count from the beginning of the half.
      def passed_month_count_by_month(month)
        months(month).find_index(month) || raise(StandardError)
      end

      private

      # @param year [Integer]
      # @return [Integer] normalized year value for Date.parse
      def normalize_year(year)
        # care Date#parse 2 digit year auto complete.
        # 99 + 1 = 100, but expect 2000 this context.
        year == 99 ? NORMALIZED_TWO_DIGIT_YEAR : year
      end

      # @param half [Array<Integer>]
      # @return [Array<Integer>] tuple of first and last month
      def boundary_months(half)
        [half.first || raise(StandardError), half.last || raise(StandardError)]
      end

      # @param half [Array<Integer>]
      # @param year [Integer]
      # @param offset_start_year [Boolean]
      # @return [Range<Date>]
      def range_for(half, year, offset_start_year: false)
        start_month, end_month = boundary_months(half)

        start_year = offset_start_year ? FiscalYear.increase_year_by_month(year, start_month) : year
        end_year = FiscalYear.increase_year_by_month(year, end_month)

        build_range(start_year, start_month, end_year, end_month)
      end

      # @param start_year [Integer]
      # @param start_month [Integer]
      # @param end_year [Integer]
      # @param end_month [Integer]
      # @return [Range<Date>] built range between start and end month
      def build_range(start_year, start_month, end_year, end_month)
        start_date = Date.new(start_year, start_month, 1)
        end_date = Date.new(end_year, end_month, 1).end_of_month

        start_date..end_date
      end
    end
  end
end
