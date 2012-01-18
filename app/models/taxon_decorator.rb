module Spree
  Taxon.class_eval do
    scope :featured, where("featured = ?", true)
  end
end
