class Awesome.PostsController extends Batman.Controller
  routingKey: 'posts'

  index: (params) ->
    Awesome.Post.load (err, results) =>
      throw err if err

      # Results is an IOU
      @set 'posts', Awesome.Post.get('loaded')

  show: (params) ->
    # Create blank comment
    Awesome.set 'controllers.comments.comment',
      new Awesome.Comment(post_id: params.id)

    Awesome.Post.find parseInt(params.id, 10), (err, record) =>
      throw err if err

      @set 'post', record

  new: (params) ->
    @set 'post', new Awesome.Post

  create: (params) ->
    @get('post').save (err) =>
      throw err if err

      @redirect '/posts'

  edit: (params) ->
    Awesome.Post.find parseInt(params.id, 10), (err, record) =>
      throw err if err

      @set 'post', record

  update: (params) ->
    @get('post').save (err) =>
      throw err if err

      @redirect '/posts'

  destroy: (node, callback, context) ->
    context.get('post').destroy (err) =>
      throw err if err

      @redirect '/posts'
