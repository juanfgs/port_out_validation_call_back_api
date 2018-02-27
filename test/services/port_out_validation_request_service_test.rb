require 'test_helper'
require 'pp'
require 'nokogiri'


class PortOutValidationRequestServiceServiceTest < ActiveSupport::TestCase
  def test_request
    <<~HEREDOC
    <?xml version="1.0"?>
          <PortOutValidationRequestService>
                <PON>some_pon</PON>
                <Pin>1111</Pin>
                <AccountNumber>777</AccountNumber>
                <ZipCode>62025</ZipCode>
                <SubscriberName>Subscriber Name</SubscriberName>
                <TelephoneNumbers>
                        <TelephoneNumber>2223331000</TelephoneNumber>
                        <TelephoneNumber>2223331001</TelephoneNumber>
                </TelephoneNumbers>
          </PortOutValidationRequestService>
    HEREDOC
  end
  
  
  test "if given an invalid XML return invalid" do
    request = PortOutValidationRequestService.new("gibberissh<%><<<>")
    assert request.valid? === false
  end
  

  test "if invalid return error code" do
    request = PortOutValidationRequestService.new("gibberissh<%><<<>")
    assert request.errors.count > 0
    assert request.errors.include? 7598

   end

  test "validate presence of telephone numbers" do
    recdata = <<~HEREDOC
    <?xml version="1.0"?>
          <PortOutValidationRequestService>
                <PON>some_pon</PON>
                <Pin>1111</Pin>
                <AccountNumber>777</AccountNumber>
                <ZipCode>62025</ZipCode>
                <SubscriberName>Subscriber Name</SubscriberName>
          </PortOutValidationRequestService>
    HEREDOC
    
    request = PortOutValidationRequestService.new(recdata)
    assert request.errors.count > 0
    assert request.errors.include? 7516
  end

  test "validate account code presence" do
    recdata = <<~HEREDOC
    <?xml version="1.0"?>
          <PortOutValidationRequestService>
                <PON>some_pon</PON>
                <Pin>1111</Pin>
                <ZipCode>62025</ZipCode>
                <SubscriberName>Subscriber Name</SubscriberName>
                <TelephoneNumbers>
                        <TelephoneNumber>2223331000</TelephoneNumber>
                        <TelephoneNumber>2223331001</TelephoneNumber>
                </TelephoneNumbers>
          </PortOutValidationRequestService>
    HEREDOC
    request = PortOutValidationRequestService.new(recdata)
    assert request.errors.count > 0
    assert request.errors.include? 7510

  end

  test "validate PIN presence" do
    recdata = <<~HEREDOC
    <?xml version="1.0"?>
          <PortOutValidationRequestService>
                <PON>some_pon</PON>
                <ZipCode>62025</ZipCode>
                <SubscriberName>Subscriber Name</SubscriberName>
                <AccountNumber>777</AccountNumber>
                <TelephoneNumbers>
                        <TelephoneNumber>2223331000</TelephoneNumber>
                        <TelephoneNumber>2223331001</TelephoneNumber>
                </TelephoneNumbers>
          </PortOutValidationRequestService>
    HEREDOC
    request = PortOutValidationRequestService.new(recdata)
    assert request.errors.count > 0
    assert request.errors.include? 7512

  end

    test "validate ZIP Code presence" do
    recdata = <<~HEREDOC
    <?xml version="1.0"?>
          <PortOutValidationRequestService>
                <PON>some_pon</PON>
                <SubscriberName>Subscriber Name</SubscriberName>
                <AccountNumber>777</AccountNumber>
                <TelephoneNumbers>
                        <TelephoneNumber>2223331000</TelephoneNumber>
                        <TelephoneNumber>2223331001</TelephoneNumber>
                </TelephoneNumbers>
          </PortOutValidationRequestService>
    HEREDOC
    request = PortOutValidationRequestService.new(recdata)
    assert request.errors.count > 0
    assert request.errors.include? 7514

  end

    test "validate valid Account Code" do
    recdata = <<~HEREDOC
    <?xml version="1.0"?>
          <PortOutValidationRequestService>
                <PON>some_pon</PON>
                <SubscriberName>Subscriber Name</SubscriberName>
                <AccountNumber>foobar</AccountNumber>
                <TelephoneNumbers>
                        <TelephoneNumber>2223331000</TelephoneNumber>
                        <TelephoneNumber>2223331001</TelephoneNumber>
                </TelephoneNumbers>
          </PortOutValidationRequestService>
    HEREDOC
    request = PortOutValidationRequestService.new(recdata)
    assert request.errors.count > 0
    assert request.errors.include? 7511

  end

     
end
