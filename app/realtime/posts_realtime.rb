require 'net/http'

class PostsRealtime < ActiveRecord::Observer
  observe :post

  def publish channel, data
    uri = URI.parse("http://localhost:9292/faye")
    msg = {channel: channel, data: data}
    Net::HTTP.post_form(uri, :message => msg.to_json)
  end

  def after_create(post)
    publish "/posts/created", post.attributes
    puts "=== CREATING ==="
  end

  def after_update(post)
    publish "/posts/updated", post.attributes
    puts "=== UPDATING ==="
  end

  def after_destroy(post)
    publish "/posts/destroyed", :id => post.id
    puts "=== DESTROYING ==="
  end
end
