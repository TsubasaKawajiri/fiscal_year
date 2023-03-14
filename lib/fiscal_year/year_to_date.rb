# frozen_string_literal: true

module FiscalYear
  class YearToDate
    class << self
      def range_by(date)
        year = date.year
        month = date.month

        if FiscalYear.cross_year_month?(month)
          Date.parse("#{year - 1}/#{FiscalYear.config.start_month}")..date.end_of_month.to_date
        else
          Date.parse("#{year}/#{FiscalYear.config.start_month}")..date.end_of_month.to_date
        end
      end

      def year_month_pairs(date)
        month = date.month

        pair = []
        [date.year].product(FiscalYear.months.slice(0..FiscalYear.months.index(month))) do |e|
          pair << if FiscalYear.cross_year_month?(month)
                    (FiscalYear.cross_year_month?(e.second) ? e : [e.first - 1, e.second])
                  else
                    e
                  end
        end

        pair
      end

      def half_range_by(date)
        year = date.year
        month = date.month

        return Date.parse("#{year}/#{Half.first.first}")..date.end_of_month.to_date if Half.first?(month)

        Date.parse("#{FiscalYear.cross_year_month?(month) ? year - 1 : year}/#{Half.second.first}")..date.end_of_month.to_date
      end

      def quarter_range_by(date)
        year = date.year
        month = date.month

        %i[first? second? third? fourth?].each do |method_name|
          if FiscalYear::Quarter.public_send(method_name, month)
            Date.parse("#{year}/#{Quarter.public_send(method_name).first}")..date.end_of_month.to_date
          end
        end
      end
    end
  end
end
