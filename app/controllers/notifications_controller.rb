class NotificationsController < ApplicationController
  def index
    current_user.notifications.update_all(read: true)
  end
end
