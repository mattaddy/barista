class @Barista

class @Barista.Application
  global_components = 'app'

  constructor: ->
    @vent = new Barista.EventAggregator()
    @reqres = new Barista.ReqRes()

  start: ->
    controller = $('body').data('controller')
    action = $('body').data('action')
    @routes[global_components]()
    @exec controller
    @exec controller, action

  exec: (controller, action) ->
    action = if (action is 'undefined') then "init" else action
    @routes[controller][action]() if controller isnt "" and @routes[controller] and typeof @routes[controller][action] is "function"

  routes: (r) ->
    @routes = r

class @Barista.Component
  constructor: (options) ->
    @el = options.el || undefined
    this.bindEvents()
    this.initialize() if this.initialize

  bindEvents: ->
    for event, fn of @events
      [ev, selector] = event.split(" ").filter (word) -> word isnt ""
      $(document).on ev, "#{@el} #{selector}", this[fn]

  $: (selector) ->
    $("#{@el} #{selector}")

class @Barista.EventAggregator
  bind: (event, args, fn) ->
    $(this).bind event, args, fn

  trigger: (event, args) ->
    $(this).trigger event, args

class @Barista.ReqRes
  request: (event) ->
    $(this).triggerHandler event

  register: (event, fn) ->
    $(this).bind event, fn
