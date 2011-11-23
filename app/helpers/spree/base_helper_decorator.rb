Spree::BaseHelper.module_eval do

  def featured_taxon_list(featured_taxons = Taxon.featured, current_taxon)
    return '' if featured_taxons.size < 1 
    content_tag :ul, :class => 'taxons-list' do
      featured_taxons.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
        content_tag :li, :class => css_class do
         link_to(taxon.name, seo_url(taxon)) 
        end
      end.join("\n").html_safe
    end
  end

end