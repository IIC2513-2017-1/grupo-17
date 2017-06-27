# frozen_string_literal: true

json.users do
  json.array! @users do |user|
    json.id user.id
    json.href api_v1_user_url(user)
    json.username @user.username
    json.email @user.email
    json.is_admin @user.is_admin
  end
end
