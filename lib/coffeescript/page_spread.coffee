module.exports = class PageSpread
    constructor: (@el, @options = {}) ->
        @visibility = 'gone'
        @active = false
        @positioned = false
        @width = @options.width
        @left = @options.left
        @maxZoomScale = @options.maxZoomScale

        return

    isZoomable: ->
        @getMaxZoomScale() > 1

    getContentEl: ->
        @el.querySelector '.verso-page-spread__content'

    getWidth: ->
        @width

    getLeft: ->
        @left

    getMaxZoomScale: ->
        @maxZoomScale

    getVisibility: ->
        @visibility

    setVisibility: (visibility) ->
        if @visibility isnt visibility
            @el.style.display = if visibility is 'visible' then 'block' else 'none'

            @visibility = visibility

        @

    setActive: (isActive = false) ->
        @active = isActive
        @el.dataset.active = isActive

        @

    position: ->
        if @positioned is false
            @el.style.left = "#{@getLeft()}%"

            @positioned = true

        @
