json.extract! event, :id, :name, :scheduledDate, :runDate, :created_at, :updated_at
json.url event_url(event, format: :json)