json.array!(@comments) do |comment|
  json.extract! comment, *comment.attribute_names
  json.url comment_url(comment, format: :json)
end
