json.id @bet.id
json.owner @bet.user.username
json.gee @gee.name
json.quantity @bet.quantity
json.fields @fields.pluck(:name)
json.values @bet.values.map { |v| v.value }
