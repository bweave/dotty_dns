class IpAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[
      attribute
    ] = "is not a valid IPv4 or IPv6 address" unless valid?(value)
  end

  def valid?(value)
    Resolv::IPv4::Regex.match?(value) || Resolv::IPv6::Regex.match?(value)
  end
end
