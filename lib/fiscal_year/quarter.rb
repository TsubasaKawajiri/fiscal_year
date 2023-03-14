# frozen_string_literal: true

module FiscalYear
  class Quarter
    class << self
      %i[first second third fourth].each do |method_name|
        define_method(method_name) do
          FiscalYear.quarters.public_send(method_name)
        end
      end

      def first?(month)
        FiscalYear.quarters.first.include?(month)
      end

      def second?(month)
        FiscalYear.quarters.second.include?(month)
      end

      def third?(month)
        FiscalYear.quarters.third.include?(month)
      end

      def fourth?(month)
        FiscalYear.quarters.fourth.include?(month)
      end

      def months(month)
        FiscalYear.quarters.find { |a| a.include?(month) }
      end

      def range_by(date)
        year = date.year
        this_quater_months = months(date.month)

        Date.parse("#{year}/#{this_quater_months.first}")..Date.parse("#{year}/#{this_quater_months.last}").end_of_month
      end

      def quater_num(month)
        (FiscalYear.quarters.rindex(months(month)) + 1)
      end
    end
  end
end
