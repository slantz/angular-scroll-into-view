angular.module('stz.scroll.into.view',[]).directive 'stzScrollIntoView',
  ($timeout) ->
    restrict: 'A'
    scope:
      scrollParam: '=stzScrollIntoView'
    link: (scope, ele, attrs) ->
      isDefaultWatcherParam = if typeof attrs.stzScrollIntoView is 'string' and attrs.stzScrollIntoView isnt '' then false else true
      scrollToElement = null
      parentId = attrs.parentId or "content"
      imagesLoaded = 0
      allImages = 0
      init = ->
        scrollToElementView()
        scope.$on "stzNgRepeatFinished", ->
          $timeout ->
            allImages = document.querySelectorAll("[stz-scroll-into-view-ele]").length
          , 0, false

        scope.$on 'stzNgSrcImageLoaded', (a,b,c)->
          $timeout ->
            if c is "stz-scroll-into-view" and +allImages isnt 0
              if ++imagesLoaded is +allImages
                scrollToElementView()
          , 0 , false

      scrollToElementView = ->
        scrollToElement = document.querySelector "[stz-scroll-into-view-ele='#{if isDefaultWatcherParam then 'true' else scope.scrollParam}']"
        if scrollToElement?
          scrollToElement.scrollIntoView true
          document.getElementById(parentId).scrollTop = 0
          imagesLoaded = 0

      unless isDefaultWatcherParam
        scope.$watch 'scrollParam', (n)->
          if angular.isDefined n
            init()
      else
        init()

      return