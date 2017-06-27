# frozen_string_literal: true

json.notifications do
  json.array! @current_user.notifications do |notification|
    json.id notification.id
    #json.href api_v1_notification_url(notification)
    json.title notification.title
    json.description notification.description
    json.url notification.url
    json.read notification.read
  end
end
