require 'nokogiri'
require 'pp'
class PortOutValidationRequestService
  attr_accessor :errors, :xml
  ERROR_MISSING_ACCOUNT_CODE=7510
  ERROR_INVALID_ACCOUNT_CODE=7511
  ERROR_MISSING_PIN=7512
  ERROR_INVALID_PIN=7513
  ERROR_MISSING_ZIP_CODE=7514
  ERROR_INVALID_ZIP_CODE=7515
  ERROR_INVALID_TELEPHONE=7516
  ERROR_INVALID_REQUEST=7598
  
  def initialize(request)
    @valid = true
    @errors = []
    begin
      @xml = Nokogiri::XML(request) { |config| config.strict}
    rescue Nokogiri::XML::SyntaxError
      @valid = false
      @errors << ERROR_INVALID_REQUEST
    end

    if @valid
      self.validate_fields
   end
  end

  def phones
    @xml.xpath("//TelephoneNumbers")
  end
  
  def has_field(field)
    @xml.at_css(field) != nil
  end
  
  def field(field)
    @xml.at_css(field).content.to_s
  end
  
  def validate_fields
    if self.phones.count == 0
      @valid = false
      @errors << ERROR_INVALID_TELEPHONE
    end
    if !has_field("AccountNumber")
      @valid = false
      @errors << ERROR_MISSING_ACCOUNT_CODE
    elsif !field("AccountNumber").to_s.to_i
      @valid = false
      @errors << ERROR_INVALID_ACCOUNT_CODE
    end
    if !has_field("Pin")
      @valid = false
      @errors << ERROR_MISSING_PIN
    end
    if !has_field("ZipCode")
      @valid = false
      @errors << ERROR_MISSING_ZIP_CODE
    end
  end

  def valid?
    @valid
  end
end
