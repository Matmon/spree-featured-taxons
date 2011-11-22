SpreeFeaturedTaxon
==================

Introduction goes here.


Install
=======

1. Add the following to your Gemfile
   gem 'spree_featured_taxons', #TODO change to git path when we publish'

2. Run `bundle install`

3. To setup the asset pipeline includes and copy migrations run:  
   rails g spree_featured_taxon:install

Testing
-------

Be sure to add the rspec-rails gem to your Gemfile and then create a dummy test app for the specs to run against.

    $ bundle exec rake test app
    $ bundle exec rspec spec

Copyright (c) 2011 [name of extension creator], released under the New BSD License
