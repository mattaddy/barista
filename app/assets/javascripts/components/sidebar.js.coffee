class @Sidebar extends @Barista.Component
  initialize: ->
    App.vent.bind 'header:clicked', @report_clicks

  events:
    'click #search': 'perform_search'

  report_clicks: (e, number_of_clicks) =>
    suffix = if number_of_clicks == 1 then "time" else "times"
    @$('#number_of_clicks').html "You clicked the header #{number_of_clicks} #{suffix}."

  perform_search: (e) =>
    search_term = @$('#search_term').val()
    App.vent.trigger 'search:done', search_term
