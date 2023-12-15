class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!

  add_flash_types :info, :error, :success
end
