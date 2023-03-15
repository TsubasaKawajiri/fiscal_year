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

      # TODO: fit to Abc size
      def half_range_by(date) # rubocop:disable Metrics/AbcSize
        year = date.year
        month = date.month

        if Half.first?(month)
          return (Date.parse("#{FiscalYear.cross_year_month?(month) ? year - 1 : year}/#{Half.first.first}/01")..
            date.end_of_month.to_date
                 )
        end

        Date.parse(
          "#{FiscalYear::Half.cross_year_in_half?(Half.second) ? year - 1 : year}/#{Half.second.first}"
        )..date.end_of_month.to_date
      end

      def quarter_range_by(date)
        year = date.year
        month = date.month

        quarter_method = %i[first? second? third? fourth?]
                         .filter { |method_name| FiscalYear::Quarter.public_send(method_name, month) }
                         .first.to_s.gsub("?", "").to_sym

        quarter = Quarter.public_send(quarter_method)

        (
          Date.parse("#{FiscalYear.cross_year_month?(month) ? year - 1 : year}/#{quarter.first}/01")..
          date.end_of_month.to_date
        )
      end
    end
  end
end
