class NotificationsController < ApplicationController
  before_action :require_login

  def index
    current_user.notifications.update_all(read: true)
  end
end
