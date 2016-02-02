class RegistrationController < ApplicationController
  def token
   @token = CANADA_POST_SERVICE.registration
  end
end
