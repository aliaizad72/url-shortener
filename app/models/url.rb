class Url < ApplicationRecord
  validates :target, presence: true
  validates :title, presence: true
end
