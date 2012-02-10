Deface::Override::new({
    :virtual_path => 'spree/shared/_taxonomies',
    :name => 'append_featured_taxons_to_sidebar',
    :insert_after => '#taxonomies:last-child',
    :text => %q{

<%= content_tag :div, "id" => 'featured-taxons', "data-hook" => "featured-taxons" do %>
  <%= content_tag :h6, :class => 'featured-taxon-root' do %>
    <%= t(:featured) %>
  <% end %>
  <%= featured_taxon_list(featured_taxons, :current => @taxon) %>
<% end %>

  }

})
