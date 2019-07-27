json.extract! order, :id, :number, :qty, :total, :user_id, :state, :created_at, :updated_at
json.url order_url(order, format: :json)
