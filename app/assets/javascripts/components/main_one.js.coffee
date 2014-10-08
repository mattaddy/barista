class @MainOne extends @Barista.Component
  initialize: ->
    App.vent.bind 'search:done', @show_search_term

  show_search_term: (e, search_term) =>
    @$('#search_results').html "You entered: #{search_term}"
