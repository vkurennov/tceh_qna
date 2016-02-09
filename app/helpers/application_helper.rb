module ApplicationHelper
  def collection_cache_key_for(model)
    klass = model.to_s.capitalize.constantize
    #count = klass.count
    max_updated_at = klass.maximum(:updated_at).try(:utc).try(:to_i)
    "#{model.to_s.pluralize}/collection-#{max_updated_at}"
  end
end
