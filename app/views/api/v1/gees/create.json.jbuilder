# frozen_string_literal: true

if !@success
  json.error 'There was an error'
else
  json.gee
    json.partial! gee: @gee
  end
end
