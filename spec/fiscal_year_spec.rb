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

    it "値が変更できる" do
      FiscalYear.configure do |config|
        config.start_month = 6
      end

      expect(FiscalYear.config.start_month).to eq 6
    end
  end

  describe "#cross_year_month?" do
    it "true or falseを返す" do
      expect(FiscalYear.cross_year_month?(1).class).to be(TrueClass).or(FalseClass)
    end

    context "年度開始が4月の場合" do
      before do
        FiscalYear.configure do |config|
          config.start_month = 4
        end
      end

      it "3月は年を跨いでいる" do
        expect(FiscalYear.cross_year_month?(3)).to be true
      end

      it "5月は年を跨いでいない" do
        expect(FiscalYear.cross_year_month?(5)).to be false
      end
    end

    context "年度開始が1月の場合" do
      before do
        FiscalYear.configure do |config|
          config.start_month = 1
        end
      end

      it "1月は年を跨いでいない" do
        expect(FiscalYear.cross_year_month?(1)).to be false
      end

      it "12月は年を跨いでいない" do
        expect(FiscalYear.cross_year_month?(12)).to be false
      end
    end

    context "年度開始が6月の場合" do
      before do
        FiscalYear.configure do |config|
          config.start_month = 6
        end
      end

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
      before do
        FiscalYear.configure do |config|
          config.start_month = 4
        end
      end

      it "年跨ぎが発生する" do
        expect(FiscalYear.cross_year?).to be true
      end
    end

    context "年度開始が1月の場合" do
      before do
        FiscalYear.configure do |config|
          config.start_month = 1
        end
      end

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
      before do
        FiscalYear.configure do |config|
          config.start_month = 4
        end
      end

      it "最初の値は4である" do
        expect(FiscalYear.months.first).to be 4
      end

      it "最後の値は3である" do
        expect(FiscalYear.months.last).to be 3
      end
    end

    context "年度開始が1月の場合" do
      before do
        FiscalYear.configure do |config|
          config.start_month = 1
        end
      end

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
      before do
        FiscalYear.configure do |config|
          config.start_month = 4
        end
      end

      it "年跨ぎする月は1, 2, 3月であり、順番が保証されている" do
        expect(FiscalYear.cross_year_months).to eq [1, 2, 3]
      end
    end

    context "年度開始が1月の場合" do
      before do
        FiscalYear.configure do |config|
          config.start_month = 1
        end
      end

      it "年跨ぎする月はない" do
        expect(FiscalYear.cross_year_months).to eq []
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
end
