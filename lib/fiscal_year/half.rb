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
        Date.parse("#{year}/#{first.first}")..Date.parse("#{year}/#{first.last}").end_of_month
      end

      def second_range_by(year)
        Date.parse("#{year}/#{second.first}")..Date.parse("#{year + 1}/#{second.last}").end_of_month
      end

      def range_by(date)
        month = date.month
        year = date.year
        if FiscalYear.cross_year_month?(month)
          Date.parse("#{year - 1}/#{second.first}")..Date.parse("#{year}/#{second.last}").end_of_month
        else
          first?(month) ? first_range_by(date.year) : second_range_by(date.year)
        end
      end
    end
  end
end
