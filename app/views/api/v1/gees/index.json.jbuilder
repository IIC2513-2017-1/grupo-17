# frozen_string_literal: true

json.gees do
  json.array! @gees do |gee|
    json.partial! 'gee', gee: gee
  end
end
json.prev_page api_v1_gees_url(page: params[:page].to_i-1) if params[:page].to_i > 1
json.next_page api_v1_gees_url(page: params[:page].to_i+1)
