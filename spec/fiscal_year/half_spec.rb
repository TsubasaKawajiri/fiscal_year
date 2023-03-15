# frozen_string_literal: true

RSpec.describe FiscalYear::Half do
  before(:each) { FiscalYear.instance_variable_set :@config, FiscalYear::Config.new }
  describe "#first" do
    it "配列を返す" do
      expect(FiscalYear::Half.first.class).to be Array
    end

    it "6ヶ月存在している" do
      expect(FiscalYear::Half.first.count).to be 6
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "前期は4月からである" do
        expect(FiscalYear::Half.first.first).to be 4
      end

      it "前期は9月までである" do
        expect(FiscalYear::Half.first.last).to be 9
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "前期は1月からである" do
        expect(FiscalYear::Half.first.first).to be 1
      end

      it "前期は6月までである" do
        expect(FiscalYear::Half.first.last).to be 6
      end
    end
  end

  describe "#second" do
    it "配列を返す" do
      expect(FiscalYear::Half.second.class).to be Array
    end

    it "6ヶ月存在している" do
      expect(FiscalYear::Half.second.count).to be 6
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "後期は10月からである" do
        expect(FiscalYear::Half.second.first).to be 10
      end

      it "後期は3月までである" do
        expect(FiscalYear::Half.second.last).to be 3
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "後期は7月からである" do
        expect(FiscalYear::Half.second.first).to be 7
      end

      it "後期は12月までである" do
        expect(FiscalYear::Half.second.last).to be 12
      end
    end
  end

  describe "#first?" do
    it "true or falseを返す" do
      expect(FiscalYear::Half.first?(1).class).to be(TrueClass).or(be FalseClass)
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      it "4月は前期である" do
        expect(FiscalYear::Half.first?(4)).to be true
      end

      it "9月は前期である" do
        expect(FiscalYear::Half.first?(9)).to be true
      end

      it "10月は前期ではない" do
        expect(FiscalYear::Half.first?(10)).to be false
      end
    
      it "3月は前期ではない" do
        expect(FiscalYear::Half.first?(3)).to be false
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      it "1月は前期である" do
        expect(FiscalYear::Half.first?(1)).to be true
      end

      it "6月は前期である" do
        expect(FiscalYear::Half.first?(6)).to be true
      end

      it "7月は前期ではない" do
        expect(FiscalYear::Half.first?(7)).to be false
      end
    
      it "12月は前期ではない" do
        expect(FiscalYear::Half.first?(12)).to be false
      end
    end
  end

  describe "#first_range_by" do
    it "Rangeを返す" do
      expect(FiscalYear::Half.first_range_by(2000).class).to be Range
    end

    it "Range始端がDateである" do
      expect(FiscalYear::Half.first_range_by(2000).first.class).to be Date
    end

    it "Range終端がDateである" do
      expect(FiscalYear::Half.first_range_by(2000).last.class).to be Date
    end
    
    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年度のとき" do
        let(:first_half_range) { FiscalYear::Half.first_range_by(2000) }
        it "Range始端は2000年である" do
          expect(first_half_range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(first_half_range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(first_half_range.last.year).to be 2000
        end

        it "Range終端は9月である" do
          expect(first_half_range.last.month).to be 9
        end
      end

      # Dateのcompleteを考慮
      context "99年度のとき" do
        let(:first_half_range) { FiscalYear::Half.first_range_by(99) }
        it "Range始端は1999年である" do
          expect(first_half_range.first.year).to be 1999
        end

        it "Range始端は4月である" do
          expect(first_half_range.first.month).to be 4
        end

        it "Range終端は1999年である" do
          expect(first_half_range.last.year).to be 1999
        end

        it "Range終端は9月である" do
          expect(first_half_range.last.month).to be 9
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "2000年度のとき" do
        let(:first_half_range) { FiscalYear::Half.first_range_by(2000) }
        it "Range始端は2000年である" do
          expect(first_half_range.first.year).to be 2000
        end

        it "Range始端は1月である" do
          expect(first_half_range.first.month).to be 1
        end

        it "Range終端は2000年である" do
          expect(first_half_range.last.year).to be 2000
        end

        it "Range終端は6月である" do
          expect(first_half_range.last.month).to be 6
        end
      end

      # Dateのcompleteを考慮
      context "99年度のとき" do
        let(:first_half_range) { FiscalYear::Half.first_range_by(99) }
        it "Range始端は1999年である" do
          expect(first_half_range.first.year).to be 1999
        end

        it "Range始端は1月である" do
          expect(first_half_range.first.month).to be 1
        end

        it "Range終端は1999年である" do
          expect(first_half_range.last.year).to be 1999
        end

        it "Range終端は6月である" do
          expect(first_half_range.last.month).to be 6
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年度のとき" do
        let(:first_half_range) { FiscalYear::Half.first_range_by(2000) }
        it "Range始端は2000年である" do
          expect(first_half_range.first.year).to be 2000
        end

        it "Range始端は12月である" do
          expect(first_half_range.first.month).to be 12
        end

        it "Range終端は2001年である" do
          expect(first_half_range.last.year).to be 2001
        end

        it "Range終端は5月である" do
          expect(first_half_range.last.month).to be 5
        end
      end

      # Dateのcompleteを考慮
      context "99年度のとき" do
        let(:first_half_range) { FiscalYear::Half.first_range_by(99) }
        it "Range始端は1999年である" do
          expect(first_half_range.first.year).to be 1999
        end

        it "Range始端は1月である" do
          expect(first_half_range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(first_half_range.last.year).to be 2000
        end

        it "Range終端は5月である" do
          expect(first_half_range.last.month).to be 5
        end
      end
    end
  end

  describe "#second_range_by" do
    it "Rangeを返す" do
      expect(FiscalYear::Half.second_range_by(2000).class).to be Range
    end

    it "Range始端がDateである" do
      expect(FiscalYear::Half.second_range_by(2000).first.class).to be Date
    end

    it "Range終端がDateである" do
      expect(FiscalYear::Half.second_range_by(2000).last.class).to be Date
    end
    
    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年度のとき" do
        let(:second_half_range) { FiscalYear::Half.second_range_by(2000) }
        it "Range始端は2000年である" do
          expect(second_half_range.first.year).to be 2000
        end

        it "Range始端は10月である" do
          expect(second_half_range.first.month).to be 10
        end

        it "Range終端は2001年である" do
          expect(second_half_range.last.year).to be 2001
        end

        it "Range終端は3月である" do
          expect(second_half_range.last.month).to be 3
        end
      end

      # Dateのcompleteを考慮
      context "99年度のとき" do
        let(:second_half_range) { FiscalYear::Half.second_range_by(99) }
        it "Range始端は1999年である" do
          expect(second_half_range.first.year).to be 1999
        end

        it "Range始端は10月である" do
          expect(second_half_range.first.month).to be 10
        end

        it "Range終端は2000年である" do
          expect(second_half_range.last.year).to be 2000
        end

        it "Range終端は3月である" do
          expect(second_half_range.last.month).to be 3
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "2000年度のとき" do
        let(:second_half_range) { FiscalYear::Half.second_range_by(2000) }
        it "Range始端は2000年である" do
          expect(second_half_range.first.year).to be 2000
        end

        it "Range始端は7月である" do
          expect(second_half_range.first.month).to be 7
        end

        it "Range終端は2000年である" do
          expect(second_half_range.last.year).to be 2000
        end

        it "Range終端は12月である" do
          expect(second_half_range.last.month).to be 12
        end
      end

      # Dateのcompleteを考慮
      context "99年度のとき" do
        let(:second_half_range) { FiscalYear::Half.second_range_by(99) }
        it "Range始端は1999年である" do
          expect(second_half_range.first.year).to be 1999
        end

        it "Range始端は7月である" do
          expect(second_half_range.first.month).to be 7
        end

        it "Range終端は1999年である" do
          expect(second_half_range.last.year).to be 1999
        end

        it "Range終端は12月である" do
          expect(second_half_range.last.month).to be 12
        end
      end
    end

    context "年度開始が12月の場合" do
      include_context "fiscal_year_start_dec"

      context "2000年度のとき" do
        let(:second_half_range) { FiscalYear::Half.second_range_by(2000) }
        it "Range始端は2001年である" do
          expect(second_half_range.first.year).to be 2001
        end

        it "Range始端は6月である" do
          expect(second_half_range.first.month).to be 6
        end

        it "Range終端は2001年である" do
          expect(second_half_range.last.year).to be 2001
        end

        it "Range終端は11月である" do
          expect(second_half_range.last.month).to be 11
        end
      end

      # Dateのcompleteを考慮
      context "99年度のとき" do
        let(:second_half_range) { FiscalYear::Half.second_range_by(99) }
        it "Range始端は2000年である" do
          expect(second_half_range.first.year).to be 2000
        end

        it "Range始端は6月である" do
          expect(second_half_range.first.month).to be 6
        end

        it "Range終端は2000年である" do
          expect(second_half_range.last.year).to be 2000
        end

        it "Range終端は11月である" do
          expect(second_half_range.last.month).to be 11
        end
      end
    end
  end

  describe "#range_by" do
    it "Rangeを返す" do
      expect(FiscalYear::Half.range_by(Date.parse('2000/01/01')).class).to be Range
    end

    it "Range始端がDateである" do
      expect(FiscalYear::Half.range_by(Date.parse('2000/01/01')).first.class).to be Date
    end

    it "Range終端がDateである" do
      expect(FiscalYear::Half.range_by(Date.parse('2000/01/01')).last.class).to be Date
    end

    context "年度開始が4月の場合" do
      include_context "fiscal_year_start_apr"

      context "2000年4月のとき" do
        let(:range) { FiscalYear::Half.range_by(Date.parse('2000/04/01')) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は4月である" do
          expect(range.first.month).to be 4
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は9月である" do
          expect(range.last.month).to be 9
        end
      end

      context "2000年10月のとき" do
        let(:range) { FiscalYear::Half.range_by(Date.parse('2000/10/01')) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は10月である" do
          expect(range.first.month).to be 10
        end

        it "Range終端は2001年である" do
          expect(range.last.year).to be 2001
        end

        it "Range終端は3月である" do
          expect(range.last.month).to be 3
        end
      end

      context "2000年1月のとき" do
        let(:range) { FiscalYear::Half.range_by(Date.parse('2000/01/01')) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は10月である" do
          expect(range.first.month).to be 10
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は3月である" do
          expect(range.last.month).to be 3
        end
      end
    end

    context "年度開始が1月の場合" do
      include_context "fiscal_year_start_jan"

      context "2000年1月のとき" do
        let(:range) { FiscalYear::Half.range_by(Date.parse('2000/01/01')) }
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

      context "2000年10月のとき" do
        let(:range) { FiscalYear::Half.range_by(Date.parse('2000/10/01')) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は7月である" do
          expect(range.first.month).to be 7
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は12月である" do
          expect(range.last.month).to be 12
        end
      end

      context "1999年12月のとき" do
        let(:range) { FiscalYear::Half.range_by(Date.parse('1999/12/01')) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は7月である" do
          expect(range.first.month).to be 7
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
        let(:range) { FiscalYear::Half.range_by(Date.parse('2000/01/01')) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は5月である" do
          expect(range.last.month).to be 5
        end
      end

      context "2000年10月のとき" do
        let(:range) { FiscalYear::Half.range_by(Date.parse('2000/10/01')) }
        it "Range始端は2000年である" do
          expect(range.first.year).to be 2000
        end

        it "Range始端は6月である" do
          expect(range.first.month).to be 6
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は11月である" do
          expect(range.last.month).to be 11
        end
      end

      context "1999年12月のとき" do
        let(:range) { FiscalYear::Half.range_by(Date.parse('1999/12/01')) }
        it "Range始端は1999年である" do
          expect(range.first.year).to be 1999
        end

        it "Range始端は12月である" do
          expect(range.first.month).to be 12
        end

        it "Range終端は2000年である" do
          expect(range.last.year).to be 2000
        end

        it "Range終端は5月である" do
          expect(range.last.month).to be 5
        end
      end
    end
  end
end
