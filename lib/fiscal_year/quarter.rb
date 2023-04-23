# frozen_string_literal: true

module FiscalYear
  class Quarter
    class << self
      %i[first second third fourth].each do |method_name|
        define_method(method_name) do
          FiscalYear::quarters.public_send(method_name)
        end
      end

      def first?(month)
        FiscalYear::quarters.first.include?(month)
      end

      def second?(month)
        FiscalYear::quarters.second.include?(month)
      end

      def third?(month)
        FiscalYear::quarters.third.include?(month)
      end

      def fourth?(month)
        FiscalYear::quarters.fourth.include?(month)
      end

      def months(month)
        months = FiscalYear::quarters.find { |a| a.include?(month) }
        raise ::StandardError if months.nil?

        months
      end

      def range_by(date)
        year = date.year
        this_quater = months(date.month)
        last_year = cross_year_in_quarter?(this_quater) ? year + 1 : year

        Date.parse("#{year}/#{this_quater.first}/01")..Date.parse("#{last_year}/#{this_quater.last}/01").end_of_month
      end

      def quater_num(month)
        rindex = FiscalYear::quarters.rindex(months(month))

        rindex.nil? ? 0 : (rindex + 1)
      end

      def cross_year_in_quarter?(quarter)
        FiscalYear::cross_year? && quarter.any? { |month| month == 12 }
      end
    end
  end
end
