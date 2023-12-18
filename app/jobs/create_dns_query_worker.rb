class CreateDnsQueryWorker < ApplicationJob
  def perform(**attributes)
    DnsQuery.create!(**attributes)
  end
end
