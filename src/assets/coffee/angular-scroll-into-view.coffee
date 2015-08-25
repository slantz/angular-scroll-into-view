angular.module('angular.scroll.into.view').directive 'scrollIntoView',
  ($timeout) ->
    restrict: 'A'
    link: (scope, ele, attrs) ->
      scrollToElement = null
      parentId = attrs.parentId or "content"
      imagesLoaded = 0
      allImages = 0
      scrollToElementView = ->
        scrollToElement = document.querySelector "[scroll-into-view-ele='true']"
        if scrollToElement?
          scrollToElement.scrollIntoView true
          document.getElementById(parentId).scrollTop = 0
          imagesLoaded = 0

      scope.$on "ngRepeatFinished", ->
        $timeout ->
          allImages = document.querySelectorAll("[txo-scroll-into-view]").length
        , 0, false

      scope.$on 'ngSrcImageLoaded', (a,b,c)->
        $timeout ->
          if c is "txo-scroll-into-view" and +allImages isnt 0
            if ++imagesLoaded is +allImages
              scrollToElementView()
        , 0 , false
      return