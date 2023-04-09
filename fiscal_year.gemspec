# frozen_string_literal: true

require_relative "lib/fiscal_year/version"

Gem::Specification.new do |spec|
  spec.name = "fiscal_year"
  spec.version = FiscalYear::VERSION
  spec.authors = ["Tsubasa Kawajiri"]
  spec.email = ["tk.music.jpn@gmail.com"]

  spec.summary = "fiscal year calculate"
  spec.description = "fiscal year, quarter, year to date calculate"
  spec.homepage = "https://github.com/TsubasaKawajiri/fiscal_year"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/TsubasaKawajiri/fiscal_year"
  spec.metadata["changelog_uri"] = "https://github.com/TsubasaKawajiri/fiscal_year/CHANGEROG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
