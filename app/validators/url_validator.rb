class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    puts "VALIDATING ====== #{value}"
    begin
      uri = URI.parse(value)
      resp = uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      resp = false
    end
    unless resp == true
      puts "INVALID!"
      record.errors[attribute] << (options[:message] || "is not a url")
    end
  end
end
