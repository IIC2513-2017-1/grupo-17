# frozen_string_literal: true

json.user do
  json.id @user.id
  json.href api_v1_user_url(@user)
  json.username @user.username
  json.email @user.email
  json.is_admin @user.is_admin
  json.gees do
    json.array! @user.gees do |gee|
      json.id gee.id
      json.href api_v1_gee_url(gee)
      json.name gee.name
      json.expiration_date gee.expiration_date
    end
  end
end
