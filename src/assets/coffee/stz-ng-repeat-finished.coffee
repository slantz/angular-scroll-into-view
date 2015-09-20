stzScrollIntoView.directive 'stzLastRepeat',
  ->
    restrict: 'A'
    require: '^?stzScrollIntoView'
    link: (scope, ele, attrs, stzScrollIntoViewCtrl) ->
      if scope.$last
        if stzScrollIntoViewCtrl isnt null
          if typeof stzScrollIntoViewCtrl.onStzNgRepeatFinished is 'function'
            stzScrollIntoViewCtrl.onStzNgRepeatFinished ele, attrs
        else
          scope.$emit 'stzNgRepeatFinished', ele, attrs
      return