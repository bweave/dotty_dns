class FetchBlocklist
  def self.call(url)
    new(url).call
  end

  def initialize(url)
    @url = url
  end

  def call
    # TODO: probably need some error handling here
    # TODO: maybe use a gem instead, like HTTParty or Faraday
    raw_blocklist = Net::HTTP.get(URI.parse(url))
    Result.new(raw_blocklist)
  rescue StandardError => e
    Result.new(nil, e)
  end

  private

  attr_reader :url
end
