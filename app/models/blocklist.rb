class Blocklist < ApplicationRecord
  has_many :dns_records, dependent: :destroy, inverse_of: :blocklist

  validates :url, presence: true, url: true, uniqueness: true

  def refresh
    FetchBlocklistWorker.perform_later(id)
  end
end
