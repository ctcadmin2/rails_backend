JSONAPI.configure do |config|
  #:underscored_key, :camelized_key, :dasherized_key, or custom
  config.json_key_format = :underscored_key

  # Pagination   :none, :offset, :paged, or a custom paginator name
  config.default_paginator = :none
  config.default_page_size = 5
  config.maximum_page_size = 20

  # Metadata
  # Output record count in top level meta for find operation
  config.top_level_meta_include_record_count = true
  config.top_level_meta_record_count_key = :item_count
  config.top_level_meta_include_page_count = true
end
