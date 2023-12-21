class DnsQueriesController < ApplicationController
  # GET /dns_queries
  def index
    @stats = DnsQuery.stats_for(helpers.search_time_frame)
  end
end
