json.extract! user, :id, :name, :api_key, :api_key_secret, :email, :encrypted_password, :salt, :created_at, :updated_at
json.url user_url(user, format: :json)
