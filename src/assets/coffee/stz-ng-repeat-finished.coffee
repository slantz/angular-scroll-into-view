angular.module('stz.scroll.into.view',[]).directive 'stzLastRepeat',
  ->
    restrict: 'A'
    link: (scope, ele, attrs) ->
      if scope.$last
        scope.$emit 'stzNgRepeatFinished', ele, attrs
      return