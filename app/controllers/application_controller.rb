class ApplicationController < ActionController::Base
    # app/controllers/application_controller.rb に追記
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token
end
