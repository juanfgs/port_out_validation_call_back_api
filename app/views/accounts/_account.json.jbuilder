json.extract! account, :id, :pon, :pin, :account_number, :zip_code, :subscriber_name, :created_at, :updated_at
json.url account_url(account, format: :json)
