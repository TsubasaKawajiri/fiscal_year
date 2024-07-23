# frozen_string_literal: true

RSpec.describe FiscalYear::Config do
  describe "#initialize" do
    it "初期値は4が設定されている" do
      config = FiscalYear::Config.new

      expect(config.start_month).to eq(4)
    end
  end

  describe "#start_month=" do
    context "引数が整数の場合" do
      it "start_monthに数値で設定される" do
        config = FiscalYear::Config.new

        config.start_month = 1

        expect(config.start_month).to eq(1)
      end
    end

    context "引数がシンボルの場合" do
      it "start_monthに数値で設定される" do
        config = FiscalYear::Config.new

        config.start_month = :jan

        expect(config.start_month).to eq(1)
      end
    end

    context "引数が不正な場合" do
      it "InvalidStartMonthErrorが発生する" do
        config = FiscalYear::Config.new

        expect { config.start_month = 13 }.to raise_error(FiscalYear::InvalidStartMonthError)
      end
    end
  end

  describe "#valid_start_month?" do
    context "引数が整数の場合" do
      it "trueが返る" do
        config = FiscalYear::Config.new

        expect(config.send(:valid_start_month?, 1)).to be_truthy
      end
    end

    context "引数がシンボルの場合" do
      it "trueが返る" do
        config = FiscalYear::Config.new

        expect(config.send(:valid_start_month?, :jan)).to be_truthy
      end
    end

    context "引数が不正な場合" do
      it "InvalidStartMonthErrorが発生する" do
        config = FiscalYear::Config.new

        expect { config.send(:valid_start_month?, 13) }.to raise_error(FiscalYear::InvalidStartMonthError)
      end
    end
  end

  describe "#fetch_start_month" do
    context "引数が整数の場合" do
      it "数値が返る" do
        config = FiscalYear::Config.new

        expect(config.send(:fetch_start_month, 1)).to eq(1)
      end
    end

    context "引数がシンボルの場合" do
      it "数値が返る" do
        config = FiscalYear::Config.new

        expect(config.send(:fetch_start_month, :jan)).to eq(1)
      end
    end

    context "引数が不正な場合" do
      it "StandardErrorが発生する" do
        config = FiscalYear::Config.new

        expect { config.send(:fetch_start_month, 13) }.to raise_error(StandardError)
      end
    end
  end
end
