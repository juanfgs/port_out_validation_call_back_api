class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :xml
=begin
  def portOutValidationCallbackApi
    render inline: "<%= Account.all.each{ |a| puts a } %>"
  end
=end
  def show()
    @account = Account.find(params[:id])
    respond_with do |format|
      format.html
      format.xml { render :xml =>
                          @account.to_xml(
                            :camelize => true,
                            :methods => "PON",
                            :except => [:pon, :created_at, :updated_at ] ),
        :layout => false
      }
    end
  end

  def portOutValidationCallbackApi()
    @validation_service = PortOutValidationRequestService.new request.body.read
    @validation_response = PortOutValidationResponse.new
    if @validation_service.errors.count > 0
      @validation_service.errors.each do |code|
        @validation_response.add_error code
      end
    else
      if Account.exists?(account_number: @validation_service.field("AccountNumber"))
        @account = Account.where(account_number: @validation_service.field("AccountNumber")).first
        @validation_response.portable = true 
        @validation_response.pon = @account.pon
      else
        @validation_response.add_error PortOutValidationRequestService::ERROR_INVALID_ACCOUNT_CODE
      end
    end
    
    respond_with do |format|
      format.html
      format.xml { render :xml =>
                          @validation_response.to_xml(
                         ),
                          
                          :layout => false
      }
    end
  
  end

  
end
