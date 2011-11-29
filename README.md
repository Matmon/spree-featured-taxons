SpreeFeaturedTaxon
==================

Introduction goes here.


Install
=======

1. Add the following to your Gemfile
   gem 'spree_featured_taxon', #TODO change to git path when we publish'

2. Run `bundle install`

3. To setup the asset pipeline includes and copy migrations run:  
   bundle exec rails g spree_featured_taxon:install

4. In your overrides you can use Taxon.featured for a list of featured taxons
   also adds helper
   featured_taxon_list(Taxon.featured, @taxon)

   so you can do 

    Deface::Override::new({ :virtual_path => 'shared/_taxonomies',
	:name => 'insert_featured_taxonomies',
	:insert_after => 'div#taxonomies',
	:text => %q{
		
	<div id="featured_taxonomies" class="sidebar-item" data-hook="featured_taxonomies">
	  <h3 class='taxonomy-root'><%= t(:featured) %></h3>
	      
	    <%= featured_taxon_list(Taxon.featured, @taxon) %>

	</div>

		}

	})   

Testing
-------

    $ bundle exec rake test_app
    $ cd spec/dummy 
    $ bundle exec rails g spree_featured_taxon:install
    $ bundle exec rspec spec

Copyright (c) 2011 Matmon Internet, Inc., released under the New BSD License
