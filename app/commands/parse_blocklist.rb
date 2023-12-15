class ParseBlocklist
  def self.call(blocklist)
    new(blocklist).call
  end

  def initialize(blocklist)
    @blocklist = blocklist
  end

  def call
    dns_record_data =
      blocklist
        .each_line
        .map do |line|
          line.strip!
          next if line.start_with?("#") || line.blank?

          ip_address, domain, *_rest = line.split(" ")

          unless Resolv::IPv4::Regex.match?(ip_address) ||
                   Resolv::IPv6::Regex.match?(ip_address)
            domain = ip_address
            ip_address = "0.0.0.0"
          end

          [domain, ip_address]
        end
        .compact

    Result.new(dns_record_data)
  rescue StandardError => e
    Result.new(nil, e.message)
  end

  private

  attr_reader :blocklist
end
