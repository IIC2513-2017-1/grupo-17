module Api::V1
  class ApiController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    protected

    def authenticate
      authenticate_or_request_with_http_token do |token, _options|
        @current_user = User.find_by(api_token: token)
      end
    end
  end
end
