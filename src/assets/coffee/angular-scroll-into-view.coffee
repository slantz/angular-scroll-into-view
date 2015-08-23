angular.module('angular.scroll.into.view').directive 'scrollIntoView',
  ($timeout) ->
    restrict: 'A'
    link: (scope, ele, attrs) ->
      loadingClasses = attrs.onImageLoad
      emitLoaded = ->
        $timeout ->
          scope.$emit 'ngSrcImageLoaded', ele, loadingClasses
        , 0
      init = (unbind)->
        if unbind
          ele.unbind 'load'
          ele.unbind 'error'
        if ele[0].tagName.toLowerCase() isnt 'img'
          emitLoaded()
        else
          unless ele[0].complete
            ele.bind 'load', ->
              emitLoaded()
              return
            ele.bind 'error', ->
              emitLoaded()
              return
          else
            emitLoaded()

      if attrs.ngSrc
        attrs.$observe "ngSrc", ->
          init true
      else
        init false

      return