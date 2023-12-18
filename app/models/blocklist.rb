class Blocklist < ApplicationRecord
  include ActionView::Helpers::TagHelper

  has_many :dns_records, dependent: :destroy, inverse_of: :blocklist

  enum status: { fetching: 0, parsing: 1, done: 2, failed: 3 }

  validates :url, presence: true, url: true, uniqueness: true

  broadcasts_to ->(_blocklist) { "blocklists" }

  def refresh
    FetchBlocklistWorker.perform_later(id)
  end

  def status_for_display
    {
      fetching: tag.span("aria-busy": true),
      parsing: tag.span("aria-busy": true),
      done: "",
      failed: "🚫"
    }[
      status.to_sym
    ]
  end
end
