Taxon.class_eval do 
	scope :featured, :conditions => ['featured = ?', true]
end