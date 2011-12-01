SpreeFeaturedTaxon
==================

Introduction goes here.


Install
=======

1. Add the following to your Gemfile  
   `gem 'spree_featured_taxon', :git => 'git://github.com/Matmon/spree-featured-taxons.git'`

2. Run
   `bundle install`

3. To setup the asset pipeline includes and copy migrations run:  
   `bundle exec rails g spree_featured_taxon:install`

4. In your overrides you can use `Taxon.featured` for a collection of featured taxons.

5. It also adds a helper, **featured_taxon_list**, that provides an unordered list of taxons.

   so you can do

```
Deface::Override::new({ :virtual_path => 'shared/_taxonomies',
  :name => 'insert_featured_taxonomies',
  :insert_after => 'div#taxonomies',
  :text => %q{

  <div id="featured_taxonomies" class="sidebar-item" data-hook="featured_taxonomies">
    <h3 class='taxonomy-root'><%= t(:featured) %></h3>

      <%= featured_taxon_list(featured_taxons) %>

  </div>

  	}

})
```

Helper Options
==============

The helper takes the following keys in an option hash that customize the rendering of the list

* `:id => string` if given, it will become the css id for the ul
* `:class => string` if given, it will become the css class for the list
* `:current => taxon` if given and present in the given collection the css class **current** will added to the li that contains the taxon.

You can also override the default rendering of the li content with a block.

E.G. if given:

```
taxons  = [Taxon.new(:name => 'one'), Taxon.new(:name => 'two')]
current = taxons.first

featured_taxon_list(taxons, :id => 'test_id', :class => 'test_class', :current => current) do |taxon|
  "Hello, #{taxon.name}"
end
```

will render the list:

```
<ul id="test_id" class="test_class">
  <li class="current">Hello, one</li>
  <li>Hello, two</li>
</ul>
```

Please read helper tests as well.

Testing
=======

```
    $ bundle exec rake test_app
    $ cd spec/dummy
    $ bundle exec rails g spree_featured_taxon:install
    $ cd ../../
    $ bundle exec rake spec
```

Copyright (c) 2011 Matmon Internet, Inc., released under the New BSD License
