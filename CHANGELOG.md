## [1.0.0] - 2024-07-24
celebrate 1.0.0 release!! 🎉
No Breaking Changes, Some futures.

- add `passed_month_count_by` and `passed_month_count_by_month` to each FiscalYear, Half, Quarter.
- fix wrong example comment on `FiscalYear::YearToDate.quarter_range_by`.
- robust `Config.start_month`. you can no longer pass invalid month. now only pass number 1-12, or short symbol like `:jan`, `:dec`.

Thank you for gave me courage to release, ruby-jp!

## [0.7.0] - 2024-07-11
- add YARD comment.
- fix `FiscalYear::YearToDate.quarter_range_by` logic.

## [0.6.0] - 2024-05-15
- [BREAK] Ruby 3.0.x, 2.7.x and 2.6.x has no longer support.
- add `FiscalYear.range_by` method

## [0.5.0] - 2024-03-18
- [BREAK] rename and move `FiscalYear::Half.normalize_year_by_month` to `FiscalYear.increase_year_by_month`
- add `FiscalYear.decrease_year_by_month` method

when year normalize, we may want to increase year or decrease year depending on the situation.
therefore, rename and add decrease method.

## [0.4.0] - 2023-06-15
- fix calculate logic of half year to date

## [0.3.0] - 2023-04-23
- add rbs
  - fit to rbs

- improve workflow
  - add dependabot
  - add test coverage

## [0.2.0] - 2023-03-16
- add test
- fit to rubocop

- fix some methods

## [0.1.0] - 2023-03-14

- Initial release
