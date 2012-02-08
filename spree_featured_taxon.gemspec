# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_featured_taxon'
  s.version     = '0.1.0'
  s.summary     = 'Add basic ability to mark a taxon as featured'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.authors = ['Jason Miller', 'George F Murphy']
  s.email   = ['jason@matmon.com', 'george@matmon.com']
  s.homepage = 'https://github.com/Matmon/spree-featured-taxon'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'

  s.add_dependency "spree_core", "1.0.0.rc4"
end
