# frozen_string_literal: true

module FiscalYear
  class YearToDate
    class << self
      def range_by(date)
        year = date.year
        month = date.month

        if FiscalYear.cross_year_month?(month)
          Date.parse("#{year - 1}/#{FiscalYear.config.start_month}/01")..date.end_of_month.to_date
        else
          Date.parse("#{year}/#{FiscalYear.config.start_month}/01")..date.end_of_month.to_date
        end
      end

      def year_month_pairs(date)
        month = date.month
        month_index = FiscalYear.months.index(month)
        months = FiscalYear.months[(0..month_index)]
        raise StandardError if months.nil?

        [date.year].product(months).map do |e|
          [FiscalYear.decrease_year_by_month(e.first, e.second), e.second]
        end
      end

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
