class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless url_valid?(value)
      record.errors[attribute] << (options[:message] || "must be a valid URL")
    end
  end

  # a URL may be technically well-formed but may
  # not actually be valid, so this checks for both.
  def url_valid?(url)
    url =
      begin
        URI.parse(url)
      rescue StandardError
        false
      end
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end