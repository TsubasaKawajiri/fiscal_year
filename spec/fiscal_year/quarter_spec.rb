# frozen_string_literal: true

RSpec.describe FiscalYear::Quarter do
  before(:each) { FiscalYear.instance_variable_set :@config, FiscalYear::Config.new }
  describe "#first" do
    it "配列を返す" do
      expect(FiscalYear::Quarter.first.class).to be Array
    end

    it "3ヶ月存在している" do
      expect(FiscalYear::Quarter.first.count).to be 3
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "1Qは4月からである" do
        expect(FiscalYear::Quarter.first.first).to be 4
      end

      it "1Qは6月までである" do
        expect(FiscalYear::Quarter.first.last).to be 6
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "1Qは1月からである" do
        expect(FiscalYear::Quarter.first.first).to be 1
      end

      it "1Qは3月までである" do
        expect(FiscalYear::Quarter.first.last).to be 3
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      it "1Qは12月からである" do
        expect(FiscalYear::Quarter.first.first).to be 12
      end

      it "1Qは2月までである" do
        expect(FiscalYear::Quarter.first.last).to be 2
      end
    end
  end

  describe "#second" do
    it "配列を返す" do
      expect(FiscalYear::Quarter.second.class).to be Array
    end

    it "3ヶ月存在している" do
      expect(FiscalYear::Quarter.second.count).to be 3
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "2Qは7月からである" do
        expect(FiscalYear::Quarter.second.first).to be 7
      end

      it "2Qは9月までである" do
        expect(FiscalYear::Quarter.second.last).to be 9
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "2Qは4月からである" do
        expect(FiscalYear::Quarter.second.first).to be 4
      end

      it "2Qは6月までである" do
        expect(FiscalYear::Quarter.second.last).to be 6
      end
    end

    context "年度開始が8月の場合" do
      include_context "fiscal_year_start_aug"

      it "2Qは11月からである" do
        expect(FiscalYear::Quarter.second.first).to be 11
      end

      it "2Qは1月までである" do
        expect(FiscalYear::Quarter.second.last).to be 1
      end
    end
  end

  describe "#third" do
    it "配列を返す" do
      expect(FiscalYear::Quarter.third.class).to be Array
    end

    it "3ヶ月存在している" do
      expect(FiscalYear::Quarter.third.count).to be 3
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "3Qは10月からである" do
        expect(FiscalYear::Quarter.third.first).to be 10
      end

      it "3Qは12月までである" do
        expect(FiscalYear::Quarter.third.last).to be 12
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "3Qは7月からである" do
        expect(FiscalYear::Quarter.third.first).to be 7
      end

      it "3Qは9月までである" do
        expect(FiscalYear::Quarter.third.last).to be 9
      end
    end

    context "年度開始が6月の場合" do
      include_context "fiscal_year_start_june"

      it "3Qは12月からである" do
        expect(FiscalYear::Quarter.third.first).to be 12
      end

      it "3Qは2月までである" do
        expect(FiscalYear::Quarter.third.last).to be 2
      end
    end
  end

  describe "#fourth" do
    it "配列を返す" do
      expect(FiscalYear::Quarter.fourth.class).to be Array
    end

    it "3ヶ月存在している" do
      expect(FiscalYear::Quarter.fourth.count).to be 3
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "4Qは1月からである" do
        expect(FiscalYear::Quarter.fourth.first).to be 1
      end

      it "4Qは3月までである" do
        expect(FiscalYear::Quarter.fourth.last).to be 3
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "4Qは10月からである" do
        expect(FiscalYear::Quarter.fourth.first).to be 10
      end

      it "4Qは12月までである" do
        expect(FiscalYear::Quarter.fourth.last).to be 12
      end
    end

    context "年度開始が8月の場合" do
      include_context "fiscal_year_start_aug"

      it "4Qは5月からである" do
        expect(FiscalYear::Quarter.fourth.first).to be 5
      end

      it "4Qは7月までである" do
        expect(FiscalYear::Quarter.fourth.last).to be 7
      end
    end
  end

  describe "#first?" do
    it "true or falseを返す" do
      expect(FiscalYear::Quarter.first?(1).class).to be(TrueClass).or(be FalseClass)
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "4月は1Qである" do
        expect(FiscalYear::Quarter.first?(4)).to be true
      end

      it "6月は1Qである" do
        expect(FiscalYear::Quarter.first?(6)).to be true
      end

      it "7月は1Qではない" do
        expect(FiscalYear::Quarter.first?(7)).to be false
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "1月は1Qである" do
        expect(FiscalYear::Quarter.first?(1)).to be true
      end

      it "3月は1Qである" do
        expect(FiscalYear::Quarter.first?(3)).to be true
      end

      it "4月は1Qではない" do
        expect(FiscalYear::Quarter.first?(4)).to be false
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      it "12月は1Qである" do
        expect(FiscalYear::Quarter.first?(12)).to be true
      end

      it "2月は1Qである" do
        expect(FiscalYear::Quarter.first?(2)).to be true
      end

      it "3月は1Qではない" do
        expect(FiscalYear::Quarter.first?(3)).to be false
      end
    end
  end

  describe "#second?" do
    it "true or falseを返す" do
      expect(FiscalYear::Quarter.second?(1).class).to be(TrueClass).or(be FalseClass)
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "7月は2Qである" do
        expect(FiscalYear::Quarter.second?(7)).to be true
      end

      it "9月は2Qである" do
        expect(FiscalYear::Quarter.second?(9)).to be true
      end

      it "10月は2Qではない" do
        expect(FiscalYear::Quarter.second?(10)).to be false
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "4月は2Qである" do
        expect(FiscalYear::Quarter.second?(4)).to be true
      end

      it "6月は2Qである" do
        expect(FiscalYear::Quarter.second?(6)).to be true
      end

      it "7月は2Qではない" do
        expect(FiscalYear::Quarter.second?(7)).to be false
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      it "3月は2Qである" do
        expect(FiscalYear::Quarter.second?(3)).to be true
      end

      it "5月は2Qである" do
        expect(FiscalYear::Quarter.second?(5)).to be true
      end

      it "6月は2Qではない" do
        expect(FiscalYear::Quarter.second?(6)).to be false
      end
    end
  end

  describe "#third?" do
    it "true or falseを返す" do
      expect(FiscalYear::Quarter.third?(1).class).to be(TrueClass).or(be FalseClass)
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "10月は3Qである" do
        expect(FiscalYear::Quarter.third?(10)).to be true
      end

      it "12月は3Qである" do
        expect(FiscalYear::Quarter.third?(12)).to be true
      end

      it "1月は3Qではない" do
        expect(FiscalYear::Quarter.third?(1)).to be false
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "7月は3Qである" do
        expect(FiscalYear::Quarter.third?(7)).to be true
      end

      it "9月は3Qである" do
        expect(FiscalYear::Quarter.third?(9)).to be true
      end

      it "10月は3Qではない" do
        expect(FiscalYear::Quarter.third?(10)).to be false
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      it "6月は3Qである" do
        expect(FiscalYear::Quarter.third?(6)).to be true
      end

      it "8月は3Qである" do
        expect(FiscalYear::Quarter.third?(8)).to be true
      end

      it "9月は3Qではない" do
        expect(FiscalYear::Quarter.third?(9)).to be false
      end
    end
  end

  describe "#fourth?" do
    it "true or falseを返す" do
      expect(FiscalYear::Quarter.fourth?(1).class).to be(TrueClass).or(be FalseClass)
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "1月は4Qである" do
        expect(FiscalYear::Quarter.fourth?(1)).to be true
      end

      it "3月は4Qである" do
        expect(FiscalYear::Quarter.fourth?(3)).to be true
      end

      it "4月は4Qではない" do
        expect(FiscalYear::Quarter.fourth?(4)).to be false
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "10月は4Qである" do
        expect(FiscalYear::Quarter.fourth?(10)).to be true
      end

      it "12月は4Qである" do
        expect(FiscalYear::Quarter.fourth?(12)).to be true
      end

      it "1月は4Qではない" do
        expect(FiscalYear::Quarter.fourth?(1)).to be false
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      it "9月は4Qである" do
        expect(FiscalYear::Quarter.fourth?(9)).to be true
      end

      it "11月は4Qである" do
        expect(FiscalYear::Quarter.fourth?(11)).to be true
      end

      it "12月は4Qではない" do
        expect(FiscalYear::Quarter.fourth?(12)).to be false
      end
    end
  end

  describe "#months" do
    it "配列を返す" do
      expect(FiscalYear::Quarter.months(1).class).to be Array
    end

    it "3ヶ月存在している" do
      expect(FiscalYear::Quarter.months(1).count).to be 3
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "4月が属する四半期の月は4, 5, 6月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(4)).to eq [4, 5, 6]
      end

      it "5月が属する四半期の月は4, 5, 6月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(5)).to eq [4, 5, 6]
      end

      it "8月が属する四半期の月は7, 8, 9月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(8)).to eq [7, 8, 9]
      end

      it "1月が属する四半期の月は1, 2, 3月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(1)).to eq [1, 2, 3]
      end
    end

    context "年度開始が6月の場合" do
      include_context "fiscal_year_start_june"

      it "4月が属する四半期の月は3, 4, 5月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(4)).to eq [3, 4, 5]
      end

      it "5月が属する四半期の月は3, 4, 5月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(5)).to eq [3, 4, 5]
      end

      it "8月が属する四半期の月は6, 7, 8月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(8)).to eq [6, 7, 8]
      end

      it "1月が属する四半期の月は12, 1, 2月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(1)).to eq [12, 1, 2]
      end
    end

    context "年度開始が8月の場合" do
      include_context "fiscal_year_start_aug"

      it "4月が属する四半期の月は2, 3, 4月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(4)).to eq [2, 3, 4]
      end

      it "5月が属する四半期の月は5, 6, 7月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(5)).to eq [5, 6, 7]
      end

      it "8月が属する四半期の月は8, 9, 10月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(8)).to eq [8, 9, 10]
      end

      it "1月が属する四半期の月は11, 12, 1月であり、順番が保証されている" do
        expect(FiscalYear::Quarter.months(1)).to eq [11, 12, 1]
      end
    end
  end

  describe "#range_by" do
    it "Rangeを返す" do
      expect(FiscalYear::Quarter.range_by(Date.parse("2000/01/01")).class).to be Range
    end

    it "Range始端がDateである" do
      expect(FiscalYear::Quarter.range_by(Date.parse("2000/01/01")).first.class).to be Date
    end

    it "Range終端がDateである" do
      expect(FiscalYear::Quarter.range_by(Date.parse("2000/01/01")).last.class).to be Date
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年4月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("2000/04/01")) }
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

      context "2000年7月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("2000/07/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は7月である" do
          expect(range.first.month).to be 7
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は9月である" do
          expect(range.last.month).to be 9
        end
      end

      context "2000年8月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("2000/08/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は7月である" do
          expect(range.first.month).to be 7
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は9月である" do
          expect(range.last.month).to be 9
        end
      end

      # Dateのcompleteを考慮
      context "1999年8月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("99/08/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は7月である" do
          expect(range.first.month).to be 7
        end

        it "Range終端は1999年である" do
          expect(range.last.year).to be 1999
        end

        it "Range終端は9月である" do
          expect(range.last.month).to be 9
        end
      end
    end

    context "年度開始が8月の場合" do
      include_context "fiscal_year_start_aug"

      context "2000年8月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("2000/08/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は8月である" do
          expect(range.first.month).to be 8
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は10月である" do
          expect(range.last.month).to be 10
        end
      end

      context "2000年11月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("2000/11/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は11月である" do
          expect(range.first.month).to be 11
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は1月である" do
          expect(range.last.month).to be 1
        end
      end

      # Dateのcompleteを考慮
      context "1999年8月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("99/08/01")) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は8月である" do
          expect(range.first.month).to be 8
        end

        it "Range終端は1999年である" do
          expect(range.last.year).to be 1999
        end

        it "Range終端は10月である" do
          expect(range.last.month).to be 10
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年12月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("2000/12/01")) }
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

      context "2000年3月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("2000/3/01")) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は3月である" do
          expect(range.first.month).to be 3
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は5月である" do
          expect(range.last.month).to be 5
        end
      end

      # Dateのcompleteを考慮
      context "1999年12月のとき" do
        let(:range) { FiscalYear::Quarter.range_by(Date.parse("99/12/01")) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は2月である" do
          expect(range.last.month).to be 2
        end
      end
    end
  end

  describe "#passed_month_count_by" do
    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年4月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/04/01"))).to be 0
        end
      end

      context "2000年6月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/06/01"))).to be 2
        end
      end

      context "2000年7月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/07/01"))).to be 0
        end
      end

      context "2000年8月のとき" do
        it "1を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/08/01"))).to be 1
        end
      end

      context "2000年10月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/10/01"))).to be 0
        end
      end

      context "2000年12月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/12/01"))).to be 2
        end
      end

      context "2001年1月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/01/01"))).to be 0
        end
      end

      context "2001年3月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/03/01"))).to be 2
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "2000年1月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/01/01"))).to be 0
        end
      end

      context "2000年3月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/03/01"))).to be 2
        end
      end

      context "2000年4月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/04/01"))).to be 0
        end
      end

      context "2000年5月のとき" do
        it "1を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/05/01"))).to be 1
        end
      end

      context "2000年7月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/07/01"))).to be 0
        end
      end

      context "2000年9月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/09/01"))).to be 2
        end
      end

      context "2000年10月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/10/01"))).to be 0
        end
      end

      context "2000年12月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/12/01"))).to be 2
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年12月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2000/12/01"))).to be 0
        end
      end

      context "2001年2月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/02/01"))).to be 2
        end
      end

      context "2001年3月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/03/01"))).to be 0
        end
      end

      context "2001年4月のとき" do
        it "1を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/04/01"))).to be 1
        end
      end

      context "2001年6月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/06/01"))).to be 0
        end
      end

      context "2001年8月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/08/01"))).to be 2
        end
      end

      context "2001年9月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/09/01"))).to be 0
        end
      end

      context "2001年11月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by(Date.parse("2001/11/01"))).to be 2
        end
      end
    end
  end

  describe "#passed_month_count_by_month" do
    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "4月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(4)).to be 0
        end
      end

      context "6月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(6)).to be 2
        end
      end

      context "7月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(7)).to be 0
        end
      end

      context "8月のとき" do
        it "1を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(8)).to be 1
        end
      end

      context "10月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(10)).to be 0
        end
      end

      context "12月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(12)).to be 2
        end
      end

      context "1月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(1)).to be 0
        end
      end

      context "3月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(3)).to be 2
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "1月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(1)).to be 0
        end
      end

      context "3月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(3)).to be 2
        end
      end

      context "4月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(4)).to be 0
        end
      end

      context "5月のとき" do
        it "1を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(5)).to be 1
        end
      end

      context "7月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(7)).to be 0
        end
      end

      context "9月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(9)).to be 2
        end
      end

      context "10月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(10)).to be 0
        end
      end

      context "12月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(12)).to be 2
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "12月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(12)).to be 0
        end
      end

      context "2月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(2)).to be 2
        end
      end

      context "3月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(3)).to be 0
        end
      end

      context "4月のとき" do
        it "1を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(4)).to be 1
        end
      end

      context "6月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(6)).to be 0
        end
      end

      context "8月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(8)).to be 2
        end
      end

      context "9月のとき" do
        it "0を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(9)).to be 0
        end
      end

      context "11月のとき" do
        it "2を返す" do
          expect(FiscalYear::Quarter.passed_month_count_by_month(11)).to be 2
        end
      end
    end
  end
end
