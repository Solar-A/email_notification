# frozen_string_literal: true

require_relative 'lib/email_notification/version'

Gem::Specification.new do |spec|
  spec.name          = 'email_notification'
  spec.version       = EmailNotification::VERSION
  spec.authors       = ['Pavel Sidorenko']
  spec.email         = ['pavel.sid999@gmail.com']

  spec.summary       = 'This gem is used to email notifications'
  spec.description   = 'This gem is used to email notifications'
  spec.homepage      = 'https://github.com/Solar-A/email_notification'
  spec.required_ruby_version = '>= 2.5'

  # spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'sidekiq'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
