Events = require './events'

module.exports = class Verso extends Events
    defaults:
        transition: 'horizontal-slide'
        pageIndex: 0

    initialized: false

    constructor: (@el, options = {}) ->
        super()

        for key, value of @defaults
            @[key] = options[key] ? value

        @pages = Array.prototype.slice.call @el.querySelectorAll('.verso__page'), 0

        return

    init: ->
        return if @initialized is true

        @trigger 'beforeInit'

        @updateState()

        @el.dataset.transition = @transition
        @el.dataset.ready = 'true'
        @el.setAttribute 'tabindex', -1
        @el.focus()

        @initialized = true

        @trigger 'init'

        @

    go: (pageIndex) ->
        return if isNaN(pageIndex) or pageIndex < 0 or pageIndex > @getPageCount() - 1

        from = @pageIndex
        to = pageIndex

        @trigger 'beforeChange', from, to

        @pageIndex = to
        @updateState()

        @trigger 'change', from, to

        return

    prev: ->
        @go @pageIndex - 1

        return

    next: ->
        @go @pageIndex + 1

        return

    getPageCount: ->
        @pages.length

    updateState: ->
        @pages[@pageIndex].dataset.state = 'current'
        @pages[@pageIndex].setAttribute 'aria-hidden', false

        if @pageIndex > 0
            @pages[@pageIndex - 1].dataset.state = 'previous'
            @pages[@pageIndex - 1].setAttribute 'aria-hidden', true

        if @pageIndex + 1 < @getPageCount()
            @pages[@pageIndex + 1].dataset.state = 'next'
            @pages[@pageIndex + 1].setAttribute 'aria-hidden', true

        if @pageIndex > 1
            @pages.slice(0, @pageIndex - 1).forEach (el) ->
                el.dataset.state = 'before'
                el.setAttribute 'aria-hidden', true

                return

        if @pageIndex + 2 < @getPageCount()
            @pages.slice(@pageIndex + 2).forEach (el) ->
                el.dataset.state = 'after'
                el.setAttribute 'aria-hidden', true

                return

        return
