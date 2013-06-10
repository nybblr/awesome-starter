class Awesome.Comment extends Batman.Model
  @resourceName: 'comment'
  @storageKey: 'comments'

  @persist Batman.RailsStorage

  @encode 'post_id', 'author', 'body'

  # Associations
  @belongsTo 'post', { inverseOf: 'comments' }

  # Nesting
  @urlNestsUnder 'post'

  # Load Robin
  @set 'robin', new Batman.Robin(@)
