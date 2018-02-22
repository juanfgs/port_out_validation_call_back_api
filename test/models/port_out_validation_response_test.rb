require 'test_helper'
require 'nokogiri'

class PortOutValidationResponseTest < ActiveSupport::TestCase

  test "returns an xml" do
    response = PortOutValidationResponse.new
    assert_nothing_raised do
      xml = Nokogiri::XML(response.to_xml)
    end
  end

  test "adds errors to XML" do
    response = PortOutValidationResponse.new
    response.add_error(7518)
    xml = Nokogiri::XML(response.to_xml)
    assert xml.xpath("//Error").count != 0
  end


  test "if there are errors should present a sample of acceptable values" do
    response = PortOutValidationResponse.new
    response.add_error(7518)
    xml = Nokogiri::XML(response.to_xml)
    assert xml.xpath("//AcceptableValues").count != 0

  end
end
