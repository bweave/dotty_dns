class ParseBlocklist
  def self.call(blocklist, blocklist_id)
    new(blocklist, blocklist_id).call
  end

  def initialize(blocklist, blocklist_id)
    @blocklist = blocklist
    @blocklist_id = blocklist_id
  end

  def call
    dns_record_data =
      blocklist
        .each_line # .map do |line|
        .each_with_object({}) do |line, acc|
          line.strip!
          next if line.start_with?("#") || line.blank?

          ip_address, domain, *_rest = line.split(" ")

          unless Resolv::IPv4::Regex.match?(ip_address) ||
                   Resolv::IPv6::Regex.match?(ip_address)
            domain = ip_address
            ip_address = "0.0.0.0"
          end

          # [domain, ip_address]
          next if domain.blank? || ip_address.blank?
          acc[domain] = { domain:, ip_address:, blocklist_id: }
          acc
        end
        .values
    # .compact

    Result.new(dns_record_data)
  rescue StandardError => e
    Result.new(nil, e.message)
  end

  private

  attr_reader :blocklist, :blocklist_id
end
