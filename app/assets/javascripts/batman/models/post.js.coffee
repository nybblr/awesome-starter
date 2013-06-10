class Awesome.Post extends Batman.Model
  @resourceName: 'post'
  @storageKey: 'posts'

  @persist Batman.RailsStorage

  @encode 'title', 'body', 'tags', 'published', 'published_on'

  # Associations
  @hasMany 'comments', { inverseOf: 'post', saveInline: false }

  # Load Robin
  @set 'robin', new Batman.Robin(@)
