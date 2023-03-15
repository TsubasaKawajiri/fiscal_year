# FiscalYear

Calculate fiscal year half, quarter, and year to date.

## Installation

```
gem 'fiscal_year'
```

then,

```
bundle install
```

## Usage

```
require 'fiscal_year'

FiscalYear.quarters
=> [[4, 5, 6], [7, 8, 9], [10, 11, 12], [1, 2, 3]]

date = Date.parse('2023/08/01')

# get current Half range
FiscalYear::Half.range_by(date)
=> Sat, 01 Apr 2023..Sat, 30 Sep 2023

# get current quarter range
FiscalYear::Quarter.range_by(date)
=> Sat, 01 Jul 2023..Sat, 30 Sep 2023

# get year to date
FiscalYear::YearToDate.range_by(date)
=> Sat, 01 Apr 2023..Thu, 31 Aug 2023
```

configure start month

```config/initializer/FiscalYear.rb

  FiscalYear.configure do |config|
    config.start_month = 4
  end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fiscal_year. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/fiscal_year/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FiscalYear project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fiscal_year/blob/master/CODE_OF_CONDUCT.md).
