# frozen_string_literal: true

module FiscalYear
  class Half
    class << self
      def first
        first = FiscalYear.halfs.first
        return first if first.is_a? Array

        []
      end

      def second
        second = FiscalYear.halfs.second
        return second if second.is_a? Array

        []
      end

      def first?(month)
        FiscalYear.halfs.first.include?(month)
      end

      def second?(month)
        !first?(month)
      end

      def first_range_by(year)
        # care Date#parse 2 digit year auto complete.
        # 99 + 1 = 100, but expect 2000 this context.
        year = 1999 if year == 99
        end_month = first.last
        raise StandardError if end_month.nil?

        end_year = increase_year_by_month(year, end_month)

        Date.parse("#{year}/#{first.first}/01")..Date.parse("#{end_year}/#{end_month}/01").end_of_month
      end

      def second_range_by(year)
        # care Date#parse 2 digit year auto complete.
        # 99 + 1 = 100, but expect 2000 this context.
        year = 1999 if year == 99
        first_month = second.first
        end_month = second.last
        raise StandardError if first_month.nil? || end_month.nil?

        start_year = increase_year_by_month(year, first_month)
        end_year = increase_year_by_month(year, end_month)

        Date.parse("#{start_year}/#{first_month}/01")..Date.parse("#{end_year}/#{end_month}/01").end_of_month
      end

      def range_by(date)
        month = date.month
        year = date.year
        # if passed crossed year value, normalize to not crossed year value
        year = decrease_year_by_month(year, month)

        first?(month) ? first_range_by(year) : second_range_by(year)
      end

      def increase_year_by_month(year, month)
        if FiscalYear.cross_year_month?(month)
          year + 1
        else
          year
        end
      end

      def decrease_year_by_month(year, month)
        if FiscalYear.cross_year_month?(month)
          year - 1
        else
          year
        end
      end

      def cross_year_in_half?(half)
        FiscalYear.cross_year? && half.any? { |month| month == 12 }
      end
    end
  end
end
