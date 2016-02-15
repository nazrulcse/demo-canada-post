class RegistrationController < ApplicationController
  def token
   @token = CANADA_POST_SERVICE.registration
  end

  def callback
    if params['registration-status'] == 'SUCCESS'
      @response = CANADA_POST_SERVICE.get_merchant_info(params['token-id'])
    else
      @response = {token: params['token-id'], registration_status: params['registration-status']}
    end
  end
end
