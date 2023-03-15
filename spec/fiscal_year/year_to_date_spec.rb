# frozen_string_literal: true

RSpec.describe FiscalYear::YearToDate do
  before(:each) { FiscalYear.instance_variable_set :@config, FiscalYear::Config.new }
  describe "#range_by" do
    it "Rangeを返す" do
      expect(FiscalYear::YearToDate.range_by(Date.parse("2000/01/01")).class).to be Range
    end

    it "Range始端がDateである" do
      expect(FiscalYear::YearToDate.range_by(Date.parse("2000/01/01")).first.class).to be Date
    end

    it "Range終端がDateである" do
      expect(FiscalYear::YearToDate.range_by(Date.parse("2000/01/01")).last.class).to be Date
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年4月のとき" do
        let(:range) { FiscalYear::YearToDate.range_by(Date.parse("2000/04/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は4月である" do
          expect(range.last.month).to be 4
        end
      end

      context "2000年6月のとき" do
        let(:range) { FiscalYear::YearToDate.range_by(Date.parse("2000/06/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は6月である" do
          expect(range.last.month).to be 6
        end
      end

      context "2001年1月のとき" do
        let(:range) { FiscalYear::YearToDate.range_by(Date.parse("2001/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は1月である" do
          expect(range.last.month).to be 1
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年12月のとき" do
        let(:range) { FiscalYear::YearToDate.range_by(Date.parse("2000/12/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end

      context "2001年6月のとき" do
        let(:range) { FiscalYear::YearToDate.range_by(Date.parse("2001/06/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は6月である" do
          expect(range.last.month).to be 6
        end
      end

      context "2001年1月のとき" do
        let(:range) { FiscalYear::YearToDate.range_by(Date.parse("2001/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は1月である" do
          expect(range.last.month).to be 1
        end
      end
    end
  end

  describe "#half_range_by" do
    it "Rangeを返す" do
      expect(FiscalYear::YearToDate.half_range_by(Date.parse("2000/01/01")).class).to be Range
    end

    it "Range始端がDateである" do
      expect(FiscalYear::YearToDate.half_range_by(Date.parse("2000/01/01")).first.class).to be Date
    end

    it "Range終端がDateである" do
      expect(FiscalYear::YearToDate.half_range_by(Date.parse("2000/01/01")).last.class).to be Date
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年4月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2000/04/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は4月である" do
          expect(range.last.month).to be 4
        end
      end

      context "2000年6月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2000/06/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は6月である" do
          expect(range.last.month).to be 6
        end
      end

      context "2001年1月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2001/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は10月である" do
          expect(range.first.month).to be 10
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は1月である" do
          expect(range.last.month).to be 1
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "2000年1月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2000/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は1月である" do
          expect(range.first.month).to be 1
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は1月である" do
          expect(range.last.month).to be 1
        end
      end

      context "2000年6月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2000/06/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は1月である" do
          expect(range.first.month).to be 1
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は6月である" do
          expect(range.last.month).to be 6
        end
      end

      context "2001年12月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2001/12/01")) }
        it "Range始端は2001年である" do
          expect(range.first.year).to be 2001
        end

        it "Range始端は7月である" do
          expect(range.first.month).to be 7
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end
    end

    context "年度開始が8月の場合" do
      include_context "fiscal_year_start_aug"

      context "2000年8月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2000/08/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は8月である" do
          expect(range.first.month).to be 8
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は8月である" do
          expect(range.last.month).to be 8
        end
      end

      context "2000年6月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2000/06/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 2
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は6月である" do
          expect(range.last.month).to be 6
        end
      end

      context "2001年1月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2001/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は10月である" do
          expect(range.first.month).to be 8
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は1月である" do
          expect(range.last.month).to be 1
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年12月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2000/12/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end

      context "2001年6月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2001/06/01")) }
        it "Range始端は2001年である" do
          expect(range.first.year).to be 2001
        end

        it "Range始端は6月である" do
          expect(range.first.month).to be 6
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は6月である" do
          expect(range.last.month).to be 6
        end
      end

      context "2001年1月のとき" do
        let(:range) { FiscalYear::YearToDate.half_range_by(Date.parse("2001/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は1月である" do
          expect(range.last.month).to be 1
        end
      end
    end
  end

  describe "#quarter_range_by" do
    it "Rangeを返す" do
      expect(FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/01/01")).class).to be Range
    end

    it "Range始端がDateである" do
      expect(FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/01/01")).first.class).to be Date
    end

    it "Range終端がDateである" do
      expect(FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/01/01")).last.class).to be Date
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年4月のとき" do
        let(:range) { FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/04/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は4月である" do
          expect(range.last.month).to be 4
        end
      end

      context "2000年6月のとき" do
        let(:range) { FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/06/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は6月である" do
          expect(range.last.month).to be 6
        end
      end

      context "2000年8月のとき" do
        let(:range) { FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/08/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は7月である" do
          expect(range.first.month).to be 7
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は8月である" do
          expect(range.last.month).to be 8
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年12月のとき" do
        let(:range) { FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/12/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end

      context "2001年2月のとき" do
        let(:range) { FiscalYear::YearToDate.quarter_range_by(Date.parse("2001/02/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は2月である" do
          expect(range.last.month).to be 2
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "2000年1月のとき" do
        let(:range) { FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は1月である" do
          expect(range.first.month).to be 1
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は1月である" do
          expect(range.last.month).to be 1
        end
      end

      context "2001年2月のとき" do
        let(:range) { FiscalYear::YearToDate.quarter_range_by(Date.parse("2001/02/01")) }
        it "Range始端は2001年である" do
          expect(range.first.year).to be 2001
        end

        it "Range始端は1月である" do
          expect(range.first.month).to be 1
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は2月である" do
          expect(range.last.month).to be 2
        end
      end

      context "2000年12月のとき" do
        let(:range) { FiscalYear::YearToDate.quarter_range_by(Date.parse("2000/12/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は10月である" do
          expect(range.first.month).to be 10
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end
    end
  end
end
