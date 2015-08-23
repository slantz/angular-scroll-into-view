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
        allImages = +attrs.scrollIntoView

      scope.$on 'ngSrcImageLoaded', (a,b,c)->
        if c is "scroll-into-view-ele" and +allImages isnt 0
          if ++imagesLoaded is +allImages
            $timeout ->
              scrollToElementView()
            , 0 , false
      return