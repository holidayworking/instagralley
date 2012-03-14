((window, $, PhotoSwipe) ->
    $(document).bind 'mobileinit', ->
        $('.gallery-page').live('pageinit', (e) ->
            currentPage = $(e.target)
            options =
                getImageMetaData: (el) ->
                    relatedUrl: el.getAttribute('data-related-url')
                captionAndToolbarShowEmptyCaptions: false
            photoSwipeInstance = $('ul.gallery a', e.target).photoSwipe(options, currentPage.attr('id'))
            photoSwipeInstance.addEventHandler PhotoSwipe.EventTypes.onTouch, (e) ->
                if e.action is 'tap'
                    currentImage = photoSwipeInstance.getCurrentImage()
                    window.open currentImage.metaData.relatedUrl
        ).live 'pageremove', (e) ->
            currentPage = $(e.target)
            photoSwipeInstance = PhotoSwipe.getInstance(currentPage.attr('id'))
            PhotoSwipe.detatch photoSwipeInstance if typeof photoSwipeInstance isnt 'undefined' and photoSwipeInstance?
            true
) window, window.jQuery, window.Code.PhotoSwipe
