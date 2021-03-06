json.array!(@posts) do |post|
  json.extract! post, :title, :body, :tags, :published, :published_on
  json.url post_url(post, format: :json)
end