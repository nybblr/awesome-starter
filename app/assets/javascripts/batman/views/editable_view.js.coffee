class Awesome.EditableView extends Batman.View
  @option 'keypath', 'record'

  constructor: ->
    super # process arguments/etc
    @node = $(@get 'node')

  ready: ->
    return unless @node?

    # Add editableness
    @node.attr('contenteditable', 'true')

    # Get keypath as actual Keypath object
    keypath = @get('argumentBindings.keypath').keyPath

    # Now get the actual property
    try
      @prop = @context.contextForKey(keypath).property(keypath)

    if @prop
      @prop.observeAndFire (newValue, oldValue) =>
        value = @prop.getValue()
        html  = @node.html()
        if value isnt html
          @node.html value

      @node
      .focus (event) =>
        self = $(event.target)
        self.data 'before', self.html()
        @prop.setValue self.html()
      .on 'blur keyup keydown paste hallomodified', (event) =>
        self = $(event.target)
        html  = self.html()
        if self.data('before') isnt html
          self.data 'before', self.html()
          @prop.setValue self.html()
          self.trigger 'change'
      .on 'blur', (event) =>
        @get('record').save()
      .hallo
        plugins:
          "halloformat": {}
          "hallolists": {}
