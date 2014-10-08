class @Header extends @Barista.Component
  initialize: ->
    @number_of_clicks = 0

  events:
    'click #clickable': 'increment_clicks'

  increment_clicks: (e) =>
    @number_of_clicks++
    App.vent.trigger 'header:clicked', @number_of_clicks
