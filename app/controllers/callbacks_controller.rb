class CallbacksController < ApplicationController
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
      format.xml { render :xml => @account.to_xml,
        :layout => false
      }
    end
  end

end
