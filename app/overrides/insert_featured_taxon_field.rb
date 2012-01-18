Deface::Override.new(:virtual_path => "spree/admin/taxons/_form",
  :name => 'insert_featured_taxon_field',
  :insert_bottom => "[data-hook='admin_inside_taxon_form']",
  :text => %q{
    <%= f.field_container :featured do %>
      <%= f.label :featured, t(:featured) %><br />
      <%= f.check_box :featured %>
    <% end %>
  }
)
