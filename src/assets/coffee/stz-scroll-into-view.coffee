stzScrollIntoView.directive 'stzScrollIntoView',
  ($timeout) ->
    SETTINGS =
      IS_DEFAULT_WATCHER_PARAM: null
      IS_IMAGES: null
      IS_NG_REPEAT: null
      SCROLL_TO_ELEMENT: null
      PARENT_ID: null
      SCOPE: null

    API =
      imagesLoaded: 0
      ngRepeated: false
      imgLoaded: false
      defaultParamChanged: false
      allImages: 0
      watchers:
        ngRepeatLoad:
          on: angular.noop
        imagesLoad:
          on: angular.noop
      init: ->
        switch
          when not SETTINGS.IS_DEFAULT_WATCHER_PARAM
            # at this step we might need to check for:
            # ngRepeat
            # NgSrc
            switch
              when SETTINGS.IS_NG_REPEAT
                if SETTINGS.IS_IMAGES
                  API.initImagesLoadWatcher ->
                    API.setImgLoaded()
                    if API.ngRepeated and API.defaultParamChanged
                      API.scrollToElementView()
                    return
                API.initNgRepeatLoadWatcher ->
                  if SETTINGS.IS_IMAGES
                    API.setAllImagesLength()
                  API.setNgRepeated()
                  if API.defaultParamChanged
                    API.scrollToElementView()
                  return
              when SETTINGS.IS_IMAGES
                API.setAllImagesLength()
                API.initImagesLoadWatcher ->
                  API.setImgLoaded()
                  if API.defaultParamChanged
                    API.scrollToElementView()
                  return
            API.initDefaultWatcher ->
              unless API.defaultParamChanged
                API.setDefaultParamChanged()
              # fixes coffee switch statement compile error, wighout temp compiles into "switch(a.defaultParamChanged||a.setDefaultParamChanged(),!1){}"
              temp = switch
                when SETTINGS.IS_NG_REPEAT
                  if SETTINGS.IS_IMAGES
                    if API.ngRepeated and API.imgLoaded
                      API.scrollToElementView()
                  else
                    if API.ngRepeated
                      API.scrollToElementView()
                when SETTINGS.IS_IMAGES
                  if API.imgLoaded
                    API.scrollToElementView()
                else
                  API.scrollToElementView()
          when SETTINGS.IS_NG_REPEAT
            # at this step we might need to check for:
            # NgSrc
            if SETTINGS.IS_IMAGES
              API.initImagesLoadWatcher ->
                API.setImgLoaded()
                API.scrollToElementView()
            API.initNgRepeatLoadWatcher ->
              if SETTINGS.IS_IMAGES
                API.setAllImagesLength()
              API.setNgRepeated()
          when SETTINGS.IS_IMAGES
            # at this step we don't need to check for anything:
            API.setAllImagesLength()
            API.initImagesLoadWatcher ->
              API.setImgLoaded()
              API.scrollToElementView()
          else
            # at this step we don't have any extra delayed watchers, straight scroll to an element
            API.scrollToElementView()

      initImagesLoadWatcher: (callback)->
        API.watchers.imagesLoad.on = (ele, loadingClasses)->
          $timeout ->
            if loadingClasses is "stz-s-i-v-ele" and +API.allImages isnt 0
              if ++API.imagesLoaded is +API.allImages
                callback()
          , 0 , false

      initNgRepeatLoadWatcher: (callback)->
        API.watchers.ngRepeatLoad.on = (ele,attrs)->
          $timeout ->
            callback()
          , 0, false

      initDefaultWatcher: (callback)->
        SETTINGS.SCOPE.$watch 'scrollParam', (n)->
          if angular.isDefined n
            callback()

      setAllImagesLength: ->
        API.allImages = document.querySelectorAll("[stz-s-i-v-ele]").length

      setNgRepeated: ->
        API.ngRepeated = true

      setImgLoaded: ->
        API.imgLoaded = true

      setDefaultParamChanged: ->
        API.defaultParamChanged = true

      scrollToElementView: ->
        SETTINGS.SCROLL_TO_ELEMENT = document.querySelector "[stz-s-i-v-ele='#{if SETTINGS.IS_DEFAULT_WATCHER_PARAM then 'true' else SETTINGS.SCOPE.scrollParam}']"
        if SETTINGS.SCROLL_TO_ELEMENT?
          SETTINGS.SCROLL_TO_ELEMENT.scrollIntoView true
          switch
            when typeof SETTINGS.PARENT_ID is 'string'
              document.querySelector(SETTINGS.PARENT_ID).scrollTop = 0
            when typeof SETTINGS.PARENT_ID is 'object'
              if typeof SETTINGS.PARENT_ID.scrollTop is 'number'
                SETTINGS.PARENT_ID.scrollTop = 0
              else
                document.body.scrollTop = 0
            else
              document.body.scrollTop = 0
          API.imagesLoaded = 0

    restrict: 'A'
    scope:
      scrollParam: '=stzScrollIntoView'
    controller: ($scope)->
      @onStzNgRepeatFinished = (ele, attrs)->
        API.watchers.ngRepeatLoad.on ele,attrs
      @onStzNgSrcImageLoaded = (ele, loadingClasses)->
        API.watchers.imagesLoad.on ele, loadingClasses
      return
    link: (scope, ele, attrs) ->
      SETTINGS.IS_DEFAULT_WATCHER_PARAM = if typeof attrs.stzScrollIntoView is 'string' and attrs.stzScrollIntoView isnt '' then false else true
      SETTINGS.IS_IMAGES = if typeof attrs.stzSIVImg isnt 'undefined' then true else false
      SETTINGS.IS_NG_REPEAT = if typeof attrs.stzSIVNgRepeat isnt 'undefined' then true else false
      SETTINGS.PARENT_ID = attrs.stzSIVParentId or ele[0].parentNode
      SETTINGS.SCOPE = scope

      API.init()

      return