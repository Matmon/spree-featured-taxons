Spree::BaseHelper.module_eval do

  def featured_taxon_list(taxons, *args, &b)
    return '' if taxons.empty?
    opt        = args.extract_options!
    list_id    = opt.fetch(:id)    { 'featured-taxons' }
    list_class = opt.fetch(:class) { 'taxons-list' }
    current    = opt.fetch(:current).self_and_ancestors rescue []

    content_tag :ul, :id => list_id, :class => list_class do
      taxons.map do |taxon|
        item_class = current.include?(taxon) ? 'current' : nil
        content_tag :li, :class => item_class do
          block_given? ? b.call(taxon) : link_to(taxon.name, seo_url(taxon))
        end
      end.join("\n").html_safe
    end
  end

end
