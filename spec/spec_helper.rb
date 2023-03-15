# frozen_string_literal: true

require "fiscal_year"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.shared_context "fiscal_year_start_jan" do
  before do
    FiscalYear.configure do |config|
      config.start_month = 1
    end
  end
end

RSpec.shared_context "fiscal_year_start_apr" do
  before do
    FiscalYear.configure do |config|
      config.start_month = 4
    end
  end
end

RSpec.shared_context "fiscal_year_start_june" do
  before do
    FiscalYear.configure do |config|
      config.start_month = 6
    end
  end
end

RSpec.shared_context "fiscal_year_start_aug" do
  before do
    FiscalYear.configure do |config|
      config.start_month = 8
    end
  end
end

RSpec.shared_context "fiscal_year_start_dec" do
  before do
    FiscalYear.configure do |config|
      config.start_month = 12
    end
  end
end
