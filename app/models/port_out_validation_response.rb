require 'active_support'
class PortOutValidationResponse
  attr_accessor :errors

  def initialize()
    @error_Codes = [
      {
        "Code" => 7510,
        "Description" => "Required Account Code missing"
      },
       {
        "Code" => 7511,
        "Description" => "Invalid Account Code"
      },
       {
        "Code" => 7512,
        "Description" => "Required PIN missing"
      },
       {
        "Code" => 7513,
        "Description" => "PIN invalid"
      },
       {
        "Code" => 7514,
        "Description" => "Required ZIP Code missing"
      },
       {
        "Code" => 7515,
        "Description" => "Invalid ZIP Code"
      },
       {
        "Code" => 7516,
        "Description" => "Telephone Number not recognized or invalid for this account"
      },
       {
        "Code" => 7517,
        "Description" => "Too many Telephone numbers in this request"
      },
        {
        "Code" => 7518,
        "Description" => "Telephone Number not active"
      },
        {
        "Code" => 7519,
        "Description" => "Customer info does not match"
      },
        {
        "Code" => 7598,
        "Description" => "Invalid Request"
      },
        {
        "Code" => 7599,
        "Description" => "Fatal Error in Processing"
      },
    ]
    @acceptable_values = {
      "Pin" => 2222,
      "AccountNumber" => 555,
      "ZipCode" => 02154,
      "TelephoneNumbers" => [{"TelephoneNumber" => 2223331000}]
    }

    @data = {}
  end

  def portable=(value)
    @data["Portable"] = value
  end
  def pon=(value)
    @data["PON"] = value
  end
  
  def to_xml()
    if @data.key? "Errors"
      @data["AcceptableValues"] = @acceptable_values
    end
    @data.to_xml :root => self.class
  end

  
  def add_error(code)
    if !@data.key?("Errors")
      @data["Errors"] = [] 
    end
    @error_Codes.each do |item|
      if item["Code"] == code
        @data["Errors"] << item
      end
    end
  end

end
