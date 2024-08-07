# frozen_string_literal: true

module FiscalYear
  class Half
    class << self
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
        # care Date#parse 2 digit year auto complete.
        # 99 + 1 = 100, but expect 2000 this context.
        year = 1999 if year == 99
        end_month = first.last || raise(StandardError)

        end_year = FiscalYear.increase_year_by_month(year, end_month)

        Date.parse("#{year}/#{first.first}/01")..Date.parse("#{end_year}/#{end_month}/01").end_of_month
      end

      # @param year [Integer] the calendar year
      # @return [Range<Date>] the range of the second half of the fiscal year.
      def second_range_by(year)
        # care Date#parse 2 digit year auto complete.
        # 99 + 1 = 100, but expect 2000 this context.
        year = 1999 if year == 99
        first_month = second.first || raise(StandardError)
        end_month = second.last || raise(StandardError)

        start_year = FiscalYear.increase_year_by_month(year, first_month)
        end_year = FiscalYear.increase_year_by_month(year, end_month)

        Date.parse("#{start_year}/#{first_month}/01")..Date.parse("#{end_year}/#{end_month}/01").end_of_month
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
    end
  end
end
