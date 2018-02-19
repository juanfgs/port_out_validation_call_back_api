class CallbacksController < ApplicationController
=begin
  def portOutValidationCallbackApi
    render inline: "<%= Account.all.each{ |a| puts a } %>"
  end
=end
  def show
    render "hola"
  end

end
