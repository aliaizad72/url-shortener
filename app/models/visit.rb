class Visit < ApplicationRecord
  belongs_to :url, counter_cache: true

  default_scope { order(created_at: :desc) }
end
