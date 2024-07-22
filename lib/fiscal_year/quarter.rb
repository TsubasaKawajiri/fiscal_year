# frozen_string_literal: true

module FiscalYear
  class Quarter
    class << self
      # @!method first
      # @return [Array<Integer>] the first quarter of the fiscal year.

      # @!method second
      # @return [Array<Integer>] the second quarter of the fiscal year.

      # @!method third
      # @return [Array<Integer>] the third quarter of the fiscal year.

      # @!method fourth
      # @return [Array<Integer>] the fourth quarter of the fiscal year.
      %i[first second third fourth].each do |method_name|
        define_method(method_name) do
          FiscalYear.quarters.public_send(method_name)
        end
      end

      # @param month [Integer] the month
      # @return [Boolean] true if the month is in the first quarter of the fiscal year.
      def first?(month)
        FiscalYear.quarters.first.include?(month)
      end

      # @param month [Integer] the month
      # @return [Boolean] true if the month is in the second quarter of the fiscal year.
      def second?(month)
        FiscalYear.quarters.second.include?(month)
      end

      # @param month [Integer] the month
      # @return [Boolean] true if the month is in the third quarter of the fiscal year.
      def third?(month)
        FiscalYear.quarters.third.include?(month)
      end

      # @param month [Integer] the month
      # @return [Boolean] true if the month is in the fourth quarter of the fiscal year.
      def fourth?(month)
        FiscalYear.quarters.fourth.include?(month)
      end

      # @param month [Integer] the month
      # @return [Array<Integer>] the quarter months by the month.
      def months(month)
        months = FiscalYear.quarters.find { |a| a.include?(month) }
        raise ::StandardError if months.nil?

        months
      end

      # @param date [Date] the date
      # @return [Range<Date>] the range of the quarter by the date.
      def range_by(date)
        year = date.year
        this_quarter = months(date.month)
        last_year = cross_year_in_quarter?(this_quarter) ? year + 1 : year

        Date.parse("#{year}/#{this_quarter.first}/01")..Date.parse("#{last_year}/#{this_quarter.last}/01").end_of_month
      end

      # @param month [Integer] the month
      # @return [Integer] the quarter number by the month.
      def quarter_num(month)
        rindex = FiscalYear.quarters.rindex(months(month))

        rindex.nil? ? 0 : (rindex + 1)
      end

      # @param quarter [Array<Integer>] the quarter
      # @return [Boolean] true if the quarter is crossed calendar year.
      def cross_year_in_quarter?(quarter)
        FiscalYear.cross_year? && quarter.any? { |month| month == 12 }
      end

      # start by 0.
      #
      # @param date [Date] the date
      # @return [Integer] the passed quarter count by the date.
      def passed_month_count_by(date)
        passed_month_count_by_month(date.month)
      end

      # start by 0.
      #
      # @param month [Integer] the month
      # @return [Integer] the passed quarter count by the month.
      def passed_month_count_by_month(month)
        months(month).find_index(month) || raise(StandardError)
      end
    end
  end
end
