json.array!(@comments) do |comment|
  json.extract! comment, :post_id, :author, :body
  json.url comment_url(comment, format: :json)
end