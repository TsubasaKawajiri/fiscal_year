# frozen_string_literal: true

RSpec.describe FiscalYear do
  before(:each) { FiscalYear.instance_variable_set :@config, FiscalYear::Config.new }

  it "has a version number" do
    expect(FiscalYear::VERSION).not_to be nil
  end

  describe "#config" do
    it "アクセスできる" do
      expect(FiscalYear.config.class).to eq FiscalYear::Config
    end

    it "値が参照できる" do
      expect(FiscalYear.config.start_month).not_to be nil
    end

    it "数値で値が変更できる" do
      FiscalYear.configure do |config|
        config.start_month = 6
      end

      expect(FiscalYear.config.start_month).to eq 6
    end

    it "シンボルで値が変更できる" do
      FiscalYear.configure do |config|
        config.start_month = :jun
      end

      expect(FiscalYear.config.start_month).to eq 6
    end
  end

  describe "#cross_year_month?" do
    it "true or falseを返す" do
      expect(FiscalYear.cross_year_month?(1).class).to be(TrueClass).or(be FalseClass)
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "3月は年を跨いでいる" do
        expect(FiscalYear.cross_year_month?(3)).to be true
      end

      it "5月は年を跨いでいない" do
        expect(FiscalYear.cross_year_month?(5)).to be false
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "1月は年を跨いでいない" do
        expect(FiscalYear.cross_year_month?(1)).to be false
      end

      it "12月は年を跨いでいない" do
        expect(FiscalYear.cross_year_month?(12)).to be false
      end
    end

    context "年度開始が6月の場合" do
      include_context "fiscal_year_start_june"

      it "5月は年を跨いでいる" do
        expect(FiscalYear.cross_year_month?(5)).to be true
      end

      it "7月は年を跨いでいない" do
        expect(FiscalYear.cross_year_month?(7)).to be false
      end
    end
  end

  describe "#cross_year?" do
    it "true or falseを返す" do
      expect(FiscalYear.cross_year?.class).to be(TrueClass).or(FalseClass)
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "年跨ぎが発生する" do
        expect(FiscalYear.cross_year?).to be true
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "年跨ぎは発生しない" do
        expect(FiscalYear.cross_year?).to be false
      end
    end
  end

  describe "#months" do
    it "配列を返す" do
      expect(FiscalYear.months.class).to be Array
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "最初の値は4である" do
        expect(FiscalYear.months.first).to be 4
      end

      it "最後の値は3である" do
        expect(FiscalYear.months.last).to be 3
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "最初の値は1である" do
        expect(FiscalYear.months.first).to be 1
      end

      it "最後の値は12である" do
        expect(FiscalYear.months.last).to be 12
      end
    end
  end

  describe "#cross_year_months" do
    it "配列を返す" do
      expect(FiscalYear.cross_year_months.class).to be Array
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "年跨ぎする月は1, 2, 3月であり、順番が保証されている" do
        expect(FiscalYear.cross_year_months).to eq [1, 2, 3]
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "年跨ぎする月はない" do
        expect(FiscalYear.cross_year_months).to eq []
      end
    end

    # なんか一瞬不安になったので追加
    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      it "年跨ぎする月は1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11月であり、順番が保証されている" do
        expect(FiscalYear.cross_year_months).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
      end
    end
  end

  # 以下は別クラスで詳しくテストする
  describe "#halfs" do
    it "配列を返す" do
      expect(FiscalYear.halfs.class).to be Array
    end

    it "2期に分かれている" do
      expect(FiscalYear.halfs.count).to be 2
    end
  end

  describe "#quarters" do
    it "配列を返す" do
      expect(FiscalYear.quarters.class).to be Array
    end

    it "4期に分かれている" do
      expect(FiscalYear.quarters.count).to be 4
    end
  end

  describe "#increase_year_by_month" do
    let(:year) { 2000 }
    context "年度始まりが4月の場合" do
      include_context "fiscal_year_start_apr"

      it "4月は同じ年である" do
        expect(FiscalYear.increase_year_by_month(year, 4)).to be year
      end

      it "1月は次の年である" do
        expect(FiscalYear.increase_year_by_month(year, 1)).to be(year + 1)
      end
    end

    context "年度始まりが1月の場合" do
      include_context "fiscal_year_start_jan"

      it "1月は同じ年である" do
        expect(FiscalYear.increase_year_by_month(year, 1)).to be year
      end

      it "12月は同じ年である" do
        expect(FiscalYear.increase_year_by_month(year, 12)).to be year
      end
    end

    context "年度始まりが12月の場合" do
      include_context "fiscal_year_start_dec"

      it "12月は同じ年である" do
        expect(FiscalYear.increase_year_by_month(year, 12)).to be year
      end

      it "11月は次の年である" do
        expect(FiscalYear.increase_year_by_month(year, 1)).to be(year + 1)
      end
    end
  end

  describe "#decrease_year_by_month" do
    let(:year) { 2000 }
    context "年度始まりが4月の場合" do
      include_context "fiscal_year_start_apr"

      it "4月は同じ年である" do
        expect(FiscalYear.decrease_year_by_month(year, 4)).to be year
      end

      it "1月は次の年である" do
        expect(FiscalYear.decrease_year_by_month(year, 1)).to be(year - 1)
      end
    end

    context "年度始まりが1月の場合" do
      include_context "fiscal_year_start_jan"

      it "1月は同じ年である" do
        expect(FiscalYear.decrease_year_by_month(year, 1)).to be year
      end

      it "12月は同じ年である" do
        expect(FiscalYear.decrease_year_by_month(year, 12)).to be year
      end
    end

    context "年度始まりが12月の場合" do
      include_context "fiscal_year_start_dec"

      it "12月は同じ年である" do
        expect(FiscalYear.decrease_year_by_month(year, 12)).to be year
      end

      it "11月は次の年である" do
        expect(FiscalYear.decrease_year_by_month(year, 1)).to be(year - 1)
      end
    end
  end

  describe "#range_by" do
    it "Rangeを返す" do
      expect(FiscalYear.range_by(Date.parse("2000/01/01")).class).to be Range
    end

    it "Range始端がDateである" do
      expect(FiscalYear.range_by(Date.parse("2000/01/01")).first.class).to be Date
    end

    it "Range終端がDateである" do
      expect(FiscalYear.range_by(Date.parse("2000/01/01")).last.class).to be Date
    end

    context "年度始まりが4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年4月のとき" do
        let(:range) { FiscalYear.range_by(Date.parse("2000/04/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は3月である" do
          expect(range.last.month).to be 3
        end
      end

      context "2000年10月のとき" do
        include_context "fiscal_year_start_apr"
        let(:range) { FiscalYear.range_by(Date.parse("2000/10/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は3月である" do
          expect(range.last.month).to be 3
        end
      end

      context "2001年1月のとき" do
        include_context "fiscal_year_start_apr"
        let(:range) { FiscalYear.range_by(Date.parse("2001/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は3月である" do
          expect(range.last.month).to be 3
        end
      end
    end

    context "年度始まりが1月の場合" do
      include_context "fiscal_year_start_jan"

      context "2000年1月のとき" do
        let(:range) { FiscalYear.range_by(Date.parse("2000/01/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は1月である" do
          expect(range.first.month).to be 1
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end

      context "2000年10月のとき" do
        let(:range) { FiscalYear.range_by(Date.parse("2000/10/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は1月である" do
          expect(range.first.month).to be 1
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end

      context "1999年12月のとき" do
        let(:range) { FiscalYear.range_by(Date.parse("1999/12/01")) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は1月である" do
          expect(range.first.month).to be 1
        end

        it "Range終端は1999年である" do
          expect(range.last.year).to be 1999
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年1月のとき" do
        let(:range) { FiscalYear.range_by(Date.parse("2000/01/01")) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は11月である" do
          expect(range.last.month).to be 11
        end
      end

      context "2000年10月のとき" do
        let(:range) { FiscalYear.range_by(Date.parse("2000/10/01")) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は11月である" do
          expect(range.last.month).to be 11
        end
      end

      context "1999年12月のとき" do
        let(:range) { FiscalYear.range_by(Date.parse("1999/12/01")) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は11月である" do
          expect(range.last.month).to be 11
        end
      end
    end
  end

  describe "#passed_month_count_by" do
    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年4月のとき" do
        it "0を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2000/04/01"))).to be 0
        end
      end

      context "2000年10月のとき" do
        it "6を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2000/10/01"))).to be 6
        end
      end

      context "2001年1月のとき" do
        it "9を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2001/01/01"))).to be 9
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "2000年1月のとき" do
        it "0を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2000/01/01"))).to be 0
        end
      end

      context "2000年10月のとき" do
        it "9を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2000/10/01"))).to be 9
        end
      end

      context "2000年12月のとき" do
        it "11を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2000/12/01"))).to be 11
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年12月のとき" do
        it "0を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2000/12/01"))).to be 0
        end
      end

      context "2001年1月のとき" do
        it "1を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2001/01/01"))).to be 1
        end
      end

      context "2001年10月のとき" do
        it "10を返す" do
          expect(FiscalYear.passed_month_count_by(Date.parse("2001/10/01"))).to be 10
        end
      end
    end
  end

  describe "#passed_month_count_by_month" do
    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "4月のとき" do
        it "0を返す" do
          expect(FiscalYear.passed_month_count_by_month(4)).to be 0
        end
      end

      context "10月のとき" do
        it "6を返す" do
          expect(FiscalYear.passed_month_count_by_month(10)).to be 6
        end
      end

      context "1月のとき" do
        it "9を返す" do
          expect(FiscalYear.passed_month_count_by_month(1)).to be 9
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "1月のとき" do
        it "0を返す" do
          expect(FiscalYear.passed_month_count_by_month(1)).to be 0
        end
      end

      context "10月のとき" do
        it "9を返す" do
          expect(FiscalYear.passed_month_count_by_month(10)).to be 9
        end
      end

      context "12月のとき" do
        it "11を返す" do
          expect(FiscalYear.passed_month_count_by_month(12)).to be 11
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "12月のとき" do
        it "0を返す" do
          expect(FiscalYear.passed_month_count_by_month(12)).to be 0
        end
      end

      context "1月のとき" do
        it "1を返す" do
          expect(FiscalYear.passed_month_count_by_month(1)).to be 1
        end
      end

      context "10月のとき" do
        it "10を返す" do
          expect(FiscalYear.passed_month_count_by_month(10)).to be 10
        end
      end
    end
  end
end
