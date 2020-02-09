require_relative 'lib/KansaiTrainInfo/version'

Gem::Specification.new do |spec|
  spec.name          = "KansaiTrainInfo"
  spec.version       = KansaiTrainInfo::VERSION
  spec.authors       = ["okamotchan"]
  spec.email         = ["m.okamotchan@gmail.com"]

  spec.summary       = %q{関西の鉄道運行状況をチェック}
  spec.description   = %q{関西の鉄道運行状況をチェック}
  spec.homepage      = "https://github.com/okamotchan"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["https://github.com/okamotchan"] = spec.homepage
  spec.metadata["https://github.com/okamotchan"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["https://github.com/okamotchan"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "thor"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end