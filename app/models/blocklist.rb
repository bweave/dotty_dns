class Blocklist < ApplicationRecord
  validates :url, presence: true, url: true, uniqueness: true
end
