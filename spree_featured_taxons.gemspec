# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_featured_taxons'
  s.version     = '0.70.1'
  s.summary     = 'Add basic ability to mark a taxon as featured'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Jason Miller'
  s.email             = 'jason@matmon.com'
  s.homepage          = 'http://www.matmon.com'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 0.70.1'
  s.add_development_dependency 'rspec-rails'
end

