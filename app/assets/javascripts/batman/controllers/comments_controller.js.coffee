class Awesome.CommentsController extends Batman.Controller
  routingKey: 'comments'

  create: (params) ->
    @get('comment').save (err) =>
      throw err if err

      # Reset blank comment
      @set 'comment', new Awesome.Comment(post_id: @get('comment.post.id'))
