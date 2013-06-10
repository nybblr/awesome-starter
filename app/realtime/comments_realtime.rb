require 'net/http'

class CommentsRealtime < ActiveRecord::Observer
  observe :comment

  def publish channel, data
    uri = URI.parse("http://localhost:9292/faye")
    msg = {channel: channel, data: data}
    Net::HTTP.post_form(uri, :message => msg.to_json)
  end

  def after_create(comment)
    publish "/comments/created", comment.attributes
    puts "=== CREATING ==="
  end

  def after_update(comment)
    publish "/comments/updated", comment.attributes
    puts "=== UPDATING ==="
  end

  def after_destroy(comment)
    publish "/comments/destroyed", :id => comment.id
    puts "=== DESTROYING ==="
  end
end
