# frozen_string_literal: true

module FiscalYear
  class Half
    class << self
      def first
        FiscalYear.halfs.first
      end

      def second
        FiscalYear.halfs.second
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
        end_year = FiscalYear.normalize_year_by_month(year, first.last)

        Date.parse("#{year}/#{first.first}/01")..Date.parse("#{end_year}/#{first.last}/01").end_of_month
      end

      def second_range_by(year)
        # care Date#parse 2 digit year auto complete.
        # 99 + 1 = 100, but expect 2000 this context.
        year = 1999 if year == 99
        start_year = FiscalYear.normalize_year_by_month(year, second.first)
        end_year = FiscalYear.normalize_year_by_month(year, second.last)

        Date.parse("#{start_year}/#{second.first}/01")..Date.parse("#{end_year}/#{second.last}/01").end_of_month
      end

      def range_by(date)
        month = date.month
        year = date.year
        # if passed crossed year value, normalize to not crossed year value
        year -= 1 if FiscalYear.cross_year_month?(month)

        first?(month) ? first_range_by(year) : second_range_by(year)
      end
    end
  end
end
