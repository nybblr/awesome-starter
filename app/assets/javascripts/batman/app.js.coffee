class window.Awesome extends Batman.App
  @title = "I'm Awesome."

  Batman.config.pathToHTML = 'assets/batman/templates'

  # Prevent DOM flickering.
  Batman.DOM.Yield.clearAllStale = -> {}

  # Define routes
  @resources 'posts', ->
    @resources 'comments'

  @root 'posts'

  @on 'run', ->
    Batman.developer.log "Running..."

    # Initialize sockets, connections, etc
    # Can't do anything DOM related

    # Open Faye socket for push
    Batman.developer.log "Opening socket..."
    @socket = new Faye.Client $('meta[name="faye-url"]').attr('content')

    # Notify Robin that it can subscribe
    Batman.Robin.fire('socket:ready')

  @on 'ready', ->
    Batman.developer.log "Awesome, we're ready."

    # Anything DOM related.
