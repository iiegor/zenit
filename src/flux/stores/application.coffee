Reflux = require 'reflux'
Actions = require '../actions/application'

cache =
  views: []

views = [
  require '../../views/get-started'
]

Store = Reflux.createStore(
  init: ->
    @listenToMany(Actions)

  onLoadView: (view) ->
    views = []
    view = [view] if typeof view != 'object'

    view.map (viewName) =>
      cache.views[viewName] ?= require "../../views/#{viewName}"

      views.push cache.views[viewName]

    # Save actual views
    localStorage.setItem('zenit:last-view', view.join(','))

    # Emit changes
    @trigger()

  getViews: ->
    views
)

module.exports = Store